create function cena_klient(@id_klient int)
returns money
as
begin
	declare @suma money
	set @suma = (select sum(koszt) from ceny_czesci where id_zlecenie in(select id_zlecenie from zlecenie where id_klient = @id_klient and status = 'trwajace'))
	set @suma += (select sum(koszt) from ceny_uslug where id_zlecenie in(select id_zlecenie from zlecenie where id_klient = @id_klient and status = 'trwajace'))
	return @suma
end
select.dbo.cena_klient(6)
drop function cena_klient