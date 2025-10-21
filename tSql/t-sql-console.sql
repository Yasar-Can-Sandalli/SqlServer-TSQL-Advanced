--T SQL

-- CURSOR ?? --> performans farki arastirilacak select ile -->

-- * sorugulari normal sorgulardan daha yavas caslisir , cunku kolon isimlerini almak icin systemcatolog tablosuna select atiyor

-- ROW_NUMBER() satır numarı ile işlem yapmak için kullanırlır


Declare @var varchar(10)
Set @var = 17
print @var

-- Atama islemi Select ile de yaoilabilir

SELECT 'YASAR CAN' +  ' SANDALLI'
SELECT 'YASAR CAN' || ' SANDALLI' --PL SQL --> ORACLE DA

SELECT ProductID , Name FROM Production.Product


SELECT
    Production.Product.Name,
    Production.Product.*
FROM
    Production.Product;


--TODO INSTANCE NAME
    --DB NAME
        --SCHEMA NAME
            -- TABLE NAME
                -- COLUMN NAME


--DISTINCT
SELECT FirstName FROM Person.Person
SELECT DISTINCT FirstName , LastName FROM Person.Person



--UNION

SELECT BusinessEntityID, QuotaDate, SalesQuota
	FROM Sales.SalesPersonQuotaHistory
	WHERE SalesQuota > 0
UNION
SELECT BusinessEntityID, ModifiedDate, SalesQuota
	FROM Sales.SalesPerson
	WHERE SalesQuota > 0
ORDER BY BusinessEntityID DESC, QuotaDate DESC;


--LIKE Kullanimi ve Joker Karakterler

SELECT
	ProductID, Name, ProductNumber
FROM
	Production.Product
WHERE
	Name LIKE 'A[^c]%';

SELECT
	ProductID, Name, ProductNumber
	FROM
	Production.Product
	WHERE
	Name LIKE '%[%]%';


SELECT
	ProductID, Name, ProductNumber
	FROM
	Production.Product
	WHERE
	Name LIKE '%/%';


--	SQL Server'da NULL ve Boþluk Kavrami


SELECT 'Yasar Can' + NULL + 'Sandalli';

SET CONCAT_NULL_YIELDS_NULL OFF; --null ile birlestirilemz ozelligini kapattim

SELECT 'Yasar Can' + NULL + 'Sandalli';

SET CONCAT_NULL_YIELDS_NULL ON;

--	SPACE Fonksiyonu


SELECT 'Yasar Can' + SPACE(1) + 'Sandalli';


SELECT 1 + SPACE(1) + 4;


SELECT 'DIJIBIL' + SPACE(5) + 2013;		-- Hata




--	ISNULL Fonksiyonu --> Buradakilere bi bak

SELECT
	ProductID, Name, Color,
	ISNULL(Color, 'Renk Yok') AS Renk
FROM
	Production.Product;

SELECT
	Weight,
	ISNULL(Weight, 10)
FROM
	Production.Product;



SELECT
	Weight,
	AVG(ISNULL(Weight, 10))
FROM
	Production.Product
GROUP BY Weight;

SELECT
	Weight,
	ISNULL(Weight, 10)
FROM
	Production.Product;



SELECT
	Description, DiscountPct, MinQty,
	ISNULL(MaxQty, 0.00) AS 'Max Miktar'
FROM
	Sales.SpecialOffer;

--	COALESCE Fonksiyonu !!Buraya calis

SELECT
	ProductID, Name,
	COALESCE(Color,'Renk Yok') AS Renk
FROM
	Production.Product;

SELECT
	COALESCE(Title,'Kayýt Yok'),
	FirstName,
	COALESCE(MiddleName,'Kayýt Yok'),
	LastName
FROM
	Person.Person;


SELECT
	Name, Class, Color, ProductNumber,
	COALESCE(Class,
		   Color,
		   ProductNumber) AS FirstNotNull
FROM 	Production.Product;

--	NULLIF Fonksiyonu !!! Buraya calis


SELECT
	MakeFlag, FinishedGoodsFlag,
    	NULLIF(MakeFlag, FinishedGoodsFlag) AS 'Eþitse Null'
FROM
	Production.Product
WHERE
	ProductID < 10;

--	SELECT ile Verileri Siralamak

--- Bu kısımda Cuma namazına gittim ne kaçırdık araştır

--DEFAULT CONSTRAINT nedir ?



--TODO SubQuery

--Tekil değer döndüren ve çoklu değer döndüren alt sorgular



--TODO CASTING -> Tip Donudum

Select 'Urun Kodu : ' + CAST(ProductID AS VARCHAR) + ' Urun Adi: '
+ Name As UrunFullInfo from Production.Product p


DECLARE @deger DECIMAL(5, 2);
SET @deger = 14.53;
SELECT CAST(CAST(@deger AS VARBINARY(20)) AS DECIMAL(10,5));



SELECT CONVERT(DECIMAL(10,5),
CONVERT(VARBINARY(20), @deger));



--TODO	Common Table Expressions(CTE)



--TODO Odev Arastirma
--ROW_NUMBER()
--RANK()
--	DENSE_RANK
--	NTILE
--	TABLESAMPLE


--TODO Pivot Table
--For Ifadadesi

--Pivot satirlari sutuna
--Unpivot sutunlari satira cevirir


--Golabal Temporary Table Sorgu Sonucunu Yeni Tabloda Saklamak


SELECT BusinessEntityID, FirstName, MiddleName, LastName
INTO #personeller --Global Temporary table
FROM Person.Person;


SELECT * FROM #Personeller --Bu Section üzeridnen erişim

--numpy
--pandas
--matplotlib
--stream_lit

--TODO GROUP BY ALL
--Group By ve Group By ALL Arasındaki Fark


--GROUPİNG
--	ROLLUP
--	CUBE

--NO COUNT ON OFF (?? ROW EFECTED)





--TODO View

CREATE VIEW vw_CustomerInfo
AS
SELECT p.BusinessEntityID,
       p.FirstName,
       p.LastName,
       c.CustomerID,
       c.AccountNumber
FROM Person.Person p
         Inner JOIN Sales.Customer c
                    ON p.BusinessEntityID = c.PersonID

Select * from Sales.Customer

--Output Return Değildir































