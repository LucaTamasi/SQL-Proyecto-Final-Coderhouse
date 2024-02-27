create schema spotify; 
use spotify;




   -- Creación de tabla --

create table clientes (
id_cliente int primary key auto_increment,
nombre varchar(30) not null,
mail varchar(30) not null,
fecha_de_nacimiento date not null,
cancion varchar(30)  null
);

create table cancion (
id_cancion int primary key auto_increment,
nombre varchar(30) not null,
duracion time not null,
genero varchar(30) not null,
discografica varchar(30) not null,
MB int not null,
fecha_de_publicacion date not null
);

create table genero (
id_genero int primary key auto_increment,
nombre varchar(30) not null
);

create table artista (
id_artista int primary key auto_increment,
nombre varchar(30) not null,
fecha_de_nacimiento date not null,
mail varchar(30) not null
);

create table discografica (
id_discografica int primary key auto_increment,
nombre varchar(30) not null,
mail varchar(30) not null
);




   -- Relaciones --

alter table clientes
add id_cancion int;
alter table clientes
add constraint fk_clientes_cancion
foreign key (id_cancion) references cancion(id_cancion);

alter table cancion
add id_cliente int;
alter table cancion
add constraint fk_cancion_clientes
foreign key (id_cliente) references clientes(id_cliente);

alter table genero
add id_cancion int;
alter table genero
add constraint fk_genero_cancion
foreign key (id_cancion) references cancion(id_cancion);

alter table artista
add id_cancion int;
alter table artista
add constraint fk_artista_cancion
foreign key (id_cancion) references cancion(id_cancion);

alter table discografica
add id_cancion int;
alter table discografica
add constraint fk_discografica_cancion
foreign key (id_cancion) references cancion(id_cancion);




  -- Inserts --
    
INSERT INTO cancion (nombre, duracion, genero, discografica, MB, fecha_de_publicacion, id_cliente) VALUES 
('En la Ciudad de la Furia', '00:06:41', 'Rock', 'Sony Music', '2874', '1988-06-11','2'),
('Segir viviendo sin tu amor', '00:02:40', 'Rock', 'EMI Odeon SAIC','793', '1991-1-1', '3'),
('El loco', '00:03:05', 'Rock', 'Popartdiscos Internacional SAS','948', '2001-07-25', '4'),
('Crimen', '00:03:52', 'Rock', 'SONY BMG MUSIC ENTERTAINMENT ','1008', '2006-04-04', '1'),
('Love Is Coming Back', '00:04:29', 'EDM', 'BUENA MÚSICA ','1027', '2023-02-23', '1'),
('In your eyes', '00:04:06', 'EDM', 'When Stars Align','1987','2023-09-15', '3'); 

INSERT INTO clientes (nombre, mail, fecha_de_nacimiento) VALUES
('Luca Tamasi', 'lucatamasi@gmail.com', '2000-12-29'),
('Juan Pérez', 'juan.perez@hotmail.com', '1985-07-15'),
('María García', 'maria.garcia15@yahoo.com.ar', '1992-04-23'),
('Carlos Rodríguez', 'crodriguez@gmail.com', '1989-12-03');

INSERT INTO genero (nombre) VALUES
('Rock'),
('Punk'),
('EDM'),
('Jazz');

INSERT INTO artista (nombre, fecha_de_nacimiento, mail) VALUES
('Gustavo Cerati', '1985-07-15', 'gcerati@hotmail.com', '1'),
('Babasonicos', '1995-02-21', 'bbasinicos@yahoo.com', '2'),
('Luis Alberto Spinetta', '1992-04-23', 'maria.garcia15@yahoo.com.ar', '3'),
('Camel Phat', '1998-05-25', 'cmel@gmail.com', '6'),
('Hernan Cattaneo', '1972-06-15', 'hcattaneo@gmail.com', '5');

INSERT INTO discografica (nombre, mail, id_cancion) VALUES
('Sony Music',  'smusic@hotmail.com','1'),
('EMI Odeon SAIC', 'emiodeon@gmail.com','2'),
('Popartdiscos Internacional SAS', 'porarts@gmail.com','3'),
('SONY BMG MUSIC ENTERTAINMENT',  'sobgmenter@hotmail.com','4'),
('BUENA MUSICA', 'bmusic@hotmail.com','5');



   -- Vistas --

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




   -- Stored Procedures --

delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tiemp_mayor_count`(in tiempo time, out numero int)
begin
select count(*) into numero
from cancion
where duracion > tiempo;
end//
delimiter;

delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mb_mayor`(in tamaño int)
begin
select * 
from cancion
where MB > tamaño;
end//




   -- Funciones --

delimiter //

CREATE DEFINER=`root`@`localhost` FUNCTION `f_cant_gen`(bgenero char(20)) RETURNS int
    NO SQL
BEGIN
    DECLARE resultado int;
    SELECT count(*) into resultado FROM cancion where genero = bgenero;
    RETURN resultado;
END//

CREATE DEFINER=`root`@`localhost` FUNCTION `f_mail_prov`(pmail VARCHAR(30)) RETURNS int
    NO SQL
BEGIN
    DECLARE resultado INT;

    SELECT COUNT(*) INTO resultado
    FROM clientes
    WHERE mail LIKE CONCAT('%', pmail, '%');

    RETURN resultado;
END//




-- Triggers --

CREATE TABLE registro_nueva_cancion (
  id_reg int primary key auto_increment,
  nombre_cancion VARCHAR(45) NULL,
  fecha DATETIME NULL DEFAULT CURRENT_TIMESTAMP
  );

CREATE TABLE baja_clientes (
  id_baj int primary key auto_increment,
  nombre_cliente VARCHAR(45) NULL,
  fecha DATETIME NULL DEFAULT CURRENT_TIMESTAMP
  );

delimiter //
CREATE TRIGGER tr_nueva_cancion AFTER INSERT ON cancion
FOR EACH ROW 
BEGIN
    INSERT INTO registro_nueva_cancion (nombre_cancion) VALUES (CONCAT('Se agregó la canción: ', NEW.nombre));
END//
delimiter ;

delimiter //
CREATE TRIGGER tr_baja_usuarios AFTER DELETE ON clientes FOR EACH ROW 
BEGIN
    INSERT INTO baja_clientes (nombre_cliente) VALUES (CONCAT('El usuario:', old.nombre,'y mail:', old.mail, 'fue dado de baja'));
END//
delimiter ;






  
    
    



