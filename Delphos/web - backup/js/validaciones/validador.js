// JavaScript Document
var clase_css_error = "formulario_error";
var clase_css_normal = "formulario_normal";

//onSubmit="javascript:return validar(arrayNonulos, arrayNumerosEnteros, arrayCombos, arrayCadenasANCod, arrayCadenasA, arrayComentarios, arrayNumerosDoubles)"
//function validar( nonulos, numerosEnteros, combos, numerosDoubles, cadenasANCod, cadenasA, direcciones )
function validar( nonulos, numerosEnteros, combos, cadenasANCod, cadenasA, comentarios, numerosDoubles )
{        
        limpiarColor(nonulos);
        limpiarColor(numerosEnteros);
        limpiarColor(combos);
        limpiarColor(cadenasANCod);
        limpiarColor(cadenasA);
        limpiarColor(comentarios);
        limpiarColor(numerosDoubles);
                
        if( nonulos != null && !sonValidosNonulos( nonulos ) )
	{
                alert("Datos incompletos. Debe llenar todos los campos obligatorios.");
		return false;
	}
        
        if( numerosEnteros != null && !sonValidosNumerosEnteros( numerosEnteros ) )
	{
                alert("Datos erroneos. Debe llenar los campos con números enteros.");
		return false;
	}

        if( combos != null && !sonValidosCombos( combos ) )
	{
                alert("Datos erroneos. Debe llenar los campos desplegables.");
		return false;
	}
        
        if( cadenasANCod != null && !sonValidasCadenasANCod( cadenasANCod ) )
	{
                alert("Datos erroneos. Debe llenar los campos con caracteres alfanumericos y sin caracteres especiales.");
		return false;
	}

        if( cadenasA != null && !sonValidasCadenasA( cadenasA ) )
	{
                alert("Datos erroneos. Debe llenar los campos con caracteres correctos.");
		return false;
	}
        
        if( comentarios != null && !sonValidosComentarios( comentarios ) )
	{
                alert("Datos erroneos. Debe llenar los campos con caracteres correctos.com");
		return false;
	}

        if( numerosDoubles != null && !sonValidosNumerosDoubles( numerosDoubles ) )
	{
		alert("Datos erroneos. Debe llenar los campos con números.");
		return false;
	}

        return true;
}

function validar2( nonulos, numerosEnteros, combos, cadenasANCod, cadenasA, comentarios, numerosDoubles, porcentajes, direcciones, correos )
{
    if(validar(nonulos, numerosEnteros, combos, cadenasANCod, cadenasA, comentarios, numerosDoubles))
    {
        limpiarColor(porcentajes);
        limpiarColor(direcciones);
        limpiarColor(correos);
                
        if( porcentajes != null && !sonValidosPorcentajes( porcentajes ) )
	{
		alert("Datos erroneos. Debe llenar los campos con caracteres correctos.");
		return false;
	}        

        if( direcciones != null && !sonValidasDirecciones( direcciones ) )
	{
		alert("Datos erroneos. Debe llenar los campos con caracteres correctos.dir");
		return false;
	}
        
        if( correos != null && !sonValidosCorreos( correos ) )
	{
		alert("Datos erroneos. Debe llenar los campos con caracteres correctos.");
		return false;
	}
        
        return true;
    }
}

//-----------------Funciones para colorear campos ----------------------------------------------------
function limpiarColor( arrayDatos )
{
    if( arrayDatos != null )
        for( var i=0; i<arrayDatos.length; i++  )
        {
            pintarCampo( arrayDatos[i], clase_css_normal );
        }
}

function pintarCampoErroneo( nombreCampo )
{
    pintarCampo(nombreCampo, clase_css_error);
    elemento.select();
    elemento.focus();
}

function pintarCampoErroneo2( nombreCampo )
{
    pintarCampo(nombreCampo, clase_css_error);
}

function pintarCampo( nombreCampo, clase_css )
{
    elemento = obtenerElemento(nombreCampo);

    elemento.className = clase_css;
}
//-----------------Fin Funciones para colorear campos ----------------------------------------------------


