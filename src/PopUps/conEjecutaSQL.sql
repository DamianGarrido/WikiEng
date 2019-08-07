-- BOTON CON POP UP 

SELECT
'<i onclick="almacenarSeleccion(''ID'',''T.ID'');Continuar();setTimeout(function(){ejecutaSql(''NOMBRE_SP'',''SP'','''')},500);" class="fa fa-question-circle" title="Help" style="cursor:pointer;color:dark-grey;font-size:16px"></i>'  AS '<b>Help</b>'
FROM TABLA T

-- El Continuar() va a una transacción que no hace nada más que volver a la misma pantalla
-- En lugar del "Continuar()" Se puede poner un salto a una estructura en caso que ya se este utilizando el flujo de Continuar para otra cosa.