--TODO AdventureWorks2022
USE AdventureWorks2022
GO
SELECT * FROM Production.Product;

--TODO Aritmatik Operatörler

SELECT 5 + 3;

SELECT 5 + 3 AS Sonuc; --AS ifadesi colon a isim verir.

Select ((5 + 6) * 6) * 2; --132 --AS ifadesi olmadığın kolon isimi yok, <anonymous> gürünür.

--TODO Atama Operatörü Ve Bir Değişkeni SET etme

DECLARE @number  INT;
SET @number = 41;
Select (@number);


--Metin Birleştirme Operatörü

SELECT 'Yaşar Can ' + 'Sandallı';

DECLARE @brand VARCHAR(10)
SET @brand = 'Apple'
DECLARE @model varchar(15)
SET @model = 'Macbook Pro 16'
Select @brand + ' ' + @model;


-- TODO Select İle Kayıtları Seçmek

Select * from Production.Product

                        --Schema Name | Table Name
SELECT ProductID,Name FROM Production.Product;

SELECT Production.Product.Name , Production.Product.*
FROM Production.Product;


--TODO DISTINCT ile Tekrar Eden Verileri Tekile İndirgemek

SELECT DISTINCT FirstName FROM Person.Person;


--TODO UNION Ve UNION ALL İle Sorgu Sonuçları Birleştirmek

SELECT BusinessEntityID , ModifiedDate , SalesQuota
FROM Sales.SalesPerson WHERE SalesQuota > 0
UNION
SELECT BusinessEntityID , QuotaDate , SalesQuota
FROM Sales.SalesPersonQuotaHistory WHERE SalesQuota > 0
ORDER BY BusinessEntityID desc , ModifiedDate desc;


SELECT BusinessEntityID , ModifiedDate , SalesQuota
FROM Sales.SalesPerson WHERE SalesQuota > 0
UNION ALL
SELECT BusinessEntityID , QuotaDate , SalesQuota
FROM Sales.SalesPersonQuotaHistory WHERE SalesQuota > 0
ORDER BY BusinessEntityID desc , ModifiedDate desc;

--TODO Mantıksal Operatörler ile İşlemler Yapmak(AND,OR,EQUALS vs.)

Select * FROM Production.Product
WHERE ProductID = 4 AND Name = 'Headset Ball Bearings';

SELECT * FROM Production.Product
WHERE ProductID = 2 OR Name = 'Freewheel';


SELECT * FROM Production.Product
WHERE ProductID = 2 AND Name = 'Freewheel';

SELECT * FROM Production.Product
WHERE ProductID < 0 OR 1=1;

SELECT * FROM Person.Password
WHERE BusinessEntityID = 99999941 OR 1=1; --SQL Injection


--TODO Karşılaştırma Operatörleri;

SELECT * FROM Production.Product WHERE ProductID < 5;

SELECT * FROM Production.Product WHERE ProductID = 4;

SELECT ProductID, Name FROM Production.Product WHERE ProductID <= 316;

SELECT ProductID, Name FROM Production.Product WHERE ProductID <> 316;
--VEYA
SELECT ProductID, Name FROM Production.Product WHERE ProductID != 316;

--TODO LIKE , NOT LIKE VE Opsiyonel Karakterler

SELECT ProductID, Name FROM Production.Product WHERE Name LIKE '%Ball%'; --içinde Ball geçenler

SELECT * FROM Production.Product WHERE NAME LIKE '%ad%' --içinde ad geçenler;

SELECT ProductID , ProductNumber , Name FROM Production.Product where Name LIKE 'C%'; -- C ile başlayanlar

SELECT ProductID,ProductNumber,Name FROM Production.Product WHERE Name LIKE 'Be%';--Be ile başlayanlar

SELECT ProductID, ProductNumber, Name FROM Production.Product WHERE Name LIKE '%karm'; -- sonu karm ile bitenler


SELECT ProductID, ProductNumber, Name FROM Production.Product WHERE Name LIKE '%hai%'; --içinde hai geçenler

SELECT * FROM Production.Product;

