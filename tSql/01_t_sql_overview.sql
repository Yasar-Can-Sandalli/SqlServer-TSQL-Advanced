--TODO AdventureWorks2022
--TODO Bu Başlıklar Overview İçin Açıklanacak
--Sql Nedir , T-SQL Nedir ? , Arasındaki farklar nelerdir ?
--Veritabanı Nedir
--İlişkisel Veritabanı Nedir ? (RDBMS - SQL)
--İlişkisel Olmayan VeriTabanı Nedir ? (NO RDBMS - NoSQL)
--SQL VS NoSQL ?
--Structured VS Unstructured ?
--ANSI SQL Nedir ?
--SQL, T-SQL ve Veritabanı Programlama

--MS SQL SERVER Database Analysis Services
--MS SQL SERVER Database Integration Services
--MS SQL SERVER Database Reporting Services
-- .bak(backup file) -> .mdf(meta data file) + .ldf (log data file)
--Cihan Özhan YouTube Detaylı İnceleme
-- SQL VeriTabanı Türleri (1 den fazla tür yok ama araştıralım gene...)
--NoSQL VeriTabanı Türleri  ( Document(JSON)(MongoDB!) , Graph(Sosyal Medyada çok kullanılıyor) , Key-Value(Redis)(Cage), Wide-Column(Cassandra))

--SQL COMMANDS | DDL DQL DML DCL and TCL Commands
    --DDL (Data Definition Language) -> Veri üzerinde değil Nesne Üzerinde Çalışır (Table, View, Stored Procedure, Function, Trigger vs.)
        --CREATE
        --ALTER
        --DROP
        --TRUNCATE (Veri Bütünlülüğünü Dikkate Almaz , Constraint leri hiçe sayar)
        --RENAME
        --REVOKE
        --GRANT
    --DQL (Data Query Language)
        --SELECT
    --DML (Data Manipulation Language) -- Veri Üzerinde Çalışır
        --INSERT
        --UPDATE
        --DELETE (Veri Bütünlülüğünü Dikkate Alarak Siler, Constraint ler ile uyumludur)
    --DCL (Data Control Language)
        --GRANT
        --REVOKE
        --DENY
    --TCL (Transaction Control Language)
        --COMMIT
        --ROLLBACK
        --SAVEPOINT
        --BEGIN TRANSACTION
        --END TRANSACTION
        --SET TRANSACTION ISOLATION LEVEL


use AdventureWorks2022 --Uzerinde Çalışmak istediğimiz veritabanı
GO
Declare @name varchar(50) --Tanımlama ( Declaration )
set @name = 'SANDA' --Atama ( Assignment )
print(@name) -- Yazdırma ( Print )
GO


USE master
CREATE DATABASE KodLab -- Yeni veri Tabanı Oluşturma (Bu kod varsayılan ayarlar ile veritabanını oluşturur)



CREATE DATABASE SandaBank
ON PRIMARY --Verinin Saklancağı Dosyanın Ayarları
(
    NAME = 'SandaBank_Data', --Digital Name alanı
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SandaBank_Data.mdf', --Fizilsel Dosyanın Adı Ve Nerede Oluşturulacağı
    SIZE = 21632KB, --Bu Dosaynın Başlangıç Boyutu yani ilk oluşturulduğunda ki boyutu (21 megabyte)
    MAXSIZE = UNLIMITED, --Bu Dosaynın Maksimum Boyutu (Sonsuz)
    FILEGROWTH = 16384KB --Bu verilerin bulunduğu doysa (.mdf) dosyası sınırını yaklaşınca dosya boyutunu 16megabayt daha büyüt

    /*
        Veri Dosyasını(yani .mdf) ilk 21MB büyüklüğünde oluşturduk lakin veriler eklendikçe artık dosya boyutunun artık yeterli olayabilir
        yani sınıra ulaşmış olabiliriz , bu durumda dosya boyutunu 16MB daha büyütüyoruz.

        varsayalımki veri tabanına bir sürü kayıt ekledik ve 21mb lık dosya büyüklüğünü doldurdurk (yani .mdf dosyası full doldu)
        lakin biz kayıt eklemeye devam etmek istiyoruz , bu durumda FILEGROWTH ifadesi ile dosya büyüklüğünü 16MB daha arttır diyoruz.
        istersek bu arttırmayı olayını  bi noktada durdurabiliriz (Örneğin 1TB de dursun isteyebiliriz) bunuda MAXSIZE ifadesi ile yapıyoruz.
        Bu örnekte max size sonsuz olarak ayarlanmıştır.

    */

)
LOG ON
( --Log ların Bulunduğu Dosyasının Ayarı , (parametrelerin kullanımı ve ifadesi aynı şekildedir !)
    NAME = 'SandaBank_Log',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SandaBank_Log.ldf',
    SIZE = 2048KB,
    MAXSIZE = 2048GB,
    FILEGROWTH = 16384KB
)


