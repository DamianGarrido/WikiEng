
// Doc: https://docs.google.com/document/d/1aRqZVF5_CrR88BnihYlPDQH4YXjboeNIPniQeW-amZ4/edit?usp=sharing


// Chronometer HTML

<div class="crono_wrapper">	<h2 id='crono'>00:00:00</h2></div>

	
// En caso que la pantalla se actualice usar este script para obtener el tiempo actual del cronometro
	
<script>document.getElementById("crono").innerHTML = window.localStorage.getItem("tiempoGuardado");</script>


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
 
            // Iniciamos el cronometro
            funcionando();
        }else{
            // Detener el cronometro (En realidad es Pausar)
 
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
		
	    // Iniciamos el cronometro
            funcionando();
    }

    function funcionando()
    {
        // Obtenemos la fecha actual
        var actual = new Date().getTime();
 
        // Obtenemos la diferencia entre la fecha actual y la de inicio
        var diff=new Date(actual-inicio);
 
        // Formateamos el tiempo a mostrar HH:MM:SS
        var result=LeadingZero(diff.getUTCHours())+":"+LeadingZero(diff.getUTCMinutes())+":"+LeadingZero(diff.getUTCSeconds());
	    
	// Seteamos el tiempo a mostrar
        document.getElementById(''crono'').innerHTML = result;
 	
	// En caso que la pantalla vaya a refrescarse se guarda el tiempo actual del cronómetro
	localStorage.setItem("tiempoGuardado", result);
	    
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
