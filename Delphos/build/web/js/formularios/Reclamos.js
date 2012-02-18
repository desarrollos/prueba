$(document).ready( function( ) {
    config = {
        secuencias : [
        {
            nomSec : 'reclamo_sec', 
            idCampo : 'reclamconsec_registro',   
            mod : true, 
            visible : true
        }
        ]
        ,
        selDep : [
        {
            id : 'identbenef_afectados',
            tabla : 'beneficiario',
            selectRel : [
            { 
                id : 'reclamconsec_afectados', 
                rel : 'beneficiario.codunifami|',
                sel : 'codunifami',
                erMeg : 'Primero debe seleccionar consecutivo .'
            }
            ]
        },
        {
            id : 'codmunicipio_registro',
            tabla : 'municipio',
            selectRel : [
            { 
                id : 'coddepartamento_registro', 
                rel : 'municipio.coddepartamento|',
                sel : 'coddepartamento',
                erMeg : 'Primero debe seleccionar un departamento.'
            }
            ]
        }
             
        ]
    }
    configuraciones(config);
    
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
        
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];
        
        
        
        if( op == 'registrar_registros' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_registros' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El registro no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_registros' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        if( op == 'eliminar_registros' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
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
        if( op == 'eliminar_documentos' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El documento se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('El documento no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
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
            if( es == 'si' && er == 'no' ) bottomMensaje('El afectadoe se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El afectadoe no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        if( op == 'eliminar_afectados' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El afectado se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('El afectado no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
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
        if( op == 'eliminar_respuestas' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('La respuesta se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('La respuesta no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }        
        if( op == 'validacion' ) {
            bottomMensaje('Validacion de campos: <br /><br /><span class="error"> ' + ed + "</span>", 'Validacion de campos', 'e', 'n');
            
        }
        
        
        
     
        borrarRespuesta();       
    } );
    
    
} );