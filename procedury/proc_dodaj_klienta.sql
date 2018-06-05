use warsztat
create proc dodaj_klienta
	@imie varchar(15),
	@nazwisko varchar(20),
	@telefon varchar(16)
as
insert into klient(imie, nazwisko, telefon)
values(@imie, @nazwisko, @telefon)
go
exec dodaj_klienta 'Marek', 'Skrzypkowski', '666555333'