$(document).ready( function( ) {
	$("#ajax").ajaxStop( function() {
		 datos = $("#respuestaAjax").val();
		 mapaDatos = mapa(datos);
		 
		 op = mapaDatos['opcion'];
		 es = mapaDatos['estado'];
		 er = mapaDatos['error'];
		 ed = mapaDatos['errorDes'];
		 io = mapaDatos['info'];
		 
		 if( op == 'registrar_nutricionregistro' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('La Actividad Nutricional se registro correctamente','Estado registro', 'ex', 's'); 
			 if( es == 'no' && er == 'si' ) bottomMensaje('La Actividad Nutricional no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
		 }
		 
		  if( op == 'obtener_nutricionregistro' ) {
			 if( es == 'no' && er == 'si' ){ 
				 bottomMensaje('La Actividad Nutricional no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e'); 
			 }else { 
				 leerDatos( io ); 
				  $("#tablaContenedor").dialog("close"); 
				 configurarBotones('Actualizar'); 
				 $("#codigo").val( mapaDatos['codigo'] ); 
			 }
		 }
		 
		  if( op == 'actualizar_nutricionregistro' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('La Actividad Nutricional se actualizo correctamente','Estado actualizacion', 'ex', 's');			 if( es == 'no' && er == 'si' ) bottomMensaje('La Actividad Nutricional no registro correctamente: <br /><br /><span class="error"> '				  + ed + "</span>", 'Error al actualizar el registro', 'e', 'n'); 
		 } 
 
		 if( op == 'eliminar_nutricionregistro' ) {
			 if( es == 'si' && er == 'no' ) bottomMensaje('La Actividad Nutricional se borro correctamente', 'Estado borrado', 'ex', 'n'); 
			 if( es == 'no' && er == 'si' ) bottomMensaje('La Actividad Nutricional no se borro: <br /><br /><span class="error"> '
				 + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
			 $("#tabla").flexReload();
		 } 
 
		  borrarRespuesta();
	 } ); 
} ); 

