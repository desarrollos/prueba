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
        
        if( op == 'registrar_reclamoClasificacion' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El reclamo se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El reclamo no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        
        if( op == 'obtener_reclamoClasificacion' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El reclamo no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            
            }else {
               
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
            
            
        }
        if( op == 'actualizar_reclamoClasificacion' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El reclamo se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El reclamo no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        if( op == 'eliminar_reclamoClasificacion' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El reclamo se borro correctamente', 'Estado borrado', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El reclamo no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        
        
        borrarRespuesta();       
    } );
    
    
} );

