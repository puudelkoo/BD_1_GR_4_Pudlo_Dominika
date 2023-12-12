
--Zadanie 1
-- zapytanie wykorzystujące wyrażenie CTE, które znajdzie informacje na temat najwyższej stawki w historii płac pracownika 
--oraz wyświetli jego podstawowe dane), a następnie zapisze je do tabeli tymczasowej

WITH MaxSalaryCTE AS (
    SELECT
        person.FirstName,
        person.LastName,
        person.BusinessEntityID,
        MAX(humanresources.EmployeePayHistory.Rate) AS MaxRate
    FROM
        humanresources.EmployeePayHistory
    JOIN
        person.Person ON humanresources.EmployeePayHistory.BusinessEntityID = person.Person.BusinessEntityID
    GROUP BY
        person.FirstName, person.LastName, person.BusinessEntityID
)
SELECT
    MaxSalaryCTE.BusinessEntityID,
    MaxSalaryCTE.FirstName,
    MaxSalaryCTE.LastName,
    MaxSalaryCTE.MaxRate
INTO TempEmployeeInfo
FROM
    MaxSalaryCTE;


--Zadanie 2
--zapytanie wykorzystujące wyrażenie CTE, które wyświetli ID klienta, ID terytorium na którym prowadzi działalność, 
--a także wyświetli imię i nazwisko

WITH CustomerTerritoryCTE AS (
    SELECT
        sales.Customer.CustomerID,
        sales.Customer.TerritoryID,
        person.Person.FirstName,
        person.Person.LastName 
    FROM
        sales.SalesPerson
    JOIN
        sales.SalesTerritory ON sales.SalesPerson.TerritoryID = sales.SalesTerritory.TerritoryID
    RIGHT JOIN
        sales.Customer ON sales.SalesTerritory.TerritoryID = sales.Customer.TerritoryID
    LEFT JOIN
       person.Person ON sales.SalesPerson.BusinessEntityID = person.Person.BusinessEntityID
)
SELECT
    CustomerTerritoryCTE.CustomerID,
    CustomerTerritoryCTE.TerritoryID AS CustomerTerritoryID,
 CustomerTerritoryCTE.FirstName || ' ' || CustomerTerritoryCTE.LastName AS SalesPersonInThisTerritory
FROM
    CustomerTerritoryCTE;
	
	
	
	
	
	