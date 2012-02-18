$(document).ready( function( ) {
    config = {
        secuencias : [
        {
            nomSec : 'encuentroreunion_sec', 
            idCampo : 'encuencodigo_reuniones',   
            mod : true
        }
            
        ],
        selDep : [
        {
            id : 'codmunicipio_reuniones',
            tabla : 'municipio',
            selectRel : [
            { 
                id : 'coddepartamento_reuniones', 
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
        
        
        
        if( op == 'registrar_reuniones' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La reunion se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La reunion no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_reuniones' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La reunion no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_reuniones' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La reunion se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La reunion no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        if( op == 'eliminar_reuniones' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('La reunion se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('La reunion no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        
        
        //
        if( op == 'registrar_asistencias' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La asistencia se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La asistencia no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_asistencias' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La asistencia no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_asistencias' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La asistencia se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La asistencia no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        } 
        if( op == 'eliminar_asistencias' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('La asistencia se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('La asistencia no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        
        //
        
        
        if( op == 'registrar_actividades' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La actividad se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La actividad no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        
        if( op == 'obtener_actividades' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La actividad no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            
            }else {
               
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
            
            
        }
        if( op == 'actualizar_actividades' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La actividad se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La actividad no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        if( op == 'eliminar_actividades' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('La actividad se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('La actividad no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        
        
        //
        
        
        if( op == 'registrar_asistentes' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El asistente se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El asistente no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        
        if( op == 'obtener_asistentes' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El asistente no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            
            }else {
               
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
            
            
        }
        if( op == 'actualizar_asistentes' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El asistente se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El asistente no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        if( op == 'eliminar_asistentes' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El asistente se borro correctamente', 'Estado borrado', 'ex', 'n');
            if( es == 'no' && er == 'si' ) bottomMensaje('El asistente no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        
        if( op == 'validacion' ) {
            bottomMensaje('Validacion de campos: <br /><br /><span class="error"> ' + ed + "</span>", 'Validacion de campos', 'e', 'n');
            
        }
        
        
     
        borrarRespuesta();       
    } );
    
    
} );