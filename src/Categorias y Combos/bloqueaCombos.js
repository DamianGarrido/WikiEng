 /*************************************************************************
 DGARRIDO: Deshabilita los combos
 *************************************************************************/
function bloqueaCombos() {
                var accion = document.getElementsByName("CALL.ACCION:ctl_295")[0];
                if (accion.value == "ACCION_X") {
                    document.getElementsByName("CALL.PRODUCTO:ctl_234")[0].disabled = true;
                    document.getElementsByName("CALL.ID_MODELO:ctl_236")[0].disabled = true;                                     
                    document.getElementsByName("CALL.TIPO_PRODUCTO:ctl_238")[0].disabled = true;
                }
}

		