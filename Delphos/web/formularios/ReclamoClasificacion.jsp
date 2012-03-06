<%@ include file="config.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div><div id="reporte"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="ReclamoClasificacion" /> <input type="hidden" id="servlet" value="ReclamoClasificacion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">RECLAMO CLASIFICACION</div>
            <br />
            <div>
                <form id="ReclamoClasificacion" method="post" accept-charset="utf-8" name="ReclamoClasificacion"><input type="hidden" id="codigo" name="codigo" /> 
                    <input type="hidden" name="accion" id="accion" value="" /> 
                    <div class="boton"><input type="submit" value="Mostrar Reclamos Clasificacion Registrados" onclick="return tabla(flexiReclamoClasificacion, 'Reclamo Clasificacion', '' )" /> 
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('ReclamoClasificacion', 'Registrar', ''); return false" /> 
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> 
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('ReclamoClasificacion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>C&oacute;digo Tipo Reclamo</td>
                            <td>C&oacute;digo Clasificaci&oacute;n Reclamo</td>
                            
                            
                        </tr>
                        <tr>
                          <td><select name="rectipcodigo_reclamoClasificacion" id="rectipcodigo_reclamoClasificacion" 
                                      onfocus="tabla(flexiReclamoTipo, 'Tipo Reclamo',
                                          'rectipcodigo_reclamoClasificacion' )" onclick="tabla(flexiReclamoTipo, 
                                          'Tipo Reclamo', 'rectipcodigo_reclamoClasificacion' )"></select></td>
                            
                            <td><input name="recclacodigo_reclamoClasificacion" type="text" id="recclacodigo_reclamoClasificacion" value="" /></td>
                           
                        </tr>
                        <tr><td>Descripci&oacute;n Clasificaci&oacute;n Reclamo</td></tr>
                        <tr>
                            <td colspan="2"><textarea name="reccladescri_reclamoClasificacion" id="reccladescri_reclamoClasificacion" cols="50" rows="4"></textarea></td>
                        </tr>
                        <tr><td>Observaciones Clasificaci&oacute;n Reclamo</td></tr>
                        <tr>
                            <td colspan="2"><textarea name="recclaobserv_reclamoClasificacion" id="recclaobserv_reclamoClasificacion" cols="50" rows="4"></textarea></td>
                        </tr>
                    
                        
                    </table>
                    <br />
                    <!-- Acciones estan 
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('ReclamoClasificacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('ReclamoClasificacion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
      
    </body>
</html>
