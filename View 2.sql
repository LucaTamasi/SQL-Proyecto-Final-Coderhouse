CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vw_generoedm` AS
    SELECT 
        `cancion`.`nombre` AS `nombre`,
        `cancion`.`duracion` AS `duracion`,
        `cancion`.`genero` AS `genero`,
        `cancion`.`discografica` AS `discografica`,
        `cancion`.`fecha_de_publicacion` AS `fecha_de_publicacion`
    FROM
        `cancion`
    WHERE
        (`cancion`.`genero` = 'EDM')