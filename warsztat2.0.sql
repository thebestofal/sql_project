if exists(select * from sys.databases where name='warsztat')
drop database warsztat
go
create database warsztat
go
use warsztat
go
SET DATEFORMAT ymd
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
	status			varchar(10),
	data_roz        date,
	data_zak        date default NULL
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



create table czesci (
	id_czesci		int primary key identity(1,1),
	nazwa			varchar(50),
	numer_OEM		varchar(30),
	cena			money,
	w_magazynie     int
	);

go

create table czesci_szczegoly (
	id_zlecenie		int NOT NULL,
	id_czesci		int NOT NULL,
	znizka			real default 0,
	ilosc			smallint default 1
	);
go

create table uslugi (
	id_uslugi		int primary key NOT NULL,
	id_zlecenie		int NOT NULL,
	nazwa			varchar(100) NOT NULL,
	cena			money,
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

alter table uslugi
add foreign key (id_zlecenie) references zlecenie(id_zlecenie)


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
('kopu³ka', '9ONNG9HD', 30, 200),
('rozrz¹d', '8XEV6JL1', 400, 56),
('œwiece zap³onowe', '6HO3XNA9', 50, 66),
('kable zap³onowe', 'M309OUF', 20, 230),
('uszczelka pod g³owic¹', 'CPS7PMJP', 300, 55),
('pokrywa zaworów', 'O7BUBKB', 300, 245),
('filtr paliwa', 'OWOBP0Q8', 20, 6),
('reflektor', 'BGCRJB78', 60, 66),
('ko³o pasowe', '0NAMD1B', 88, 5),
('zawór EGR', '1OSA3M2H', 35.50, 23),
('pompa paliwa', 'A5G3O6KJ', 50.36, 5),
('klocki hamulcowe', 'DB12Y5P', 20, 6),
('bêbny hamulcowe', 'I1UGG7P6', 50, 48),
('katalizator', 'ONZFE3A9', 300, 66)


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
(1, 1, 1, 'trwajace', '2017-03-01', default),
(1, 2, 9, 'trwajace', '2017-05-06', default),
(2, 1, 2, 'zakonczone', '2017-05-25', '2017-05-26'),
(3, 3, 3, 'trwajace', '2017-06-13', default),
(3, 4, 8, 'zakonczone', '2017-07-25', '2017-07-26'),
(4, 5, 4, 'zakonczone', '2017-08-29', '2017-08-30'),
(5, 4, 5, 'trwajace', '2017-09-10', '2017-09-20'),
(6, 2, 6, 'trwajace', '2017-10-20', default),
(7, 3, 7, 'trwajace', '2017-11-15', default)

insert into uslugi(id_zlecenie, id_uslugi, nazwa, cena, znizka, ilosc)
values
(1, 1, 'wymiana uszczelki pod g³owic¹', 900, 20, default),
(1, 2, 'wymiana filtra paliwa', 30, 5, default),
(2, 3, 'wymiana zaworu EGR', 67.20, 0, default),
(3, 4, 'naprawa uk³adu zap³onowego', 200, 5, default),
(3, 5,'wymiana katalizatora', 130, 10, default),
(4, 6,'regeneracja tylnej belki skrêtnej', 800, 0, default),
(5, 7,'wymiana rozrz¹du', 800, 0, default),
(5, 8, 'wymiana ko³a pasowego', 237.60, 0, default),
(6, 9, 'wymiana pokrywy zaworów', 200, 30, default),
(7, 10,'wymiana klocków hamulcowych', 70, 10, 2),
(7, 11, 'wymiana refelktorow', 30, 5, 3)


insert into czesci_szczegoly
values
(7, 8, 0, 3),
(1, 5, 0, default),
(1, 7, 0, default),
(2, 10, default ,default),
(3, 14, default ,default),
(5, 2, default ,default),
(5, 9, default ,default),
(6, 6, default ,default),
(7, 12, default, 2)


insert into wypozyczenie_samochod
values
(1, 1, 1, '2018-01-20'),
(2, 2, 1, '2018-02-12')

insert into zwrot_samochod
values
(1, 3, '2018-02-20'),
(2, 4, '2018-02-21')

--widoki
go
create view lista_sam as
select k.id_klient, k.imie, k.nazwisko, s.id_samochod_klient, s.marka, s.model 
from klient k join samochod_klient s on s.id_klient = k.id_klient

go

create view ceny_czesci as
select cs.*, round(c.cena * cs.ilosc*((100-cs.znizka)/100), 2) as koszt
from czesci_szczegoly cs inner join czesci c on c.id_czesci = cs.id_czesci

go

create view ceny_uslug as
select *, round(cena * ilosc*((100-znizka)/100),2) as koszt
from uslugi
go

--funkcje
create function cena_zlecenie(@id_zlecenie int)
returns money
as
begin
	declare @suma money
	set @suma = (select sum(koszt) from ceny_czesci where id_zlecenie = @id_zlecenie)
	set @suma += (select sum(koszt) from ceny_uslug where id_zlecenie = @id_zlecenie)
	return @suma
end
go

create function cena_klient(@id_klient int)
returns money
as
begin
	declare @suma money
	set @suma = (select sum(koszt) from ceny_czesci where id_zlecenie in(select id_zlecenie from zlecenie where id_klient = @id_klient and status = 'trwajace'))
	set @suma += (select sum(koszt) from ceny_uslug where id_zlecenie in(select id_zlecenie from zlecenie where id_klient = @id_klient and status = 'trwajace'))
	return @suma
end
go

--procedury
create proc dodaj_klienta
	@imie varchar(15),
	@nazwisko varchar(20),
	@telefon varchar(16)
as
insert into klient(imie, nazwisko, telefon)
values(@imie, @nazwisko, @telefon)
go

create proc awans
	@id_pracownik int,
	@procent int
as
begin
	declare @pensja as money
	set @pensja =(select pensja+pensja*@procent/100
	from pracownik
	where id_pracownik =@id_pracownik)

	update pracownik
	set pensja = @pensja
	where id_pracownik = @id_pracownik
end
go

create proc dodaj_zlecenie
	@id_klient int,
	@id_pracownik int,
	@id_samochod_klient int,
	@status  varchar(10) = 'trwajace'
as
begin
	declare @data_roz date
	set @data_roz = convert(date, getdate())
	insert into zlecenie(id_klient, id_pracownik, id_samochod_klient, data_roz, status)

	values( @id_klient, @id_pracownik, @id_samochod_klient, @data_roz, @status)
end
go