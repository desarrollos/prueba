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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Respuesta Clasificacion" /> <input type="hidden" id="servlet" value="RespuestaClasificacion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo"> CLASIFICACION RESPUESTA </div>
            <br />
            <div>
                <form id="RespuestaClasificacion" method="post" accept-charset="utf-8" name="RespuestaClasificacion"><input type="hidden" id="codigo" name="codigo" /> 
                    <input type="hidden" name="accion" id="accion" value="" /> 
                    <div class="boton"><input type="submit" value="Mostrar Respuesta Clasificacion " onclick="return tabla(flexiRespuestaClasificacion, 'RespuestaClasificacion', '' )" /> 
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('RespuestaClasificacion', 'Registrar', ''); return false" /> 
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> 
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('RespuestaClasificacion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>C&oacute;digo Clasificaci&oacute;n Respuesta </td> <td> <input type="text" id="resclacodigo_respuestaClasificacion" name="resclacodigo_respuestaClasificacion"/></td>
                        </tr>
                        <tr>
                            <td>Descripci&oacute;n</td> <td><textarea name="rescladescri_respuestaClasificacion" id="rescladescri_respuestaClasificacion" cols="50" rows="4"></textarea></td>
                        </tr>
                          
                        
                    </table>
                    <br />
                    <!-- Acciones estan 
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('RespuestaClasificacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('RespuestaClasificacion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
       
    </body>
</html>
