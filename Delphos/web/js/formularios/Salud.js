$(document).ready( function( ) {
	$("#ajax").ajaxStop( function() {
		 datos = $("#respuestaAjax").val();
		 mapaDatos = mapa(datos);
		 
		 op = mapaDatos['opcion'];
		 es = mapaDatos['estado'];
		 er = mapaDatos['error'];
		 ed = mapaDatos['errorDes'];
		 io = mapaDatos['info'];
		 
		 if( op == 'registrar_inscripcionips' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('Inscripcion Ips se registro correctamente','Estado registro', 'ex', 's'); 
			 if( es == 'no' && er == 'si' ) bottomMensaje('Inscripcion Ips no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
		 }
		 
		  if( op == 'obtener_inscripcionips' ) {
			 if( es == 'no' && er == 'si' ){ 
				 bottomMensaje('Inscripcion Ips no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
			 }else { 
				 leerDatos( io ); 
				  $("#tablaContenedor").dialog("close"); 
				 configurarBotones('Actualizar'); 
				 $("#codigo").val( mapaDatos['codigo'] ); 
			 }
		 }
		 
		  if( op == 'actualizar_inscripcionips' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('Inscripcion Ips se actualizo correctamente','Estado actualizacion', 'ex', 's');			 if( es == 'no' && er == 'si' ) bottomMensaje('Inscripcion Ips no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
		 } 
 
		 if( op == 'eliminar_inscripcionips' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('Inscripcion Ips se borro correctamente', 'Estado borrado', 'ex', 'n'); 
			 if( es == 'no' && er == 'si' ) bottomMensaje('Inscripcion Ips no se borro: <br /><br /><span class="error"> '
				 + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
			 $("#tabla").flexReload();
		 } 
 
		  borrarRespuesta();
	 } ); 
} ); 
