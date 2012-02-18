$(document).ready( function( ) {
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
		 
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];
		 
        if( op == 'registrar_novedad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La novedad se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('La novedad no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_novedad' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('La novedad no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_novedad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La novedad se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La novedad no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_novedad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La novedad se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('La novedad no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
                 
                 
        //
                 
      
        if( op == 'registrar_novedadcampo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Novedad Campo se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Novedad Campo no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_novedadcampo' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Novedad Campo no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_novedadcampo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Novedad Campo se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Novedad Campo no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_novedadcampo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Novedad Campo se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Novedad Campo no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
        //
        
    
        if( op == 'registrar_novedaddocumento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Novedad Documento se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Novedad Documento no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_novedaddocumento' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Novedad Documento no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_novedaddocumento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Novedad Documento se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Novedad Documento no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_novedaddocumento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Novedad Documento se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Novedad Documento no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 

                 
        borrarRespuesta();
    } ); 
} ); 

