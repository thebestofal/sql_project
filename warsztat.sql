if exists(select * from sys.databases where name='warsztat')
drop database warsztat
go
create database warsztat
go
use warsztat
go
SET DATEFORMAT ymd
go

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='pracownik')
DROP TABLE pracownik;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='klient')
DROP TABLE klient ;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='samochod_klient')
DROP TABLE samochod_klient;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='zlecenie')
DROP TABLE zlecenie;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='samochod_wyp')
DROP TABLE samochod_wyp;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='wypozyczenie_samochod')
DROP TABLE wypozyczenie_samochod;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='zwrot_samochod')
DROP TABLE zwrot_samochod;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='uslugi')
DROP TABLE uslugi;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='czesci')
DROP TABLE czesci;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='czesci_szczegoly')
DROP TABLE czesci_szczegoly;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='zlecenie_szczegoly')
DROP TABLE zlecenie_szczegoly;
go

create table pracownik (
  id_pracownik  int primary key identity(1,1),
  imie          varchar(15)  NOT NULL,
  nazwisko      varchar(20)  NOT NULL,
  pensja        decimal(8,2) NOT NULL,
  telefon       varchar(16)
);
go

create table klient (
	id_klient	int primary key identity(1,1),
	imie		varchar(15) NOT NULL,
    nazwisko	varchar(20)  NOT NULL,
	telefon		varchar(16)
	);
go

create table samochod_klient (
	id_samochod_klient int primary key identity(1,1),
	id_klient			int not null,
	marka				varchar(20),
	model				varchar(20),
	rocznik				int
	);
go

create table zlecenie (
	id_zlecenie		int primary key identity(1,1),
	id_klient		int ,
	id_pracownik	int ,
	id_samochod_klient int,
	status			varchar(10)
	);
go

create table samochod_wyp (
	id_samochod_wyp		int primary key identity(1,1),
	marka				varchar(20),
	model				varchar(20),
	rocznik				int
	);
go

create table wypozyczenie_samochod (
	id_wypozyczenie_samochod	int primary key identity(1,1),
	id_samochod_wyp				int NOT NULL,
	id_klient					int NOT NULL,
	id_pracownik				int NOT NULL,
	data						date
	);
go

create table zwrot_samochod (
	id_zwrotu			     int primary key identity(1,1),
	id_wypozyczenie_samochod int NOT NULL,
	id_pracownik			 int NOT NULL,
	data					 date
	);
go

create table uslugi (
	id_uslugi		int primary key identity(1,1),
	nazwa_uslugi	varchar(250),
	cena			money,
	);
go

create table czesci (
	id_czesci		int primary key identity(1,1),
	nazwa			varchar(50),
	numer_OEM		varchar(30),
	cena			money
	);

go

create table czesci_szczegoly (
	id_zlecenie		int NOT NULL,
	id_czesci		int NOT NULL,
	znizka			real NULL,
	ilosc			smallint default 1
	);
go

create table zlecenie_szczegoly (
	id_zlecenie		int NOT NULL,
	id_uslugi		int NOT NULL,
	znizka			real NULL,
	ilosc		    smallint default 1
	);
go

alter table zlecenie
add foreign key (id_klient)  references klient(id_klient)

alter table zlecenie
add foreign key (id_pracownik) references pracownik(id_pracownik)

alter table wypozyczenie_samochod
add foreign key (id_samochod_wyp) references samochod_wyp(id_samochod_wyp)

alter table wypozyczenie_samochod
add foreign key (id_klient) references klient(id_klient)

alter table wypozyczenie_samochod
add foreign key (id_pracownik) references pracownik(id_pracownik)

alter table zwrot_samochod
add  foreign key (id_wypozyczenie_samochod) references wypozyczenie_samochod(id_wypozyczenie_samochod)

alter table zwrot_samochod
add foreign key (id_pracownik) references pracownik(id_pracownik)

alter table zlecenie_szczegoly
add foreign key (id_zlecenie) references zlecenie(id_zlecenie)

alter table zlecenie_szczegoly
add foreign key (id_uslugi) references uslugi(id_uslugi)

alter table zlecenie_szczegoly
add constraint pk_zlecenie_szczegoly primary key(id_zlecenie, id_uslugi)

alter table czesci_szczegoly
add foreign key (id_zlecenie) references zlecenie(id_zlecenie)

alter table czesci_szczegoly
add foreign key (id_czesci) references czesci(id_czesci)

alter table czesci_szczegoly
add constraint pk_czesci_szczegoly primary key (id_zlecenie, id_czesci)

alter table samochod_klient
add foreign key (id_klient) references klient(id_klient)

