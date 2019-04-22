-- CONSULTAS PARA OBTENER LISTA DE OBJETOS MODIFICADOS
-- A PARTIR DE UNA FECHA BASE

-- 20140822 - TENER EN CUENTA QUE UN OBJETO MODIFICADO A NIVEL DE CARTERA (sp O trx) NO SALE EN EL QUERY.
-- HAY QUE GENERAR UN SUBCONJUNTO DE PROCEDURE QUE DETERMINAR EL PADRE, SI ES UNA CARTERA O UN PROCESO.


DECLARE
	@LD_FECHA_BASE DATETIME,
	@LD_FECHA_TOPE DATETIME
	
SET @LD_FECHA_BASE = '20140820' -- FECHA DE ULTIMO PASAJE
SET @LD_FECHA_TOPE = '20991231' -- FECHA TOPE POR REGISTROS CREADOS POR SCRIPTS DE MDM

--select * from EVI_OBJECTS
--where CREATION_DATE > @LD_FECHA_BASE
--order by OBJECT_TYPE asc, CREATION_DATE desc

select OBJ.OBJECT_TYPE, OBJ.OBJECT_NAME, OBJ.TABLE_NAME, OBJ.LAST_DDL_TIME
from EVI_OBJECTS OBJ
where OBJ.LAST_DDL_TIME > @LD_FECHA_BASE
order by OBJ.OBJECT_TYPE asc, OBJ.LAST_DDL_TIME--OBJ.OBJECT_NAME, 

SELECT JT. CUST_TYPE_CODE, JT.JOB_TYPE_CODE, JT.JOB_TYPE_DESC, JT.TS_END
FROM JOB_TYPE JT
where TS_END > @LD_FECHA_BASE
AND TS_END < @LD_FECHA_TOPE
ORDER BY TS_END DESC

SELECT SP.SP_TYPE_CODE, SP.SP_CODE, SP.SP_NAME, SP.TS_END
FROM STORED_PROCEDURES SP
where SP.TS_END > @LD_FECHA_BASE
AND SP.TS_END < @LD_FECHA_TOPE
ORDER BY SP.TS_END DESC

SELECT TRX.CALL_TYPE_CODE, TRX.TRAN_CODE, TRX.TRAN_PROGRAM, TRX.TS_END
FROM TRANSACTIONS TRX
where TRX.TS_END > @LD_FECHA_BASE
AND TRX.TS_END < @LD_FECHA_TOPE
ORDER BY TRX.TS_END DESC

SELECT EB.ENTITY_CODE, EB.ENTITY_TABLE_REL, EB.TS_END, EBD.FIELD_NAME, EBD.TS_END
FROM ENTITY_BROWSER EB
INNER JOIN ENTITY_BROWSER_DETAIL EBD ON EB.PKEY = EBD.PAR_KEY
where EB.TS_END > @LD_FECHA_BASE
AND EBD.TS_END > @LD_FECHA_BASE
AND EB.TS_END < @LD_FECHA_TOPE
AND EBD.TS_END < @LD_FECHA_TOPE
ORDER BY EB.ENTITY_CODE DESC, EBD.TS_END DESC


SELECT CTG.CAT_TYPE_GROUP_CODE, CTG.CAT_TYPE_GROUP_DESC, CTG.TS_END
FROM CAT_TYPE_GROUP CTG
where CTG.TS_END > @LD_FECHA_BASE
AND CTG.TS_END < @LD_FECHA_TOPE
ORDER BY CTG.CAT_TYPE_GROUP_CODE

SELECT CT.CAT_TYPE_CODE , CT.CAT_TYPE_DESC, CT.TS_END
FROM CAT_TYPE CT
where CT.TS_END > @LD_FECHA_BASE
AND CT.TS_END < @LD_FECHA_TOPE
ORDER BY CT.CAT_TYPE_CODE

SELECT CT.CAT_TYPE_CODE, CD.CAT_DATA_CODE, CD.CAT_DATA_DESC, CD.TS_END
FROM CAT_DATA CD
INNER JOIN CAT_TYPE CT ON CT.PKEY = CD.PAR_KEY
where CD.TS_END > @LD_FECHA_BASE
AND CD.TS_END < @LD_FECHA_TOPE
ORDER BY CD.CAT_DATA_CODE



