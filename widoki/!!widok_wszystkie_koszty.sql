create view wszystkie_koszty
as
select cu.id_zlecenie, cu.koszt as [koszty uslug], cc.koszt as [koszty czesci]  
from ceny_uslug cu left join ceny_czesci cc on cu.id_zlecenie = cc.id_zlecenie

drop view wszystkie_koszty