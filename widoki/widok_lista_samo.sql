create view lista_sam as
select k.id_klient, k.imie, k.nazwisko, s.id_samochod_klient, s.marka, s.model 
from klient k join samochod_klient s on s.id_klient = k.id_klient


select * from lista_sam
order by imie, nazwisko, marka, model

drop view lista_sam