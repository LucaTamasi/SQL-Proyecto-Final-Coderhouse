create schema spotify; 
use spotify;

-- Creación de tabla

create table clientes (
id_cliente int primary key auto_increment,
nombre varchar(30) not null,
mail varchar(30) not null,
fecha_de_nacimiento date not null,
cancion varchar(30) not null
);

create table cancion (
id_cancion int primary key auto_increment,
nombre varchar(30) not null,
duracion time not null,
genero varchar(30) not null,
discografica varchar(30) not null,
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

 -- Relaciones

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



