PROCEDURE GRILLA_CHECKBOX (PEPKEYJOB IN VARCHAR2, CUR  OUT SYS_REFCURSOR) AS
 --=====================================================================================================
-- DESCRIPTION: Grilla con checkbox
--======================================================================================================

V_CAMPO VARCHAR2(50) := 'CHECKS_SELECCIONADOS'
V_CTL VARCHAR2(5) := '999'

 BEGIN

        BEGIN
            OPEN CUR FOR
                    SELECT DISTINCT
                        CASE WHEN (INSTR('V_CAMPO',';'|| T.ID ||';')>0 OR INSTR(V_CAMPO,';')>0)
							THEN '<INPUT TYPE="checkbox" checked="true" onclick="addRemoveValue(''CALL.'||V_CAMPO||':ctl_'||V_CTL||''',this,''' || T.ID || ''')"/>'
							ELSE '<INPUT TYPE="checkbox" onclick="addRemoveValue(''CALL.'||V_CAMPO||':ctl_'||V_CTL||''',this,''' || T.ID || ''')"/>'
						END AS "<B>*</B>",
						C.CATEGORIA "Categoría",
						M.MOTIVO "Motivo",
						S.SUBMOTIVO "Submotivo",
						CD.CAT_DATA_DESC "Aplica"
                   FROM TABLA T
            EXCEPTION  WHEN OTHERS THEN
               IF NOT CUR%ISOPEN
                    THEN
                        OPEN CUR FOR
                          SELECT 'Se produjo un error inesperado' "Mensaje" FROM DUAL;
               END IF;
        END;
       
END GRILLA_CHECKBOX;


PROCEDURE ACCION_SOBRE_SELECCIONADOS (PE_CHECKS_SELECCIONADOS  IN VARCHAR2, PS_CODE  OUT VARCHAR2, PS_MSG  OUT VARCHAR2 ) AS
--=====================================================================================================
-- DESCRIPTION: Realiza una acción sobre los items seleccionados
--======================================================================================================
 
v_elementos   DBMS_SQL.varchar2s; -- Array con los elementos seleccionados

BEGIN

    PS_CODE := '1';
    PS_MSG:= ' ' ;

    -- Validaciones
    IF PE_CHECKS_SELECCIONADOS = ' ' OR PE_CHECKS_SELECCIONADOS IS NULL  THEN
        PS_CODE := '1';
        PS_MSG:= '<script>alert(''No se seleccionó nada.'');</script>' ;
        RETURN;
    END IF;
    
    -- Obtengo los elementos seleccionados
       v_elementos := FN_STR_PARSER (PE_CHECKS_SELECCIONADOS, ';');
    
    -- Realizo la acción en cada registro
        FOR I IN (v_elementos.FIRST) .. (v_elementos.LAST) LOOP    
                            
                UPDATE TABLA
                SET CAMPO1 = 'FOO'
                WHERE ID = v_elementos(i);
                COMMIT;
                            
        END LOOP;
               
END ACCION_SOBRE_SELECCIONADOS;


CREATE OR REPLACE FUNCTION ENGAGEDTV."FN_STR_PARSER" (
    p_string in varchar2,
    p_separators in varchar2)
return dbms_sql.varchar2s
is
--=====================================================================================================
-- DESCRIPTION: Retorna un array a partir de un parseo por un separador
--======================================================================================================
  v_strs dbms_sql.varchar2s;
begin
  with sel_string as (select p_string fullstring from dual)
    select substr(fullstring, beg+1, end_p-beg-1) token
    bulk collect into v_strs
    from (select beg, lead(beg) over (order by beg) end_p, fullstring
           from (select beg, fullstring
                   from (select level beg, fullstring
                           from sel_string
                         connect by level <= length(fullstring))
                   where instr(p_separators ,substr(fullstring,beg,1)) >0
                 union all
                 select 0, fullstring from sel_string
                 union all
                 select length(fullstring)+1, fullstring from sel_string))
    where end_p is not null
      and end_p>beg+1;
  return v_strs;
end;