SELECT ProductID, ProductNumber, Name FROM Production.Product WHERE Name LIKE '_eat%';--başında yalnız bir karakter olması zorunlu ve eat ifadesiyle bitenler

SELECT
	ProductID, Name, ProductNumber
FROM
	Production.Product
WHERE
	Name LIKE '[AC]%'; --Baş harfi A veya C olanlar



SELECT
    ProductID , ProductNumber ,Name
FROM
    Production.Product
WHERE
    Name LIKE '[A-C]%'; --Baiz harfleri A,B,C olanlar (A ile C arası yani)


SELECT
	ProductID, Name, ProductNumber
FROM
	Production.Product
WHERE
	Name LIKE 'A[^c]%'; --A ile başlar lakin 2. harf C olamaz


Select
    ProductID,ProductNumber,Name
FROM
    Production.Product
WHERE
    Name LIKE 'A%' OR
    Name LIKE 'D%' OR
    Name LIKE 'T%'; -- Baş harfi A,D veya T olanlar


--Veya başka bir yöntem

SELECT
    ProductID,ProductNumber,Name
FROM
    Production.Product
WHERE
    Name LIKE '[ADT]%';



SELECT
	ProductID, Name, ProductNumber
FROM
	Production.Product
WHERE
	Name LIKE '%[-]%'; --İçinde - (tre) ifadesi geçenler


SELECT
	ProductID, Name, ProductNumber
FROM
	Production.Product
WHERE
	Name LIKE '%-%';


SELECT
    ProductID,ProductNumber,Name
FROM
    Production.Product
WHERE Name LIKE '%[/]%';

/*
aralarında bir fark olmadığını gözlemleyin !!
*/


SELECT
    ProductID,ProductNumber,Name
FROM
    Production.Product
WHERE Name LIKE '%/%';


--sql deyimnde kullanılan % karakteri, herhangi bir karakteri temsil eder.
--Bu karakterin metinde geçip geçmediğini kontrol etmek için [] ifadesi içine aldık
SELECT
    ProductID,ProductNumber,Name
FROM
    Production.Product
WHERE Name LIKE '%[%]%';


SELECT
    ProductID,ProductNumber,Name
FROM
    Production.Product
WHERE
    Name NOT LIKE '%[D-F]%'; --içinde D-F arası harfler olmayanlar



--TODO BETWEEN


SELECT
    ProductID , Name
FROM
    Production.Product
WHERE ProductID BETWEEN 1 AND 441; --Product id si 1 ile 441 arasında olanlar (1 ve 441 dahil !)

--Bir diğer gösterim

SELECT
    ProductID,Name
FROM
    Production.Product
WHERE
    ProductID >=1 AND ProductID <=441;

--Sorgu Performansı Olarak where yerine between kullanmak daha iyi mi ki?

SELECT
    ProductID,Name
FROM
    Production.Product
WHERE
    ProductID NOT BETWEEN 1 AND 441; --Product id si 1 ile 441 arasında olmayanlar (1 ve 441 dahil !)


--TODO IN ve NOT IN

SELECT
    ProductID, ProductNumber, Name
FROM
    PRODUCTION.Product
WHERE
    ProductID IN (1,2,3,4,5); --Product id si 1,2,3,4,5 olanlar (yani id değeri bu kümenin içnde olanlar)

/*
    Bu iki kullanım arasında bi fark yok lakin IN kullanımı OR kullanımı yerine çok daha pratik ve performanslıdır.
*/

SELECT
    ProductID, ProductNumber, Name
FROM
    Production.Product
WHERE ProductID = 1 OR ProductID = 2 OR ProductID = 3 OR ProductID = 4 OR ProductID = 5;


Select
    ProductID, ProductNumber, Name
FROM
    Production.Product
WHERE
    Name IN ('Touring Tire','Road Bottle Cage','Cable Lock');


SELECT
    ProductID, ProductNumber, Name
FROM
    PRODUCTION.Product
