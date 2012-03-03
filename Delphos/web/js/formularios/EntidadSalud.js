$(document).ready( function( ) {
	$("#ajax").ajaxStop( function() {
		 datos = $("#respuestaAjax").val();
		 mapaDatos = mapa(datos);
		 
		 op = mapaDatos['opcion'];
		 es = mapaDatos['estado'];
		 er = mapaDatos['error'];
		 ed = mapaDatos['errorDes'];
		 io = mapaDatos['info'];
		 
		 if( op == 'registrar_entidadsalud' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('Entidad Salud se registro correctamente','Estado registro', 'ex', 's'); 
			 if( es == 'no' && er == 'si' ) bottomMensaje('Entidad Salud no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
		 }
		 
		  if( op == 'obtener_entidadsalud' ) {
			 if( es == 'no' && er == 'si' ){ 
				 bottomMensaje('Entidad Salud no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
			 }else { 
				 leerDatos( io ); 
				  $("#tablaContenedor").dialog("close"); 
				 configurarBotones('Actualizar'); 
				 $("#codigo").val( mapaDatos['codigo'] ); 
			 }
		 }
		 
		  if( op == 'actualizar_entidadsalud' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('Entidad Salud se actualizo correctamente','Estado actualizacion', 'ex', 's');			 if( es == 'no' && er == 'si' ) bottomMensaje('Entidad Salud no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
		 } 
 
		 if( op == 'eliminar_entidadsalud' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('Entidad Salud se borro correctamente', 'Estado borrado', 'ex', 'n'); 
			 if( es == 'no' && er == 'si' ) bottomMensaje('Entidad Salud no se borro: <br /><br /><span class="error"> '
				 + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
			 $("#tabla").flexReload();
		 } 
 
		  borrarRespuesta();
	 } ); 
} ); 
