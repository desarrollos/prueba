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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Tipo Poblaci&oacute;n" /> <input type="hidden" id="servlet" value="TipoPoblacion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">TIPO POBLACI&Oacute;N</div>
            <br />
            <div>
                <form id="TipoPoblacion" method="post" accept-charset="utf-8" name="TipoPoblacion"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Tipos  Poblacion " onclick="return tabla(flexiTipoPoblacion, 'Tipo Poblacion', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('TipoPoblacion', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('TipoPoblacion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>C&oacute;digo Tipo Poblaci&oacute;n </td> <td> <input type="text" id="codtipopoblacion_tipopoblacion" name="codtipopoblacion_tipopoblacion"/></td>
                        </tr>
                        <tr>
                            <td>Descripci&oacute;n</td> <td><textarea name="descripcion_tipopoblacion" id="descripcion_tipopoblacion" cols="50" rows="4"></textarea></td>
                        </tr>

                    </table>
                    <br />
                    <!-- Acciones estan
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('TipoPoblacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('TipoPoblacion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
        
    </body>
</html>