WHERE
    ProductID NOT IN (1,2,3,4,5); --Product id si 1,2,3,4,5 olmayanlar (yani id değeri bu kümenin içnde olmayanlar)


SELECT
	ProductID, ProductNumber ,Name
FROM
	Production.Product
WHERE
	'Chainring' IN(Color, Name); -- Chainring ifadesi Color ya da Name kolonlarında yer alıyorsa o satırları getirir


SELECT
    ProductID, ProductNumber, Name , ModifiedDate, SellStartDate
FROM
    Production.Product
WHERE
    '2014-02-08 10:01:36.827' IN (ModifiedDate); --ModifiedDate kolonunda 2014-02-08 10:01:36.827 olanlar
/*
    Bu tarihte değişiklik yapılan ürünler gösterilmek istenirse bu komutu kullanabilirsiniz.
*/

-- TODO SQL Server TSQL de NULL ve Bosluk Kavramları

SELECT 'Yaşar Can' + Null + 'Sandallı';
--TSQL de bir ifade de null varsa işlemin tamamı da null olur.
-- String birleştirme işlemi sırasında NULL değeri “boş” değil, “bilinmeyen” olarak değerlendirilir.

SET CONCAT_NULL_YIELDS_NULL OFF;
-- Bu kod ise null değerleri bilinmeyen olarak değil boş metin olarak döndürü -> (bu  '' gibi)

SELECT 'Yaşar Can' + NULL + 'Sandallı';

SET CONCAT_NULL_YIELDS_NULL ON;
--Tekrar null değerleri bilinmeyen olarak ayarlayalım.



--TODO SPACE Fonksiyonu

SELECT 1+5 AS Sonuc; --AS burada kolona isim vermede kullanılır (alias -> takma isim)


SELECT 1 + SPACE(15) + 5 AS Sonuc;

SELECT 'Yaşar Can' + SPACE(1) + 'Sandallı' AS FULLNAME; -- İki stringin arasına 1 tane bosluk koyduk.


SELECT 'Yaşar Can Sandallı' + SPACE(1) + 2005; -- Hata verir.

/*
    'Operand data type int is invalid for add operator',
    T-SQL'de string (nvarchar/varchar) türü ile int türü doğrudan birleştirilemez.

*/

SELECT 'Yaşar Can Sandallı' + SPACE(1) + '2005';






SELECT
    ProductID, ProductNumber,Name,Color
FROM
    Production.Product
WHERE Color IS NOT NULL; -- Color değeri null olmayanları getirir.


--TODO IS NULL Fonksiyonu


SELECT
    ProductID,ProductNumber,Name,ISNULL(Color,'Renk Yok')
FROM
    Production.Product
WHERE
    Color IS NULL ;



SELECT
    Name , ISNULL(Weight,10)
FROM
    Production.Product;

--IS NULL fonksiyonu burada Weight değeri null olan  kayıtrları bulur ve bu degeri 10 olarak gösterir.
--Lakin bu tablodaki ham veri yi değiştirmez sadece sorguda çalılır.
--yani sorgu sonucunda 10 olarak gösterilen değerler asıl tabloda null dır.




--Bu sorgu üzerinde detaylıca düşünün eğer şaun mevcut bilginzile anlayamadıysan ilerleyen modülllerde biraz daha pratik yaptıktan sonra yine buraya gelin
SELECT
    Weight, AVG(ISNULL(Weight,10))
FROM
    Production.Product
GROUP BY Weight;



SELECT
    Description, DiscountPct, MinQty, ISNULL(MaxQty,0.00) AS MaxxMiktar
FROM
    Sales.SpecialOffer;


--TODO COALESCE Fonksiyonu

SELECT
    Name , Class , Color, ProductNumber , COALESCE(Class, Color, ProductNumber) AS FitstNotNull
FROM
    Production.Product;
--Coalesce fonksiyonu içine parametre olarak verilen kolon adlarında ilk notnull(yani ilk dolu olan) olanı geridöndürür
/*
    Bu fonksiyon ISNULL fonksiyonu içinde barındırır
    (yani parametre olarak verilen tüm kolon ları ISNULL fonksiyonunu tabi tutar daha saonra çıkan değer göre davranır.
    Eğer null değer gelmişse bi sonraki parametreye geçer , eğer notnull değer gelmişse onu geri döndürür , sıralı olarak ilerler )
*/


