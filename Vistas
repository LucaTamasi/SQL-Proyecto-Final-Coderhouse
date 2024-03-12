create view vw_generoedm as
select nombre, duracion, genero, discografica, fecha_de_publicacion
from cancion
where genero='EDM';

create view vw_cancionesxxi as
select nombre, duracion, genero, discografica, fecha_de_publicacion
from cancion
where fecha_de_publicacion >'2000-01-01';

create view vw_mayor_1GB as
select *
from cancion
where MB >'1024';

create view vw_mail_gmail as
SELECT mail
FROM clientes
WHERE mail LIKE CONCAT('%gmail%');

create view vw_mayoresedad as
select *
from clientes
where DATEDIFF(CURDATE(), fecha_de_nacimiento) > 6570;