function contieneEspacios(texto)
{        
        for ( var i = 0; i < texto.length; i++ )
        {  
                if ( texto.charAt(i) == ' ' )
                {  
                        return true;
                }  
        }
        return false;
}

function contienePuntos(texto)
{        
        for ( var i = 0; i < texto.length; i++ )
        {  
                if ( texto.charAt(i) == '.' )
                {  
                        return true;
                }  
        }
        return false;
}

function contieneMasPuntos(texto)
{
        var num = 0;
        
        for ( var i = 0; i < texto.length; i++ )
        {  
                if ( texto.charAt(i) == '.' )
                {  
                        num = num + 1;
                }  
        }

        if(num > 1)
        {
            return true;
        }
        else
        {
            return false;
        }
}

function contieneCaracteresNoPermitidos(texto, permitidos)
{
        var num = 0;
        
        for ( var i = 0; i < texto.length; i++ )
        {

            if(permitidos.indexOf(texto.charAt(i)) == -1)
            {
                return true;
            }         
                
        }

        return false;
}

function sonValidosNonulos( nonulos )
{
	for( var i=0; i<nonulos.length; i++ )
	{
                var variable = obtenerValorElemento(nonulos[i]);
                if( variable == null || variable.length == 0 || /^\s+$/.test(variable) )                
                {
                        pintarCampoErroneo( nonulos[i] );
			return false;
                }
	}
        return true;
}

function sonValidosNumerosEnteros( numerosEnteros )
{
        
	for( var i=0; i<numerosEnteros.length; i++ )
	{
                var variable = obtenerValorElemento(numerosEnteros[i]);
                //if( !esEntero( variable ) || contieneEspacios(variable) || contienePuntos(variable) )
                if( isNaN( variable ) || contieneEspacios(variable) || contienePuntos(variable) )
                {
                        pintarCampoErroneo( numerosEnteros[i] );
			return false;
                }
	}
	return true;
}

function sonValidosCombos( combos )
{
	for( var i=0; i<combos.length; i++ )
	{
			var elemento = obtenerElemento(combos[i]);
			if( elemento.selectedIndex < 1 )
			{
				pintarCampoErroneo2( combos[i] );
				return false;
			}
 	}
	
	return true;
}

function sonValidosNumerosDoubles( numerosDoubles )
{        
	for( var i=0; i<numerosDoubles.length; i++ )
	{
                var variable = obtenerValorElemento(numerosDoubles[i]);
                if( isNaN( variable ) || contieneEspacios(variable) || contieneMasPuntos(variable) )
                {
                        pintarCampoErroneo( numerosDoubles[i] );
			return false;
                }
	}
	return true;
}

function sonValidasCadenasANCod( cadenasANCod )
{
        var numeros = "0123456789";
        var caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZáéíóúÁÉÍÓÚñÑ";
        var perm = numeros + caracteres;

	for( var i=0; i<cadenasANCod.length; i++ )
	{
                var variable = obtenerValorElemento(cadenasANCod[i]);
                
                if( contieneEspacios(variable) || contienePuntos(variable) || contieneCaracteresNoPermitidos(variable,perm) )
                {
                        pintarCampoErroneo( cadenasANCod[i] );
			return false;
                }
	}
	return true;
}

function sonValidasDirecciones( direcciones )
{
        var numeros = "0123456789";
        var caracteres = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var tildes = "áéíóúÁÉÍÓÚñÑ";
        var direc = "-_#.(),";
        var perm = numeros + caracteres + tildes + direc;

	for( var i=0; i<direcciones.length; i++ )
	{
                var variable = obtenerValorElemento(direcciones[i]);
                
                if( contieneCaracteresNoPermitidos(variable,perm))
                {
                        pintarCampoErroneo( direcciones[i] );
			return false;
                }
	}
	return true;
}