SELECT
    COALESCE(Title,'Unvan Yok') AS _Title ,FirstName, COALESCE(MiddleName,'Orta Ad Yok') AS _MiddleName, LastName
FROM
    Person.Person;



SELECT
	Name, Class, Color, ProductNumber,
	COALESCE('Class : ' + Class,
		   'Color : ' + Color,
		   'ProductNumber : ' + ProductNumber) AS FirstNotNull
FROM 	Production.Product;



--TODO NULIF Fonksiyonu (Garip Bir Fonksiyon Belki İşinize Yarar xd )

SELECT
    MakeFlag,FinishedGoodsFlag , NULLIF(MakeFlag,FinishedGoodsFlag) AS [null_if_equal]
FROM
    Production.Product
WHERE
    ProductID < 10;



--TODO ORDER BY ile Verileri Sıralamak

SELECT
    ProductID, ProductNumber ,Name
FROM
    Production.Product
Order By Name;
-- kolon adından sonra asc(küçükten-büyüğe veya A dan Z ye) ya da desc(büyükten-küçüğe veya Z den A ya) eklenebilir ama yazmazsınız varsayılan asc olur.



SELECT
    ProductID, ProductNumber ,Name
FROM
    Production.Product
ORDER BY
    ProductID DESC;
--ascending(ASC) , descending(DESC)

SELECT
	ReorderPoint, Name,
	ProductID
FROM
	Production.Product
ORDER BY 3;

--Sondaki 3 ifadesi sıralamayı 3. sütüna göre(Bu örnekte o kolon ProductID) yapması gerektiğini ifade eder.
--Lakin bu kullanım kod okunabilirliği açısından çok tercih edilmez.



--Bu çok garip bi kullanım burada NEWID() fonskiyonunu neden kullandığımız üzeridne düşünün, NEWID nin ne olduğunu bilmiyorsanız sallayın gitsin ... xd
SELECT
	ProductID, Name
FROM
	Production.Product
ORDER BY
	NEWID();


SELECT NEWID() AS _ID;



--TODO TOP oparatörü

SELECT TOP 10 * FROM Production.Product; -- ilk on 10 kaydı getirir.

SELECT TOP 1 PERCENT * FROM Production.Product; --Kayıtların Sadece Yüzde 1 ni getirir
-- Orn: 200 tane kayır varsa sadece 2 kayıt getirir.
-- Eğer yüzde lik karşılık bi tam vermiyorsa (Orn 166 kayıt varsa mesala) o saıyıyı yuvlarlar (1.66 --> 2) ve cikan sayi kadar kayir getirir.
--Ince detay: bu kayitlarlar kullanici tarafindan ya da sistem tarafindan yapilan index sirasina gore gelmektedir.


SELECT TOP 5
    BusinessEntityID , FirstName , LastName
FROM
    Person.Person
WHERE
    FirstName LIKE 'A%';

--TODO TOP fonksiyonu

SELECT
	TOP(5) WITH TIES *
FROM
	Production.Product
ORDER BY
	ProductID;

--Aslinda iki kullanimda farksiz sadece TOP aperatoru SQL in kendisinde olan bir sey (yani ANSI SQL)
--TOP fonksiyonu ise T-SQL olan bir kullanimdir.

SELECT
	TOP(5) PERCENT WITH TIES *
FROM
	Production.Product
ORDER BY
	ProductID;
--Gene yuzdelikli olarakta kullanilabilir.



--TODO JOIN ifadeleri ile Tablolari Birlestirmek.

/*
    Bu kisim biraz karisik ve bir hayli onemli bu yuzden dikkatle ilerlemenizi
    ve bir kod blogunu anlamadan digerine gecmemenizi siddetle tavsiye ederim.
*/

