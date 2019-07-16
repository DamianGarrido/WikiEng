-- ==============================================================
-- CAMPO MODIFICABLE DESDE LA GRILLA CON UN INPUT TEXT
-- ==============================================================

SELECT 
'<input type="text" onchange="almacenarSeleccion(''CAMPO'',event.target.value);SaltoaEstructura(''9999_9'');" value="'+T.VALOR+'"/>' AS 'Campo'

FROM TABLA T

-- El salto a estructura tiene que ir a una transaccion que haga un UPDATE a la tabla a modificar con el nuevo valor.