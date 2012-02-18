$(document).ready( function( ) {
   /* config = {
        selDep : [
        {
            id : 'codsubgrupo_empresa',
            tabla : 'subgrupogeografico',
            selectRel : [
            { 
                id : 'coddepartamento_empresa', 
                rel : 'subgrupogeografico.coddepartamento|',
                sel : 'coddepartamento',
                erMeg : 'Debe seleccionar Primero el departamento.'
            },
            { 
                id : 'codmunicipio_empresa', 
                rel : ' AND subgrupogeografico.codmunicipio|',
                sel : 'codmunicipio',
                erMeg : 'Debe seleccionar Primero el municipio.'
            }
            ]
        },    
        {
            id : 'codbarrio_empresa',
            tabla : 'barrio',
            selectRel : [
            { 
                id : 'codsubgrupo_empresa', 
                rel : 'barrio.codsubgrupo|',
                sel : 'codsubgrupo',
                erMeg : 'Debe seleccionar el codigo del sub grupo geografico.'
            }
            ]
        }
             
        ]
    }
    configuraciones(config);  
    */
    
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
        
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];
        
        // alert( op + "  " + io );
        
        if( op == 'registrar_empresa' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La Empresa se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La Empresa no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        
        if( op == 'obtener_empresa' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La empresa no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            
            }else {
               
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
            
            
        }
        if( op == 'actualizar_empresa' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La empresa se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La empresa no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        if( op == 'eliminar_empresa' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('La empresa se borro correctamente', 'Estado borrado', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La empresa no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        if( op == 'validacion' ) {
            bottomMensaje('Validacion de campos: <br /><br /><span class="error"> ' + ed + "</span>", 'Validacion de campos', 'e', 'n');
            
        }
        
        
        borrarRespuesta();       
    } );
    
    
} );

