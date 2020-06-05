
// Doc: https://docs.google.com/document/d/1aRqZVF5_CrR88BnihYlPDQH4YXjboeNIPniQeW-amZ4/edit?usp=sharing


// Chronometer HTML

<div class="crono_wrapper">	<h2 id='crono'>00:00:00</h2></div>


// BTN START/STOP

<input id='btn_empezar' type="button" value="Empezar" onclick="empezarDetener(this);">

	
// BTN RESTART
	
<input id='btn_reiniciar' type="button" value="Reiniciar" onclick="reiniciar(this);">	

	
// IFRAME BTN V1

<input id='btn_siguiente' type="button" value="Siguiente" onclick="window.parent.parent.document.getElementById('btn_empezar').click();">


// IFRAME BTN V2

<input id='btn_siguiente' type="button" value="Siguiente" onclick="window.parent.parent.empezarDetener(window.parent.parent.document.getElementById('btn_empezar'));">


// IFRAME BTN V3 TODO: Para que no haya que usar el botón btn_empezar

// JS FUNCTIONS PARAMETER

PS_CRONOMETRO:='<script type="text/javascript">'||
    '
	//var inicio=0;
    var inicio=new Date().getTime();
    var timeout=0;
 
    function empezarDetener(elemento)
    {
        if(timeout==0)
        {
            // empezar el cronometro
 
            elemento.value="Detener";
 
            // Obtenemos el valor actual
            inicio=new Date().getTime();
 
            // iniciamos el proceso
            funcionando();
        }else{
            // detemer el cronometro
 
            elemento.value="Empezar";
            clearTimeout(timeout);
            timeout=0;
        }
    }
 

    function reiniciar(elemento)
    {
            // detemer el cronometro
            clearTimeout(timeout);
            timeout=0;
		
	     // Obtenemos el valor actual
            inicio=new Date().getTime();
		
	    // iniciamos el proceso
            funcionando();
    }

    function funcionando()
    {
        // obteneos la fecha actual
        var actual = new Date().getTime();
 
        // obtenemos la diferencia entre la fecha actual y la de inicio
        var diff=new Date(actual-inicio);
 
        // mostramos la diferencia entre la fecha actual y la inicial
        var result=LeadingZero(diff.getUTCHours())+":"+LeadingZero(diff.getUTCMinutes())+":"+LeadingZero(diff.getUTCSeconds());
        document.getElementById(''crono'').innerHTML = result;
 
        // Indicamos que se ejecute esta función nuevamente dentro de 1 segundo
        timeout=setTimeout("funcionando()",1000);
    }
 
    /* Funcion que pone un 0 delante de un valor si es necesario */
    function LeadingZero(Time) {
        return (Time < 10) ? "0" + Time : + Time;
    }
    </script>
 
     <style>
    .crono_wrapper {text-align:center;color:azure;font-family:cursive;background:lightskyblue;width:125px;}
	</style>'
