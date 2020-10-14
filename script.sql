use master
go
drop database LABWEB_MarketPlace
go
create database LABWEB_MarketPlace
go
use LABWEB_MarketPlace
go
create table Product 
(
	id int identity primary key,
	name nvarchar(500),
	img varchar(100),
	price float,
	description text,
	delivery text,
	quantity int,
)
go
create table Size
(
	id int identity primary key,
	name nvarchar(500),
)
go
create table [Address]
(
	id int identity primary key,
	name nvarchar(500),
	company nvarchar(500),
	addressline1 nvarchar(1000),
	addressline2 nvarchar(1000),
	zip varchar(6),
	city nvarchar(100),
	state nvarchar(100),
	country nvarchar(100),
	phone varchar(11),
	email varchar(100),
	comment text,
)
go
create table Orders
(
	id int identity primary key,
	shipping_address_id int references [Address](id),
	billing_address_id int references [Address](id),
	session_id varchar(32),
	shipping float,
)
go
create table OrderItem
(
	orderID int references Orders(id),
	productID int references Product(id),
	sizeID int references Size(id),
	quantity int,
	unique (orderID, productID, sizeID)
)
go

insert into Product values
('Finger Puppet 1', 'images/product01.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 2', 'images/product02.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 3', 'images/product03.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 4', 'images/product04.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 5', 'images/product05.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 6', 'images/product06.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 7', 'images/product07.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 8', 'images/product08.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 9', 'images/product09.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 10', 'images/product10.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 11', 'images/product11.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 12', 'images/product12.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 13', 'images/product13.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 14', 'images/product14.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10),
('Finger Puppet 15', 'images/product15.jpg', 8.00, 
	'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
	'1-2 business days', 10)
go
insert into Size values
('XS'), ('S'), ('M'), ('L'), ('XL')

go
create table Viewer
(
	total int,
)
insert into Viewer values (2389) 
go
create table Contact
(
	id int identity primary key,
	name nvarchar(500),
	email varchar(300),
	mess text
)
go

select * from Contact

--update Viewer set total = total + 1  

select total from Viewer

select top 1 id from Product order by id desc

select * from Product
select * from OrderItem
select * from Orders
select * from Address

