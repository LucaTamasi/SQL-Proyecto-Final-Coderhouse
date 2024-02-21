CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mb_mayor`(in tamaño int)
begin
select * 
from cancion
where MB > tamaño;
end