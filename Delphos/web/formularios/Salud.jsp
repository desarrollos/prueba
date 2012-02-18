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
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Esquema seguridad Delphos" /> <input type="hidden" id="servlet" value="Salud" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ESQUEMA SALUD DELPHOS</div>
            <br />
            <form id="Salud"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> <input type="hidden" name="pestana" id="pestana" value="Usuarios" />
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Salud', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Salud', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br /><br />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="InscripcionesIPS">Inscripciones IPS</a></li>
                        <li><a href="#tabs-2" id="NovedadEntidadSalud">Novedad Entidad Salud</a></li>
                        <li><a href="#tabs-3" id="AtencionesEnSalud">Atenciones En Salud</a></li>
                        <li><a href="#tabs-4" id="RegistroControles">Registro Controles</a></li>
                        <li><a href="#tabs-5" id="CumplimientoSalud">Cumplimiento Salud</a></li>




                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Inscripciones IPS" onclick="return tabla(flexi, 'Inscripciones IPS', '' )" /></div>
                        <br />
                        <table>
                            formulario aqui
                        </table>
                    </div>
                    
                    <div id="tabs-2"><br />
                        <div class="boton"><input type="submit" value="Mostrar Novedad Entidad Salud " onclick="return tabla(flexi, 'Novedad Entidad Salud', '' )" /></div>
                        <br />

                        <table>
                            aqui formulario
                        </table>

                    </div>
                    
                    <div id="tabs-3"><br />
                        <div class="boton"><input type="submit" value="Mostrar Atenciones En Salud" onclick="return tabla(flexi, 'Atenciones En Salud', '' )" /></div>
                        <br />
                        <table>
                            formulario aqui
                        </table>
                    </div>
                    
                    <div id="tabs-4"><br />
                        <div class="boton"><input type="submit" value="Mostrar Registro Controles " onclick="return tabla(flexi, 'Registro Controles', '' )" /></div>
                        <br />

                        <table>
                            aqui formulario
                        </table>

                    </div>
                    
                    <div id="tabs-5"><br />
                        <div class="boton"><input type="submit" value="Mostrar Cumplimiento Salud" onclick="return tabla(flexi, 'Cumplimiento Salud', '' )" /></div>
                        <br />
                        <table>
                            formulario aqui
                        </table>
                    </div>
                
                    <br />

                    <div class="clearBottom"></div>
                </div>
                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Salud', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Salud', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
            </form>
        </div>
    
    </body>
</html>
