create database Commerce
use Commerce

create table Brands (
ID int identity primary key,
[Name] varchar (50) not null
)
insert into Brands 
values
('Apple'),
('Acer'),
('Xiaomi'),
('Lenovo'),
('HP'),
('Samsung'),
('Asus'),
('Dell')




create table Laptops (
ID int identity(20,1) primary key,
[Name] varchar (50) not null,
Price decimal,
BrandID int foreign key references Brands(ID) not null
)

insert into Laptops
values 
('Macbook Air M2',2500,1),
('Dell XPS',1300,8),
('Acer Swift 3',2000,2),
('Asus ROG',1500,7),
('HP Pavillion',800,5),
('Lenovo Yoga',3000,4),
('Lenovo ThinkPad',2600,4),
('HP Envy',1800,5)

----

create table Phones (
ID int identity(10,1) primary key,
[Name] varchar (50) not null,
Price decimal,
BrandID int foreign key references Brands(ID) not null
)

insert into Phones
values 
('Iphone 13',2000,1),
('Iphone 15Pro',3000,1),
('Xiaomi Redmi',800,3),
('Samsung Galaxy Fold',1800,6),
('Samsung Galaxy S23',1200,6),
('Lenovo K3 Note',800,4),
('Lenovo Vibe K5',600,4),
('Iphone 14Pro',2700,1)

select * from Brands
select * from Laptops
select * from Phones

--- 3)Laptops Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
select b.Name as BrandName, l.Name as LaptopName,l.Price 
from Brands b
inner join Laptops l on b.ID=BrandID;


--4)Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.

SELECT b.Name as BrandName, p.Name as PhoneName,p.Price 
FROM Brands b
inner join Phones p on b.ID=BrandID;

--5) Brand Adinin Terkibinde s Olan Butun Laptoplari Cixardan Query.

SELECT * FROM Brands
WHERE name LIKE '%s%';

--6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Laptoplari Cixardan Query.

SELECT  l.Name, l.Price
FROM Laptops l
INNER JOIN Brands b ON l.BrandID = b.ID
WHERE
Price BETWEEN 2000 AND 5000;




select Price from Laptops where price >1000;

--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.


select  p.Name, p.Price
from Phones p
INNER JOIN Brands b on p.BrandID = b.ID
where
Price BETWEEN 1000 AND 1500;


select Price  from Laptops Laptops where price >1500;


-- 8) Her Branda Aid Nece dene Laptop Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.

select Brands.Name, COUNT(Laptops.ID) as LaptopCount
from Brands
LEFT JOIN Laptops on Brands.ID = Laptops.BrandID
GROUP BY Brands.Name;

--9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
 
select Brands.Name, COUNT(Phones.ID) as PhoneCount
from Brands
LEFT JOIN Phones ON Brands.ID = Phones.BrandID
GROUP BY Brands.Name;


--10) Hem Phone Hem de Laptoplda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.

select b.ID as 'BrandID', b.Name as 'BrandName', p.Name as 'PhoneModel',l.Name as 'LaptopsModel'
from Brands b
join Phones p on b.ID=p.BrandID
join Laptops l on b.ID = l.BrandID

--11) Phone ve Laptop da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.

--select *from Phones
--left join Brands on Brands.ID=Phones.BrandID
	
select
    p.ID as Id,
    p.Name as Name,
    p.Price,
	p.BrandID
from Phones p
join Brands b on p.BrandId = b.ID
union 
select
    l.ID as Id,
    l.Name,
    l.Price,
	l.BrandID
from Laptops l
join Brands b on l.BrandId = b.ID


--12) Phone ve Laptop da Id, Name, Price, ve Brandin Adini 
--BrandName kimi Olan Butun Datalari Cixardan Query.

select
    p.ID as Id,
    p.Name as Name,
    p.Price,
	p.BrandID,
	b.Name as 'BrandName'
from Phones p
join Brands b on p.BrandId = b.ID
union ALL
select
    l.ID as Id,
    l.Name,
    l.Price,
	l.BrandID,
	b.Name as 'BrandName'
from Laptops l
join Brands b on l.BrandId = b.ID

--13) Phone ve Laptop da Id, Name, Price, ve Brandin Adini
--BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.

select
    p.ID as Id,
    p.Name as Name,
    p.Price,
	p.BrandID,
	b.Name as 'BrandName'
from Phones p
join Brands b on p.BrandId = b.ID
where price>1000
union ALL
select
    l.ID as Id,
    l.Name,
    l.Price,
	l.BrandID,
	b.Name as 'BrandName'
from Laptops l
join Brands b on l.BrandId = b.ID
where price>1000



--14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi 
--(BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve
--Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan

select b.Name, Sum(p.Price) as TotalPrice , COUNT(b.name) as ProductCount
from Brands b
JOIN Phones p on b.ID = p.BrandID
GROUP BY b.Name;


---15) Laptops Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), 
--Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , 
--Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den
--Cox Olan Datalari Cixardan 

select b.Name, Sum(p.Price) as TotalPrice , COUNT(b.name) as ProductCount
from Brands b
JOIN Phones p on b.ID = p.BrandID
GROUP BY b.Name
HAVING
    COUNT(b.Name) > 1;