EXEC sp_helpdb 'SandaBank' --Sistemde hali hazırda bulunan sp_helpdb prosedürü ile oluşturulan veritabanı hakkında bilgi alabilirsiniz.
EXEC sp_helpdb 'AdventureWorks2022'


--TODO CREATE TABLE ifadesi ile tablo oluşturma

SELECT * FROM Person.PersonPhone; -- * ifedesi sistemin veri tabanın da oluşturduğumuz tabloya ait kayıttaki tüm kolon isimlerini getirir (yani * kullanmaka arka planda bir select işleminde yapılmasına sebep olur bu yüzden performanslı değildir)
SELECT BusinessEntityID,PhoneNumber,PhoneNumberTypeID,ModifiedDate FROM Person.PersonPhone; -- (bu iki ifade aynı sonucu verir)

use AdventureWorks2022
GO
CREATE TABLE SandaBankEmployees(
    user_id INT NOT NULL,
    user_first_name VARCHAR(50) NOT NULL,
    user_last_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    user_phone_number VARCHAR(11) NOT NULL,
)

EXEC sp_help 'SandaBankEmployees' --Tablo bilgisi


--TODO ALTER ifadesi ile VeriTabanı Yapsını Değiştirmek

EXEC sp_helpdb SandaBank

ALTER DATABASE SandaBank
MODIFY FILE
(
    NAME = SandaBank_Data,
    SIZE = 300MB
)

EXEC sp_helpdb SandaBank

--TODO Allter ile Tablo Yapısını Değiştirmek

EXEC sp_help 'SandaBankEmployees'

ALTER TABLE SandaBankEmployees
ADD
user_address VARCHAR(100) NOT NULL,
user_registration_date DATETIME NOT NULL Default GETDATE();


--TODO Drop ile Veri Tabanını Silmek
use AdventureWorks2022
GO
Drop Database SandaBank


--TODO Drop ile Tablo Silmek
Use SandaBank
GO
DROP TABLE SandaBankEmployees


--TODO Insert ile Veri Eklemek

--Tablo ve veri tabanını sildik ama eski kodları çalıştırıp veritabanı ve tablosunu tekrar oluşturalım çünkü veri ekleyeceğiz.

INSERT INTO SandaBankEmployees values (1,'Yaşar Can','Sandallı','sandalliyasarcan@gmail.com','0512 345 6789', 'Kocaeli/Gebze')
INSERT INTO Person.Person values (20000,'EM',false,'MR .','Yaşar','Can','Sandallı',null,1,null,'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"><TotalPurchaseYTD>4678.06</TotalPurchaseYTD><DateFirstPurchase>2002-03-31Z</DateFirstPurchase><BirthDate>1947-09-21Z</BirthDate><MaritalStatus>M</MaritalStatus><YearlyIncome>greater than 100000</YearlyIncome><Gender>M</Gender><TotalChildren>4</TotalChildren><NumberChildrenAtHome>5</NumberChildrenAtHome><Education>Partial High School</Education><Occupation>Professional</Occupation><HomeOwnerFlag>1</HomeOwnerFlag><NumberCarsOwned>3</NumberCarsOwned><CommuteDistance>10+ Miles</CommuteDistance></IndividualSurvey>','F3A3F6B4-AE3B-430C-A754-9F2231BA6FEA',GETDATE())


--TODO Select ile Veri Seçmek

Use SandaBank
GO
SELECT * FROM SandaBankEmployees


USE SandaBank
GO
SELECT user_id,user_first_name,user_last_name,user_email,user_phone_number FROM SandaBankEmployees


--TODO Update ile Veri Güncellemek

Use SandaBank
GO
UPDATE SandaBankEmployees SET user_address = 'Kocaeli/Gebze' -- WHERE ifadesi olmadan güncellemek  tablo içerisindeki tüm kayıtları günceller.

UPDATE SandaBankEmployees SET user_phone_number = '0512 345 6789' WHERE user_id = 1

Use AdventureWorks2022
UPDATE Person.Person SET FirstName = 'Yaşar' , MiddleName = 'Can' , LastName = 'Sandallı' where BusinessEntityID = 1;

--TODO Delete ile Veri Silmek

DELETE from SandaBankEmployees -- WHERE ifadesi olmadan silmek tüm tablo içerisindeki kayıtları silecektir.

Use SandaBank
GO
Delete FROM SandaBankEmployees WHERE user_id = 41;

Use AdventureWorks2022
GO
DELETE FROM Person.Person WHERE BusinessEntityID = 41;


--TODO Bu bölümde bahsedilmesi henüz daha kararlaştırılmayan diğer Keyword ler
    --GRANT (Yetkilendirme)
    --WITH GRANT OPTION (Basamaklı Yetkilendirme)
    --DENY (Erişimi Kısıtlamak)
    --REVOKE (Erişim Tanımını Kaldırmak)
    --SQL SERVER ROWNUMBER() fonksiyonu