<%@ include file="config.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="TipoEntidad" /> <input type="hidden" id="servlet" value="TipoEntidad" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">TIPO ENTIDADES</div>
            <br />
            <div>
                <form id="TipoEntidad" method="post" accept-charset="utf-8" name="TipoEntidad"><input type="hidden" id="codigo" name="codigo" /> 
                    <input type="hidden" name="accion" id="accion" value="" /> 
                    <div class="boton"><input type="submit" value="Mostrar Tipo Entidades Registradas" onclick="return tabla(flexiEntidad, 'TipoEntidad', '' )" /> 
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('TipoEntidad', 'Registrar', ''); return false" /> 
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> 
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('TipoEntidad', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>C&oacute;digo Tipo Entidad</td>
                            <td>Descripci&oacute;n C&oacute;digo</td>
                            
                        </tr>
                        <tr>
                            <td><input name="codtipoentidadsalud_entidad" type="text" id="codtipoentidadsalud_entidad" value="" /></td>
                            <td colspan="5">
                                <textarea name="descripcion_entidad" id="descripcion_entidad" cols="95" rows="4"></textarea></td>
                        </tr>
                   
                    </table>
                    <br />
                    <!-- Acciones estan 
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('TipoEntidad', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('TipoEntidad', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
       
    </body>
</html>
