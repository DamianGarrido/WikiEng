-- ==============================================================
-- GRILLA CON ICONOS PARA ADJUNTAR ARCHIVOS
-- ==============================================================

SELECT	
	'<i onclick="window.open(''/./../../engage5/EngageAgent/Agent4/Asp/AttachDocuments.aspx?ReadOnly=undefined&AttachOrigin=Entity&ParentPkey='+T.PKEY+''');" 
	class="fa fa-paperclip" title="Adjuntos" style="cursor:pointer;color:#003D7A;font-size:18px"></i>',
	
	T.PKEY,
FROM	TABLA T


-- ==============================================================
-- GRILLA CON ICONOS PARA ADJUNTAR NOTAS
-- ==============================================================

SELECT	
	'<i onclick="window.open(''/./../../engage5/EngageAgent/Agent4/Asp/AttachNotes.aspx?ReadOnly=undefined&NoteOrigin=Entity&ParentPkey='+T.PKEY+''');" 
	class="fa fa-file-text-o" title="Notas" style="cursor:pointer;color:#003D7A;font-size:18px"></i>',
	
	T.PKEY,
FROM	TABLA T