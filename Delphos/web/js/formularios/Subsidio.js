$(document).ready( function( ) {
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
		 
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];
		 
        if( op == 'registrar_subsidio' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_subsidio' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Subsidio no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_subsidio' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_subsidio' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
       
		 
        if( op == 'registrar_subsidiomunicipio' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Municipio se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Municipio no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_subsidiomunicipio' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Subsidio Municipio no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_subsidiomunicipio' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Municipio se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Municipio no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_subsidiomunicipio' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Municipio se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Municipio no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
	
		 
        if( op == 'registrar_subsidiopotencial' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Potencial se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Potencial no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_subsidiopotencial' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Subsidio Potencial no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_subsidiopotencial' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Potencial se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Potencial no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_subsidiopotencial' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Potencial se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Potencial no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
	
		 
        if( op == 'registrar_subsidioasignado' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Asignado se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Asignado no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_subsidioasignado' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Subsidio Asignado no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_subsidioasignado' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Asignado se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Asignado no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_subsidioasignado' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Subsidio Asignado se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Subsidio Asignado no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
	
                 
 
        borrarRespuesta();
    } ); 
} ); 

