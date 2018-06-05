create view ceny_uslug as
select *, round(cena * ilosc*((100-znizka)/100),2) as koszt
from uslugi

select sum(koszt) from ceny_uslug where id_zlecenie = 1
drop view ceny