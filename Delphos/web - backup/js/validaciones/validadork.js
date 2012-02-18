function permite2(e, permitidos, _float) 
{
        tecla=(document.all) ? e.keyCode : e.which;
	if (tecla == 8 || tecla == 13 )
		return true;
	else if ((tecla < 48) || (tecla > 57))
		return false;
	return true;
//(_float ? (element.value.indexOf('.') == -1 ? charCode == 46 : false) : false)
  
}

validadorpk

// JavaScript Document

//---------------------------Funciones para el evento keypress -----------------------------------------

function permite(elEvento, permitidos) {
  // Variables que definen los caracteres permitidos
      var numeros = "0123456789";
      var caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
      var tildes = "Ò—·ÈÌÛ˙¡…Õ”⁄";
      var numeros_caracteres = numeros + caracteres;
      var direcciones = "-_ #.()";
      var coment = "-_ #.(),&%$ø?!°'@:;";
      var cor = "-_.@";
      var teclas_especiales = [46];
      var teclas_especiales_fijas = [8, 49, 37, 39, 9];
      // 8 = BackSpace, 49 = Supr, 37 = flecha izquierda, 39 = flecha derecha

    // Obtener la tecla pulsada 
      var evento = elEvento || window.event;
      var codigoCaracter = evento.charCode || evento.keyCode;
      var caracter = String.fromCharCode(codigoCaracter);

      var tecla_especial = false;


    // Comprobar si la tecla pulsada es alguna de las teclas especiales
        // (teclas de borrado y flechas horizontales)
        
        for(var i in teclas_especiales_fijas) {
            if(codigoCaracter == teclas_especiales_fijas[i]) {
                tecla_especial = true;
                break;
            }
        } 

      // Seleccionar los caracteres a partir del par·metro de la funciÛn
      switch(permitidos) {

        //numericos enteros
        case 'nume':
          permitidos = numeros;
          for(var i in teclas_especiales_fijas) {
                if(codigoCaracter == teclas_especiales_fijas[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if(caracter == '.') {
                    tecla_especial = false;
            }
          break;

        //numericos doubles
        case 'numd':
          permitidos = numeros;
          for(var i in teclas_especiales_fijas) {
                if(codigoCaracter == teclas_especiales_fijas[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if(caracter == '.') {
                    tecla_especial = true;
            }
          break;
        //caracteres y espacios en blanco
        case 'carac':
          permitidos = caracteres+" "+tildes;
          
          if(caracter == '.') {
                    tecla_especial = false;
            }
          break;
        //caracteres y numeros solamente y sin espacios en blanco, como para colocar en los codigos o llaves de cada formulario, siempre y cuando sea de tipo character varying en la bd
        case 'num_car_cod':
          permitidos = numeros_caracteres;
          for(var i in teclas_especiales_fijas) {
                if(codigoCaracter == teclas_especiales_fijas[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if(caracter == '.') {
                    tecla_especial = false;
            }
          break;
        //para direcciones y campos que contengan caracteres para direcciones  
        case 'dir':
          permitidos = numeros_caracteres + direcciones + tildes;
            // Comprobar si la tecla pulsada es alguna de las teclas especiales
            // (teclas de borrado y flechas horizontales)

            for(var i in teclas_especiales) {
                if(codigoCaracter == teclas_especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            } 
            break;

        //comentarios, observaciones y otros que contengan varios caracteres especiales
        case 'com':
          permitidos = numeros_caracteres + coment + tildes;
          break;

        //correos
        case 'correo':
          permitidos = numeros_caracteres + cor;
          break;
        
      }
 
      // Comprobar si la tecla pulsada se encuentra en los caracteres permitidos
      // o si es una tecla especial
      return permitidos.indexOf(caracter) != -1 || tecla_especial;       
}



//-------------Fin Funciones para el evento keypress ----------------------------------------------