/*
    Bu kısımda birden fazla tabloları ve bu tablolarda bulunana belli başlı kolonları birlestirmeyi göreceğiz.
    Bu işlem bazan tüm kolonları birleştirmek üzerinde de olabilir ya da bazende sadece belirli 3-5 kolonu birlestirmek te olabilir.
*/

--Manuel,Klasik Birleştirme


SELECT
    sod.ProductID, ProductNumber , p.Name
FROM
    Sales.SalesOrderDetail AS sod , Production.Product AS p

--T-SQL de FROM dan sonra birden fazla tablo adı gelebilir

/*
    Burada AS ifadesi kullanılarak tablolara takma isim verilmiştir (sod ve p).

    sod.ProductID ifadesi SalesOrderDetail tablosunda bulunan ProductID kolonunu temsil eder.
    p.Name ifadesi Production tablosunda bulunan Name kolonunu temsil eder.
*/

/*
    Eğer from dan sonra alias (takma isim) kullanmak istemezseniz
    Aşağıdaki örnekte olduğu gibi kolonların hangi semanın altındaki hangi tablodan geldiğini açıkça ve uzun uzadıya belirtmeniz gerekebilir.
*/

SELECT
    Sales.SalesOrderDetail.ProductID, Production.Product.ProductNumber , Production.Product.Name
FROM
    Sales.SalesOrderDetail , Production.Product;


--TODO Option (Merge Join)

SELECT S.CountryRegionCode, S.StateProvinceCode,
	   T.TaxType, T.TaxRate
FROM Person.StateProvince AS S
LEFT OUTER JOIN Sales.SalesTaxRate AS T
ON S.StateProvinceID = T.StateProvinceID
OPTION (MERGE JOIN) --Bu kodu açıklamayacağım kendiniz araştırın !!!



--TODO INNER JOIN
/*
   Sadece Her iki tablo da bulunan/eşleşen kayırtları geritirir.
*/

SELECT * FROM Person.Person;  --!!! Aşağıdaki açıklamaları okumadan önce tabloları tek başına çağırın ve inceleyin!!!
SELECT * FROM Person.PersonPhone;

SELECT
    P.FirstName, P.LastName, PP.PhoneNumber
FROM
    Person.Person P
INNER JOIN
     Person.PersonPhone PP
ON
    P.BusinessEntityID = PP.BusinessEntityID;


--TODO LEFT JOIN

/*
    Soldaki tabloda bulunan her kaydı ve buna bağlı sağdaki tabloda eşleşen kayırları geitrir.
    Eğer sağdaki tabloda eşleşen kayıt yoksa Null değer(ler) döner.
    Örnek üzeriden daha iyi anlayacaksınız.
*/



SELECT ProductID,Name,ProductNumber FROM Production.Product;
SELECT SalesOrderID, ProductID, UnitPrice FROM Sales.SalesOrderDetail;

SELECT
    P.ProductID, P.Name, P.ProductNumber, SOD.SalesOrderID, SOD.UnitPrice
FROM
     Production.Product P
LEFT JOIN
    Sales.SalesOrderDetail SOD
ON
    P.ProductID = SOD.ProductID;
/*
    Bazı öyle productlar varki hiç bir siparişte geçmiyorlar (yani bu ürünlerden henüz kimse sipariş vememiş olabilir yeni çıkmışlardır belki)
    bu yüzden SalerOrderDetail tablosunda sipariş karşılıkları yok ve
    SalesOrderDetail tablosundan gelen UnitPrice kolonunda bu değerler NULL olarak gözüküyor.
*/



SELECT * FROM Sales.Customer;
SELECT * FROM Sales.SalesOrderHeader;
SELECT * FROM Person.Person;

SELECT
    C.CustomerID, P.FirstName, P.LastName, O.OrderDate
FROM
    Sales.Customer AS C
LEFT JOIN
        Sales.SalesOrderHeader AS O
ON
        C.CustomerID = O.CustomerID
LEFT JOIN
        Person.Person AS P
ON
    C.PersonID = P.BusinessEntityID

