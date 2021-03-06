$(document).ready( function( ) {
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
		 
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];
		 
        if( op == 'registrar_escolaridad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_escolaridad' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Escolaridad no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_escolaridad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_escolaridad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
        //
                 
                 
                
        if( op == 'registrar_escolaridadnovedad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad Novedad se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad Novedad no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_escolaridadnovedad' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Escolaridad Novedad no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_escolaridadnovedad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad Novedad se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad Novedad no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_escolaridadnovedad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad Novedad se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad Novedad no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
        // 

		 
        if( op == 'registrar_escregperiodico' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Registro Periodico se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Registro Periodico no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_escregperiodico' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Registro Periodico no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_escregperiodico' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Registro Periodico se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Registro Periodico no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_escregperiodico' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Registro Periodico se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Registro Periodico no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
        //

		 
        if( op == 'registrar_escolaridadcumplimiento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad Cumplimiento se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad Cumplimiento no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_escolaridadcumplimiento' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Escolaridad Cumplimiento no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_escolaridadcumplimiento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad Cumplimiento se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad Cumplimiento no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_escolaridadcumplimiento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Escolaridad Cumplimiento se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Escolaridad Cumplimiento no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
         
        borrarRespuesta();
    } ); 
} ); 