function sonValidasCadenasA( cadenasA )
{
        //var numeros = "0123456789";
        var caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var tildes = "áéíóúÁÉÍÓÚñÑ";
        var perm = caracteres + tildes + " ";

	for( var i=0; i<cadenasA.length; i++ )
	{
                var variable = obtenerValorElemento(cadenasA[i]);
                
                if( contienePuntos(variable) || contieneCaracteresNoPermitidos(variable,perm) )
                {
                        pintarCampoErroneo( cadenasA[i] );
			return false;
                }
	}
	return true;
}

function sonValidosComentarios( comentarios )
{
        var numeros = "0123456789";
        var caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var tildes = "áéíóúÁÉÍÓÚñÑ";
        var coment = "-_ #.(),&%$¿?!¡'@:;";
        var perm = numeros + caracteres + tildes + coment;

	for( var i=0; i<comentarios.length; i++ )
	{
                var variable = obtenerValorElemento(comentarios[i]);
                
                if( contieneCaracteresNoPermitidos(variable,perm) )
                {
                        pintarCampoErroneo( comentarios[i] );
			return false;
                }
	}
	return true;
}

function sonValidosCorreos( correos )
{
        var numeros = "0123456789";
        var caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var direc = "-_.@";
        var perm = numeros + caracteres + direc;

	for( var i=0; i<correos.length; i++ )
	{
                var variable = obtenerValorElemento(correos[i]);
                
                if( contieneEspacios(variable) || contieneCaracteresNoPermitidos(variable,perm) )
                {
                        pintarCampoErroneo( correos[i] );
			return false;
                }
	}
	return true;
}

function sonValidosPorcentajes( porcentajes )
{        
	for( var i=0; i<porcentajes.length; i++ )
	{
                var variable = obtenerValorElemento(porcentajes[i]);
                if( isNaN( variable ) || contieneEspacios(variable) || contieneMasPuntos(variable) || (variable < 0) || (variable > 100) )
                {
                        pintarCampoErroneo( porcentajes[i] );
			return false;
                }
	}
	return true;
}

//---------------------------Funciones utilizadas en el metodo esVacio -----------------------------
function obtenerValorElemento(itemId)
{
        if( obtenerElemento(itemId) != null )
            return obtenerElemento(itemId).value;

        return null;
}

function obtenerElemento(itemId)
{
	if (document.layers && document.layers[itemId] != null) {
	    objValue = document.layers[itemId];
	}
	else if (document.all) {
	    objValue = document.all[itemId];
	}
	else if (document.getElementById) {
	    objValue = document.getElementById([itemId]);
	}

        if(objValue == null)
            alert("No se ha encontrado el elemento " +itemId);

	return objValue;
}
//---------------------------Fin Funciones utilizadas en el metodo esVacio -----------------------------


//-------------Funciones para eliminar espacios en blaco ------------------------------------------
function Trim( str ) 
{
    var resultStr = "";
    resultStr = TrimLeft(str);
    resultStr = TrimRight(resultStr);
    return resultStr;
}

function TrimLeft( str ) 
{
    var resultStr = "";
    var i = len = 0;
    if (str+"" == "undefined" || str == null)
        return "";
    str += "";

    if (str.length == 0)
        resultStr = "";
    else {
        len = str.length;
        while ((i <= len) && (str.charAt(i) == " "))
            i++;
        resultStr = str.substring(i, len);
    }
    return resultStr;
}

function TrimRight( str ) 
{
    var resultStr = "";
    var i = 0;
    if (str+"" == "undefined" || str == null)
        return "";
    str += "";
    if (str.length == 0)
        resultStr = "";
    else {
        i = str.length - 1;
        while ((i >= 0) && (str.charAt(i) == " "))
            i--;
        resultStr = str.substring(0, i + 1);
    }

    return resultStr;
}

function esVacio( nombreCampo )
{
        var texto = obtenerValorElemento(nombreCampo);

        for ( var i = 0; i < texto.length; i++ )
        {  
                if ( texto.charAt(i) != ' ' )
                {  
                        return false;
                }  
        }

        return true;
}

//-------------Fin Funciones para eliminar espacios en blaco ------------------------------------------

//---------------Funciones de agregar y limpiar ----------------------------------

