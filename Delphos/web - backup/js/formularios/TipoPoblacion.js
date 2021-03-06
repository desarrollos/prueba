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

        if( op == 'registrar_tipoPoblacion' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El Tipo Poblacion se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El Tipo Poblacion no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }

        if( op == 'obtener_tipoPoblacion' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El Tipo Poblacion no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');

            }else {


                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );

            }


        }
        if( op == 'actualizar_tipoPoblacion' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El Tipo Poblacion se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El Tipo Poblacion no registro correctamente: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }

        if( op == 'eliminar_tipoPoblacion' ) {

            if( es == 'si' && er == 'no' ) bottomMensaje('El Tipo Poblacion se borro correctamente', 'Estado borrado', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El Tipo Poblacion no se borro: <br /><br /><span class="error"> '
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');

            $("#tabla").flexReload();
        }


        borrarRespuesta();
    } );


} );


