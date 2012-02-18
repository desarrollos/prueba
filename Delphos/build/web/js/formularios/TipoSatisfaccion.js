$(document).ready( function( ) {
    
    
    
    
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
        
        
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];
        
        // alert( op + "  " + io );
        
        if( op == 'registrar_tipoSatisfaccion' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El tipo satisfaccion se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El tipo satisfaccion no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        
        if( op == 'obtener_tipoSatisfaccion' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El tipo satisfaccion no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            
            }else {
               
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
            
            
        }
        if( op == 'actualizar_tipoSatisfaccion' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El tipo satisfaccion se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El tipo satisfaccion no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        if( op == 'eliminar_tipoSatisfaccion' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El tipo satisfaccion se borro correctamente', 'Estado borrado', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El tipo satisfaccion no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        
        
        borrarRespuesta();       
    } );
    
    
} );

