SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [FN_VALIDAR_CUIT] (@CUIT AS VARCHAR(11)) 
RETURNS BIT  

-- ============================================================================================
-- Descripcion: Valida si un nro de CUIT pasado por parámetro es válido
-- Parametros:
-- @cuit: nro de cuit a validar pasado como varchar(11)
-- @resultado: devuelve un 1 si la verificación no fue exitosa y un 0 si fue exitosa
-- ===============================================================================================
BEGIN
DECLARE @nroActual             as int
DECLARE @valor1                as numeric
DECLARE @valor2                as int
DECLARE @verificadorObtenido   as int
DECLARE @resultado			   as bit

-- Chequeo la longitud y que sea numérico para no seguir validando innecesariamente

IF ISNUMERIC(@cuit)=0  OR (NOT(LEN(@cuit)=11))
BEGIN
	SET @resultado = 1
	RETURN 1
END

-- Si pasa entonces uso algoritmo de dígito verificador para Argentina

SET @valor1   = 0

--Se toma cada digito del cuit ( menos el digito verificador ) y se lo multiplica por un valor fijo a cada digito y se suman los resultados

SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,1,1)))
SET @valor1   = @valor1 + (@nroActual * 5)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,2,1)))
SET @valor1   = @valor1 + (@nroActual * 4)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,3,1)))
SET @valor1   = @valor1 + (@nroActual * 3)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,4,1)))
SET @valor1   = @valor1 + (@nroActual * 2)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,5,1)))
SET @valor1   = @valor1 + (@nroActual * 7)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,6,1)))
SET @valor1   = @valor1 + (@nroActual * 6)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,7,1)))
SET @valor1   = @valor1 + (@nroActual * 5)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,8,1)))
SET @valor1   = @valor1 + (@nroActual * 4)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,9,1)))
SET @valor1   = @valor1 + (@nroActual * 3)
SET @nroActual = CONVERT(int,(SUBSTRING(@cuit,10,1)))
SET @valor1   = @valor1 + (@nroActual * 2)

-- Se divide el resultado / 11 y se toma el valor entero y Se multiplica ese resultado por 11

SET @valor2 = convert (int,(@valor1 / 11)) * 11

-- Se resta el valor 1 menos el valor 2

SET @verificadorObtenido = @valor1 - @valor2

--Si este valor es cero ese es el digito verificador. Si es mayor a cero entonces hay que restarselo a 11

IF  @verificadorObtenido <> 0 SET @verificadorObtenido = 11 - @verificadorObtenido

IF @verificadorObtenido = CONVERT(int,(SUBSTRING(@cuit,11,1)))
BEGIN
	SET @resultado = 0;
	RETURN 0;
END
ELSE BEGIN
	SET @resultado = 1;
	RETURN 1;
END;

RETURN @resultado

END
GO