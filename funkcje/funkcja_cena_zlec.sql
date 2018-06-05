create function cena_zlecenie(@id_zlecenie int)
returns money
as
begin
	declare @suma money
	set @suma = (select sum(koszt) from ceny_czesci where id_zlecenie = @id_zlecenie)
	set @suma += (select sum(koszt) from ceny_uslug where id_zlecenie = @id_zlecenie)
	return @suma
end
select.dbo.cena_zlecenie(2)