$(document).ready( function( ) {
    config = {
        secuencias : [
        {
            nomSec : 'reclamo_sec', 
            idCampo : 'reclamconsec_registro',   
            mod : true, 
            visible : true
        }
        ]/*
        ,
        selDep : [
        {
            id : 'identbenef_encuentroactividad',
            tabla : 'beneficiario',
            selectRel : [
            { 
                id : 'reclamconsec_encuentroactividad', 
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
             
        ]*/
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
        
        
        
        if( op == 'registrar_reclamo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_reclamo' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El registro no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_reclamo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        if( op == 'eliminar_reclamo' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El registro se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('El registro no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }        
        
        //
        if( op == 'registrar_reclamodocumento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El documento se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El documento no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_reclamodocumento' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El documento no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_reclamodocumento' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El documento se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El documento no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }  
        if( op == 'eliminar_reclamodocumento' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El documento se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('El documento no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }        
        //
   
		 
        if( op == 'registrar_reclamobeneficiaro' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Reclamo Beneficiario se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Reclamo Beneficiario no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_reclamobeneficiaro' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Reclamo Beneficiario no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_reclamobeneficiaro' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Reclamo Beneficiario se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Reclamo Beneficiario no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_reclamobeneficiaro' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Reclamo Beneficiario se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Reclamo Beneficiario no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
    
		 
        if( op == 'registrar_respuestareclamo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Respuesta Reclamo se registro correctamente','Estado registro', 'ex', 's'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Respuesta Reclamo no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
		 
        if( op == 'obtener_respuestareclamo' ) {
            if( es == 'no' && er == 'si' ){ 
                bottomMensaje('Respuesta Reclamo no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
            }else { 
                leerDatos( io ); 
                $("#tablaContenedor").dialog("close"); 
                configurarBotones('Actualizar'); 
                $("#codigo").val( mapaDatos['codigo'] ); 
            }
        }
		 
        if( op == 'actualizar_respuestareclamo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Respuesta Reclamo se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('Respuesta Reclamo no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
        } 
 
        if( op == 'eliminar_respuestareclamo' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('Respuesta Reclamo se borro correctamente', 'Estado borrado', 'ex', 'n'); 
            if( es == 'no' && er == 'si' ) bottomMensaje('Respuesta Reclamo no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            $("#tabla").flexReload();
        } 
 
	
     
        borrarRespuesta();       
    } );
    
    
} );