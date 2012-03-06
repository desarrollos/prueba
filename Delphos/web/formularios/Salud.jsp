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
        <div id="mensaje" class="c1"></div><div id="reporte"></div>
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
                        <li><a href="#tabs-1" id="inscripcionips">Inscripciones IPS</a></li>
                        <li><a href="#tabs-2" id="NovedadEntidadSalud">Novedad Entidad Salud</a></li>
                        <li><a href="#tabs-3" id="AtencionesEnSalud">Atenciones En Salud</a></li>
                        <li><a href="#tabs-4" id="RegistroControles">Registro Controles</a></li>
                        <li><a href="#tabs-5" id="CumplimientoSalud">Cumplimiento Salud</a></li>




                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Inscripciones IPS" onclick="return tabla(flexiiNscripcionIps, 'Inscripciones IPS', '' )" /></div>
                        <br />
                        <table>

                            <tr>
                                <td>Codigo del regimen</td>
                                <td>Tipo Identificacion Persona Inscripta IPS</td>
                                <td>Identificación Inscripto a IPS</td>
                                <td>Fecha Inscripción IPS</td>
                            </tr>
                            <tr>
                                <td> <select  id="entidadsalud_inscripcionips_1" name="entidadsalud_inscripcionips_1" onfocus="tabla(flexiEntidadSalud, 'Codigo del regimen', 'entidadsalud_inscripcionips_1' )" onclick="tabla(flexiEntidadSalud, 'Codigo del regimen', 'entidadsalud_inscripcionips_1' )"></select></td>
                                <td> <select  id="codtipoidentidad_inscripcionips" name="codtipoidentidad_inscripcionips" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Persona Inscripta IPS', 'codtipoidentidad_inscripcionips' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Persona Inscripta IPS', 'codtipoidentidad_inscripcionips' )"></select></td>
                                <td> <input type="text" id="insipsidenti_inscripcionips" name="insipsidenti_inscripcionips"/></td>
                                <td><input type="text" id="_fecha_insipsfecins_inscripcionips" name="insipsfecins_inscripcionips" value="" maxlength="19" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>Número Historia Clínica</td>
                                <td>Centro Atención</td>
                                <td>Código Estado Inscripción</td>
                                <td>Archivo Documento Inscripción IPS</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="insipshiscli_inscripcionips" name="insipshiscli_inscripcionips"/></td>
                                <td> <input type="text" id="insipscenate_inscripcionips" name="insipscenate_inscripcionips"/></td>
                                <td> <select  id="esinipscodigo_inscripcionips" name="esinipscodigo_inscripcionips" onfocus="tabla(flexiEstadoincripIps, 'Código Estado Inscripción', 'esinipscodigo_inscripcionips' )" onclick="tabla(flexiEstadoincripIps, 'Código Estado Inscripción', 'esinipscodigo_inscripcionips' )"></select></td>
                                <td><input name="insipsarchiv_inscripcionips" type="text" id="insipsarchiv_inscripcionips" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('insipsarchiv_inscripcionips')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('insipsarchiv_inscripcionips' )" alt="Descargar" /></td>
                            </tr>
                            <tr>
                                <td>Observaciones Inscripción IPS</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="insipsobserv_inscripcionips" name="insipsobserv_inscripcionips" cols="110" rows="4"></textarea></td>
                            </tr>
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
