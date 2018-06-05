create view ceny_czesci as
select cs.*, round(c.cena * cs.ilosc*(100-(coalesce(cs.znizka, 0)/100)), 2) as koszt
from czesci_szczegoly cs inner join czesci c on c.id_czesci = cs.id_czesci

select sum(koszt) from ceny_czesci where id_zlecenie = 1
drop view ceny_czesci
select * from ceny_czesci

create view ceny_czesci as
select cs.*, round(c.cena * cs.ilosc*((100-cs.znizka)/100), 2) as koszt
from czesci_szczegoly cs inner join czesci c on c.id_czesci = cs.id_czesci
