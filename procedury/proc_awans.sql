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
exec awans 1, 10
drop proc awans