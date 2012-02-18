$(document).ready( function( ) {
    
    
    
    $("#fechaactoadmin").datepicker({
        dateFormat : 'yy-mm-dd',
        changeMonth: true,
        changeYear: true
    });
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
        
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];
        
        // alert( op + "  " + io );
        
        if( op == 'registrar_entidad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La entidad se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La entidad no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        
        if( op == 'obtener_entidad' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La entidad no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            
            }else {
               
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                $("#codregimentabla").val( mapaDatos['codregimentabla'] );
            }
            
            
        }
        if( op == 'actualizar_entidad' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La entidad se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La entidad no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        if( op == 'eliminar_entidad' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('La entidad se borro correctamente', 'Estado borrado', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La entidad no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        if( op == 'validacion' ) {
            bottomMensaje('Validacion de campos: <br /><br /><span class="error"> ' + ed + "</span>", 'Validacion de campos', 'e', 'n');
            
        }
        
        borrarRespuesta();       
    } );
    
    
} );





