<%@ include file="config.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <div id="tablaContenedor"></div>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Esquema seguridad Delphos" /> <input type="hidden" id="servlet" value="Poblacion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ESQUEMA POBLACION DELPHOS</div>
            <br />
            <form id="Poblacion"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> <input type="hidden" name="pestana" id="pestana" value="Usuarios" />
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Poblacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Poblacion', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br /><br />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="Poblacion">Poblacion</a></li>
                        <li><a href="#tabs-2" id="Consultas">Consultas</a></li>
                     
                       

                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Poblacion" onclick="return tabla(flexi, 'Poblacion', '' )" /></div>
                        <br />
                        <table>
                            formulario aqui
                        </table>
                    </div>
                    <div id="tabs-2"><br />
                        <div class="boton"><input type="submit" value="Mostrar Consultas" onclick="return tabla(flexi, 'Consultas', '' )" /></div>
                        <br />
                        
                        <table>
                            aqui formulario
                        </table>
                        
                    </div>
                    

                    <br />
                    <br />

                    <div class="clearBottom"></div>
                </div>
                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Poblacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Poblacion', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
            </form>
        </div>
      
    </body>
</html>
