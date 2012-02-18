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

        if( op == 'registrar_claseGrupoTitular' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La Clase Grupo Titular se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La Clase Grupo Titular no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }

        if( op == 'obtener_claseGrupoTitular' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La Clase Grupo Titular no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');

            }else {


                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );

            }


        }
        if( op == 'actualizar_claseGrupoTitular' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La Clase Grupo Titular se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La Clase Grupo Titular no registro correctamente: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }

        if( op == 'eliminar_claseGrupoTitular' ) {

            if( es == 'si' && er == 'no' ) bottomMensaje('La Clase Grupo Titular se borro correctamente', 'Estado borrado', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La Clase Grupo Titular no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');

            $("#tabla").flexReload();
        }


        borrarRespuesta();
    } );


} );