/*
    Bu örnekte tüm müşterileri listeliyoruz ve eğer bir müşteri ait bir sipariş varsa
    Bu sipariş bilgileride müşteririyle birleştirilerek gelmektedir.
    Eğer bir müşteri ait sipariş bilgisis yoksa OrderData sütünü null değer döndürecektir(sipariş yoksa sipariş tarihide olamayacağından !).

    Eğer Left Join Yerine Inner Join kullansaydık sadece sipariş vemiş müşteriler ile sipariş bilgeileri gelicekti (yani sadece eşleşen kayıtlar).
*/





SELECT * FROM Sales.Customer;
SELECT * FROM Sales.SalesOrderHeader;
SELECT * FROM Person.Person;

SELECT
    S.Name AS StoreName, P.FirstName + ' ' + P.LastName AS ContactName, O.TotalDue
FROM
    Sales.Store AS S
LEFT JOIN
        Sales.Customer AS C
ON
        S.BusinessEntityID = C.StoreID
LEFT JOIN
        Person.Person AS P
ON C.PersonID = P.BusinessEntityID
LEFT JOIN
    Sales.SalesOrderHeader AS O
ON
    C.CustomerID = O.CustomerID;

/*
    Tüm mağazalar listeler
    Sipariş yapılmamış mağzalar için satış bilgileri NULL olur.
*/




--TODO LEFT OUTER JOIN

/*
    LEFT OUTER JOIN , LEFT JOIN ile tamamen aynıdır -> OUTER kelimesi yazilmasi opsiyonel bir kelimedir
    ikiside ayni şekildedir yani xd...
*/

SELECT
    C.CustomerID, P.FirstName, P.LastName ,CR.CardNumber AS CreditCardNumber
FROM
    Sales.Customer AS C
LEFT OUTER JOIN
        Person.Person AS P
ON
        C.PersonID = P.BusinessEntityID
LEFT OUTER JOIN
    Sales.PersonCreditCard AS PC
ON
    P.BusinessEntityID = PC.BusinessEntityID
LEFT OUTER JOIN
        Sales.CreditCard AS CR
ON
    PC.CreditCardID = CR.CreditCardID;

/*
    Tüm müşterileri listeler
    müşteriler tablosundanki tüm kayırları KişiKrediKartları tablosu ile birleştirir
    Kredi kartı olmayan müşterilelerin CreditCardNumber bilgisi NULL olur.


    KISCA:
    “LEFT OUTER JOIN” sadece “LEFT JOIN”in uzun halidir.
    İkisi de sol tablodaki tüm kayıtları getirir, sağ tarafta eşleşme yoksa NULL döner.
*/



/*
    Şimdi INNER İle LEFT arasındaki farkı anlamanız için güzel bir örnek bırakıyorum

    --> Sorgunun hem left hemde inner halini  dikkatle inceleyiniz
*/

/* Referans: Her iki tablonun ham verisini gör (karşılaştırmayı kolaylaştırır). */
SELECT * FROM Person.StateProvince;
SELECT * FROM Sales.SalesTaxRate;

--LEFT OUTER JOIN: Sol tablodaki (StateProvince) TÜM satırları getirir. SalesTaxRate’te eşleşme yoksa T.TaxType/T.TaxRate = NULL olur.
SELECT S.CountryRegionCode, S.StateProvinceCode,
	 T.TaxType, T.TaxRate
FROM Person.StateProvince AS S
LEFT OUTER JOIN Sales.SalesTaxRate AS T
ON S.StateProvinceID = T.StateProvinceID;



--INNER JOIN: SADECE eşleşen satırlar gelir. Vergi kaydı olmayan eyalet/bölgeler SONUÇTA YOKTUR.
SELECT S.CountryRegionCode, S.StateProvinceCode,
     T.TaxType, T.TaxRate
FROM Person.StateProvince AS S
INNER JOIN Sales.SalesTaxRate AS T
ON S.StateProvinceID = T.StateProvinceID;


-- Kaç satır farkı var? (LEFT tüm S’yi getirir; INNER sadece eşleşenleri)
