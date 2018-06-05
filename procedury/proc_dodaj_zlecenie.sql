create proc dodaj_zlecenie
	@id_klient int,
	@id_pracownik int,
	@id_samochod_klient int,
	@status  varchar(10) = 'trwaj¹ce'
as
begin
	declare @data_roz date
	set @data_roz = convert(date, getdate())
	insert into zlecenie(id_klient, id_pracownik, id_samochod_klient, data_roz, status)

	values( @id_klient, @id_pracownik, @id_samochod_klient, @data_roz, @status)
end
go

exec dodaj_zlecenie 1, 3, 9
drop procedure dodaj_zlecenie