CREATE DEFINER=`root`@`localhost` FUNCTION `f_cant_gen`(bgenero char(20)) RETURNS int
    NO SQL
BEGIN
    DECLARE resultado int;
    SELECT count(*) into resultado FROM cancion where genero = bgenero;
    RETURN resultado;
END