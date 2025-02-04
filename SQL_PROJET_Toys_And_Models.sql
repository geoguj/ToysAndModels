
# By Georgeta|Allain|Acheck|Eliot|

#1.Ventes : Le nombre de produits vendus par catégorie et par mois, avec comparaison et-------------------------------
# taux de variation par rapport au même mois de l'année précédente.
--taux de variation formule
--([nouvelle valeur - ancienne valeur] / ancienne valeur) x 100.

CREATE VIEW KPI_VENTES_CATEGORIE_MOIS_COMPAIRAISON
AS 
WITH CTE1
AS
(
    SELECT  SUM(ORDL.quantityOrdered) NombreProduitsVendus
            ,PRD.productline Categorie  
            ,YEAR(ORD.orderdate) as OrderDateAnnee
            ,MONTH(ORD.orderdate) as OrderDateMois
    FROM orders ORD
    INNER JOIN orderdetails ORDL ON ORD.orderNumber = ORDL.orderNumber
    INNER JOIN products PRD ON ORDL.productCode = PRD.productCode
    WHERE STATUS IN ('shipped', 'resolved')
    GROUP BY Categorie, OrderDateAnnee, OrderDateMois
    ORDER BY OrderDateAnnee DESC, OrderDateMois DESC
    ),
CTE2 
AS
(   SELECT NombreProduitsVendus
        ,Categorie
        ,OrderDateAnnee
        ,OrderDateMois
        ,LAG(NombreProduitsVendus) over (PARTITION BY Categorie, OrderDateMois order by Categorie,OrderDateAnnee,OrderDateMois) as NombreProduitsAnneePrecedente
    FROM CTE1
)
SELECT * ,((NombreProduitsVendus - NombreProduitsAnneePrecedente)/NombreProduitsAnneePrecedente)*100 as TauxVariation
FROM CTE2;

#2.Finances : ---------------------------------------------------------------------------------------------------
#Le chiffre d'affaires des commandes des deux derniers mois par pays.
CREATE VIEW KPI_FINANCES_CA_2_DERNIERS_MOIS_PAR_PAYS
AS 
WITH CTE AS
(
    SELECT  CUS.country Pays
            ,SUM(OD.quantityOrdered*OD.priceEach) CA
            ,YEAR(O.orderdate) as OrderDateAnnee
            ,MONTH(O.orderdate) as OrderDateMois
    FROM orders O
    INNER JOIN customers CUS ON O.customerNumber= CUS.customerNumber
    INNER JOIN orderdetails OD ON OD.orderNumber = O.orderNumber
    WHERE O.status in ('shipped', 'resolved')
    GROUP BY  CUS.country, OrderDateAnnee, OrderDateMois
    ORDER BY CUS.country desc , OrderDateAnnee desc, OrderDateMois desc
), 
CTE2 AS(
    SELECT *
        ,RANK() over (PARTITION BY Pays order by OrderDateAnnee desc,  OrderDateMois desc) as my_rank
    FROM CTE
)
SELECT Pays
        ,CA
        ,OrderDateAnnee
        ,OrderDateMois
FROM cte2
WHERE my_rank IN (1,2)

#Les commandes qui n'ont pas encore été payées
CREATE VIEW KPI_FINANCES_COMMANDES_NON_PAYEES
AS 
SELECT  DISTINCT O.ordernumber
        ,O.status
        ,CUS.country 
        ,O.orderdate
FROM ORDERS O
INNER JOIN customers CUS ON O.customerNumber= CUS.customerNumber
WHERE O.status in ('on hold');

#3.Logistique : Le stock des 5 produits les plus commandés.------------------------------------------------------
CREATE VIEW KPI_LOGISTIQUE_5PRODUITS_PLUS_COMMANDES
AS 
SELECT SUM(ODD.quantityOrdered) TotalVendu,
        PR.productname NomProduit,
        PR.quantityInStock Stock
FROM orderdetails ODD
INNER JOIN products PR ON ODD.productcode = PR.productcode
GROUP BY NomProduit, Stock
ORDER BY TotalVendu  DESC
LIMIT 5;

#4.Ressources Humaines : Chaque mois, les 2 vendeurs ayant le plus haut chiffre d'affaires.----------------------
CREATE VIEW KPI_RESSOURCES_HUMAINES_2_VENDEURS_PLUS_HAUT_CA
AS 
WITH CTE 
AS
(
    SELECT  EMP.employeeNumber EmpNumber
            ,EMP.lastName NOM
            ,EMP.firstName PRENOM
            ,SUM(priceeach * ORDL.quantityOrdered) TotalPriceOrders
    FROM orderdetails ORDL
    INNER JOIN orders ORD 
        ON ORDL.orderNumber = ORD.orderNumber
    INNER JOIN customers CUST 
        ON ORD.customerNumber = CUST.customerNumber
    INNER JOIN employees EMP 
        ON CUST.salesRepEmployeeNumber = EMP.employeeNumber
    WHERE MONTH(ORD.orderDate) = MONTH(ADDDATE(CURDATE(), INTERVAL -1 MONTH)) 
    GROUP BY  ORDL.OrderNumber, EMP.employeeNumber
    ORDER BY EMP.lastName, EMP.firstName, ORD.orderNumber
)
SELECT SUM(TotalPriceOrders) ChiffreAffaires
    ,NOM
    ,PRENOM
FROM CTE
GROUP BY EmpNumber
ORDER BY ChiffreAffaires DESC
LIMIT 2;

--RH---------
CREATE VIEW KPI_RESSOURCES_HUMAINES_VENDEURS_Total_CA
AS 
WITH CTE 
AS
(
    SELECT  EMP.employeeNumber EmpNumber
            ,EMP.lastName NOM
            ,EMP.firstName PRENOM
            ,SUM(priceeach * ORDL.quantityOrdered) TotalPriceOrders
    FROM orderdetails ORDL
    INNER JOIN orders ORD 
        ON ORDL.orderNumber = ORD.orderNumber
    INNER JOIN customers CUST 
        ON ORD.customerNumber = CUST.customerNumber
    INNER JOIN employees EMP 
        ON CUST.salesRepEmployeeNumber = EMP.employeeNumber
    WHERE MONTH(ORD.orderDate) = MONTH(ADDDATE(CURDATE(), INTERVAL -1 MONTH)) 
    GROUP BY  ORDL.OrderNumber, EMP.employeeNumber
    ORDER BY EMP.lastName, EMP.firstName, ORD.orderNumber
)
SELECT SUM(TotalPriceOrders) ChiffreAffaires
    ,NOM
    ,PRENOM
FROM CTE
GROUP BY EmpNumber
ORDER BY ChiffreAffaires DESC;


--EXECUTER LES VUES-----------------------------
SELECT * FROM KPI_VENTES_CATEGORIE_MOIS_COMPAIRAISON
order by TauxVariation DESC;
SELECT * FROM KPI_FINANCES_CA_2_DERNIERS_MOIS_PAR_PAYS;
SELECT * FROM KPI_FINANCES_COMMANDES_NON_PAYEES;
SELECT * FROM KPI_LOGISTIQUE_5PRODUITS_PLUS_COMMANDES;
SELECT * FROM KPI_RESSOURCES_HUMAINES_2_VENDEURS_PLUS_HAUT_CA;

--127.0.0.1:3306
--toys_and_models;