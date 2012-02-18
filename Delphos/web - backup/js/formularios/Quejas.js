  $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
        
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];

        if( op == 'registrar_registro' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_registro' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El registro no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_registro' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        //
        if( op == 'registrar_documentos' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El documento se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El documento no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_documentos' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El documento no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_documentos' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El documento se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El documento no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        //
        if( op == 'registrar_afectados' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El afectado se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El afectado no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_afectados' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El afectado no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_afectados' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El afectado se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El afectado no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }        
        //
        if( op == 'registrar_respuestas' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La respuesta se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La respuesta no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_respuestas' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La respuesta no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_respuestas' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La respuesta se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La respuesta no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        //
      
        borrarRespuesta();       
    } );
 