alter table zlecenie
add foreign key (id_samochod_klient) references samochod_klient(id_samochod_klient)

insert into klient
values
('Aleksander', 'Kosiñski', '690466564'),
('Anna','Marcinkowska','794430586'),
('Antoni','Soko³owski','739399709'),
('Szymon','Duda','795747126'),
('Iga','Nowakowska','885841979'),
('Grzegorz','Or³owski','690104455'),
('Martyna','Sroka','884764355')

insert into pracownik
values
('Igor','Zieliñski',2000 ,'783845294'),
('Wojciech','Walczak',1600 ,'791631241'),
('Wiktor','Szulc',3500 ,'882717463'),
('Micha³','Nowak',7000 ,'696714242'),
('Anna','Augustyniak',2350 ,'534952527'),
('Bartek','Janik',10000,'727107602')

insert into czesci
values
('kopu³ka', '9ONNG9HD', 30),
('rozrz¹d', '8XEV6JL1', 400),
('œwiece zap³onowe', '6HO3XNA9', 50),
('kable zap³onowe', 'M309OUF', 20),
('uszczelka pod g³owic¹', 'CPS7PMJP', 300),
('pokrywa zaworów', 'O7BUBKB', 300),
('filtr paliwa', 'OWOBP0Q8', 20),
('reflektor', 'BGCRJB78', 60),
('ko³o pasowe', '0NAMD1B', 88),
('zawór EGR', '1OSA3M2H', 35.50),
('pompa paliwa', 'A5G3O6KJ', 50.36),
('klocki hamulcowe', 'DB12Y5P', 20),
('bêbny hamulcowe', 'I1UGG7P6', 50),
('katalizator', 'ONZFE3A9', 300)

insert into uslugi
values
('wymiana rozrz¹du', 600),
('naprawa uk³adu zap³onowego', 200),
('wymiana reflektora', 50),
('wymiana uszczelki pod g³owic¹', 900),
('regulacja zaworów', 300),
('wymiana pokrywy zaworów', 200),
('wymiana filtra paliwa', 30),
('wymiana pompy paliwa', 55.60),
('wymiana ko³a pasowego', 237.60),
('wymiana zaworu EGR', 67.20),
('wymiana klocków hamulcowych', 70),
('wymiana bêbnów hamulcowych', 111.50),
('wymiana katalizatora', 130),
('regeneracja tylnej belki skrêtnej', 800)

insert into samochod_klient
values
(1, 'Skoda', 'Fabia', 2000),
(2, 'Fiat', '500', 2015),
(3, 'Volkswagen', 'Passat', 2001),
(4, 'Daewoo', 'Tico', 1999),
(5, 'Renault', 'Modus', 2010),
(6, 'Renault', 'Modus', 2010),
(7, 'Opel', 'Vectra', 1998),
(3, 'BMW', 'E36', 1995),
(1, 'Peugeot', '206', 2005)

insert into samochod_wyp
values
('Skoda', 'Rapid', 2010),
('Fiat', 'Tipo', 2015),
('Volkswagen', 'Tiguan', 2016),
('Toyota', 'Aygo', 2017),
('Renault', 'Megane', 2013)

insert into zlecenie
values
(1, 1, 1, 'trwajace'),
(1, 2, 9, 'trwajace'),
(2, 1, 2, 'zakonczone'),
(3, 3, 3, 'trwajace'),
(3, 4, 8, 'zakonczone'),
(4, 5, 4, 'zakonczone'),
(5, 4, 5, 'trwajace'),
(6, 2, 6, 'trwajace'),
(7, 3, 7, 'trwaj¹ce')

insert into zlecenie_szczegoly(id_zlecenie, id_uslugi, znizka, ilosc)
values
(1, 3, 20, 3),
(1, 7, 5, default),
(2, 10, 0, default),
(3, 2, 5, default),
(3, 13, 10, default),
(4, 14, 0, default),
(5, 1, 0, default),
(5, 9, 0, default),
(6, 6, 30, default),
(7, 11, 10, 2),
(8, 12, 0, 2),
(9, 4, 10, default)

insert into czesci_szczegoly
values
(1, 8, 0, 3),
(1, 7, 0, default),
(2, 10, default ,default),
(3, 14, default ,default),
(5, 2, default ,default),
(5, 9, default ,default),
(6, 6, default ,default),
(7, 12, default, 2),
(8, 13, default, 2),
(9, 5, default ,default)

insert into wypozyczenie_samochod
values
(1, 1, 1, '2018-01-20'),
(2, 2, 1, '2018-02-12')

insert into zwrot_samochod
values
(1, 3, '2018-02-20'),
(2, 4, '2018-02-21')