function limpiar( cajas, combos )
{
        if( cajas != null )
        {
            for( var i=0; i<cajas.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(cajas[i]);
                
                elem.value = "";
            }
        }

        if( combos != null )
        {
            for( var i=0; i<combos.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                    //document.getElementById("selector2").selectedIndex = -1;
                var elem = obtenerElemento(cajas[i]);
                
                elem.selectedIndex = 0;
            }
        }
        
        /*if(document.formulario.editar.disabled == false)
        {
            deshabiGuardar();
        }*/
	
}

/////////////////////

    function habiGuardar(cajas2, combos2)
    {
        limpiar(cajas2, combos2);
        document.getElementById("nuevo").disabled=true;
        document.getElementById("guardar").disabled=false;
        document.getElementById("cancelar").disabled=false;
        document.getElementById("eliminar").disabled=true;
        document.getElementById("editar").disabled=true;
    }

function hGuardar()
    {
        document.getElementById("cancelar").disabled=false;
        document.getElementById("nuevo").disabled=true;
        document.getElementById("guardar").disabled=false;
        document.getElementById("eliminar").disabled=true;
        document.getElementById("editar").disabled=true;
    }
      
    function deshabiGuardar()
    {
        document.getElementById("cancelar").disabled=true;
        document.getElementById("guardar").disabled=true;
        document.getElementById("nuevo").disabled=false;
        document.getElementById("editar").disabled=true;
        document.getElementById("eliminar").disabled=true;
    }

    function habiBuscador()
    {
        document.getElementById("nuevo").disabled=false;
        document.getElementById("cancelar").disabled=true;
        document.getElementById("guardar").disabled=true;
        document.getElementById("editar").disabled=false;
        document.getElementById("eliminar").disabled=false;
    }
////

    function deshLlaves(cajas, combos)
    {
        if( cajas != null )
        {
            for( var i=0; i<cajas.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(cajas[i]);
                
                elem.disabled = true;
            }
        }

        if( combos != null )
        {
            for( var i=0; i<combos.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(combos[i]);
                
                elem.disabled = true;
            }
        }        
    }
    
function hLlaves(cajas, combos)
    {
        if( cajas != null )
        {
            for( var i=0; i<cajas.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(cajas[i]);
                
                elem.disabled = false;
            }
        }

        if( combos != null )
        {
            for( var i=0; i<combos.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(combos[i]);
                
                elem.disabled = false;
            }
        }        
    }

//////////////no llaves

function deshNoLlaves(cajas, combos)
    {
        if( cajas != null )
        {
            for( var i=0; i<cajas.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(cajas[i]);
                
                elem.disabled = true;
            }
        }

        if( combos != null )
        {
            for( var i=0; i<combos.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(combos[i]);
                
                elem.disabled = true;
            }
        }        
    }
    
function hNoLlaves(cajas, combos)
    {
        if( cajas != null )
        {
            for( var i=0; i<cajas.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(cajas[i]);
                
                elem.disabled = false;
            }
        }

        if( combos != null )
        {
            for( var i=0; i<combos.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(combos[i]);
                
                elem.disabled = false;
            }
        }        
    }

//////////////todos

function deshTodos(cajas, combos)
    {
        if( cajas != null )
        {
            for( var i=0; i<cajas.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(cajas[i]);
                
                elem.disabled = true;
            }
        }

        if( combos != null )
        {
            for( var i=0; i<combos.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(combos[i]);
                
                elem.disabled = true;
            }
        }
        
    }
    
function hTodos(cajas, combos)
    {
        if( cajas != null )
        {
            for( var i=0; i<cajas.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(cajas[i]);
                
                elem.disabled = false;
            }
            var elem = obtenerElemento(cajas[0]);
                
            elem.focus();
        }

        if( combos != null )
        {
            for( var i=0; i<combos.length; i++ )
            {
                //var variable = obtenerValorElemento(correos[i]);
                var elem = obtenerElemento(combos[i]);
                
                elem.disabled = false;
            }
        }
        
    }

    