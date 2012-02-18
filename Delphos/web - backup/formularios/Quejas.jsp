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
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Esquema seguridad Delphos" /> <input type="hidden" id="servlet" value="Quejas" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ESQUEMA DE SEGURIDAD DELPHOS</div>
            <br />
            <form id="Quejas"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> <input type="hidden" name="pestana" id="pestana" value="Usuarios" />
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Quejas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Quejas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br /><br />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="Registro">Registro</a></li>
                        <li><a href="#tabs-2" id="Documentos">Documentos</a></li>
                        <li><a href="#tabs-3" id="Afectados">Afectados</a></li>
                        <li><a href="#tabs-4" id="Respuestas">Respuestas</a></li>


                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Resgistros Quejas" onclick="return tabla(flexiQuejas, 'Registro Quejas', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo &Uacute;nico de Familia</td>
                                <td>Consecutivo Queja</td>
                                <td>Ciclo Pago Afectado</td>
                                <td>Tipo Identificacion Persona Queja</td>

                            </tr>

                            <tr>
                                <td>
                                    <select name="codunifami_quejasRegistro" id="codunifami_quejasRegistro" 
                                            onfocus="tabla(flexiQuejaBeneficiario, 'Codigo Unico Familia',
                                                'codunifami_quejasRegistro' )" onclick="tabla(flexiQuejaBeneficiario, 
                                                'Codigo Unico Familia', 'codunifami_quejasRegistro' )"></select>

                                </td>
                                <td><input name="quejconsecut_quejaRegistro" type="text" id="quejconsecut_quejaRegistro" value="" /></td>
                                <td><input name="quejciclpago_quejaRegistro" type="text" id="quejciclpago_quejaRegistro" value="" /></td>

                                <td><select name="codtipoidentidadpers_quejasRegistro" id="codtipoidentidadpers_quejasRegistro" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Codigo tipo identificacion',
                                                'codtipoidentidadpers_quejasRegistro' )" onclick="tabla(flexiTipoIdentificacion, 
                                                'Codigo tipo identificacion', 'codtipoidentidadpers_quejasRegistro' )"></select></td>

                            </tr>
                            <tr>

                                <td>Identificación Persona Queja</td>
                                <td>Fecha Queja</td>
                                <td>Código Tipo de Queja</td>
                                <td>Código Clasificación Queja</td>

                            </tr>
                            <tr>

                                <td><input type="text" name="quejidentifi_qiejaRegistro" id="quejidentifi_qiejaRegistro" value="" /></td>
                                <td><input type="text" name="quejfecha_qiejaRegistro" id="_fecha_quejfecha_qiejaRegistro" value="" /></td>
                                <td><select name="tipquecodigo_quejasRegistro" id="tipquecodigo_quejasRegistro" 
                                            onfocus="tabla(flexiTipoQueja, 'Codigo tipo Queja',
                                                'tipquecodigo_quejasRegistro' )" onclick="tabla(flexiTipoQueja, 
                                                'Código Tipo de Queja', 'tipquecodigo_quejasRegistro' )"></select></td>
                                <td><select name="queclacodigo_quejasRegistro" id="queclacodigo_quejasRegistro" 
                                            onfocus="tabla(flexiQuejaClasificacion, 'Código Clasificación Queja',
                                                'queclacodigo_quejasRegistro' )" onclick="tabla(flexiflexiQuejaClasificacionTipoQueja, 
                                                'Código Clasificación Queja', 'queclacodigo_quejasRegistro' )"></select></td>
                            </tr>
                            <tr>
                                <td>Tipo Identificacion Funcionario</td>
                                <td>Identificacion Funcionario</td>
                                <td>Archivo Documento Queja</td>
                            </tr>

                            <tr>

                                <td><select name="codtipoidentidad_quejasRegistro" id="codtipoidentidad_quejasRegistro" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Codigo tipo identificacion',
                                                'codtipoidentidad_quejasRegistro' )" onclick="tabla(flexiTipoIdentificacion, 
                                                'Codigo tipo identificacion', 'codtipoidentidad_quejasRegistro' )"></select></td> 

                                <td><input type="text" name="numidentfunc_qiejaRegistro" id="numidentfunc_qiejaRegistro" value="" /></td>


                                <td><input name="quejarchdocu_quejasRegistro" type="text" id="quejarchdocu_quejasRegistro" size="15" value="" readonly="readonly" 
                                           onclick="abrirCargaArchivo('quejarchdocu_quejasRegistro')" /> 
                                    <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('quejarchdocu_quejasRegistro' )" alt="Descargar" /></td>





                            </tr>
                            <tr>
                                <td>Observaciones Queja</td>
                            </tr>
                            <tr>
                                <td colspan="4"><textarea name="quejobservac_quejaRegistro" id="quejobservac_quejaRegistro" cols="50" rows="4"> </textarea></td>
                            </tr>
                            <tr>


                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2"><br />
                        <div class="boton"><input type="submit" value="Mostrar Documentos Registrados" onclick="return tabla(flexiDocumentoQuejas, 'Grupos Seguridad', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo &Uacute;nico de Familia</td>
                                <td>Consecutivo Queja</td>
                                <td>Codigo Tipo Documento Asociado</td>



                            </tr>
                            <tr>
                                <td><select name="codunifami_quejasDocumentos" id="codunifami_quejasDocumentos" 
                                            onfocus="tabla(flexiQuejaBeneficiario, 'Codigo Unico Familia',
                                                'codunifami_quejasDocumentos' )" onclick="tabla(flexiQuejaBeneficiario, 
                                                'Codigo Unico Familia', 'codunifami_quejasDocumentos' )"></select></td>

                                <td><select name="quejconsecut_quejaDocumentos" id="quejconsecut_quejaDocumentos" 
                                            onfocus="tabla(flexiQuejas, 'Consecutivo Queja',
                                                'quejconsecut_quejaDocumentos' )" onclick="tabla(flexiQuejas, 
                                                'Consecutivo Queja', 'quejconsecut_quejaDocumentos' )"></select></td>


                                <td><select name="codtipodctoasociado_quejasDocumentos" id="codtipodctoasociado_quejasDocumentos" 
                                            onfocus="tabla(flexiTipoDocumentoAsociado, 'Codigo Tipo Documento Asociado',
                                                'codtipodctoasociado_quejasDocumentos' )" onclick="tabla(flexiTipoDocumentoAsociado, 
                                                'Codigo Tipo Documento Asociado', 'codtipodctoasociado_quejasDocumentos' )"></select></td>


                            </tr>
                            <tr>
                                <td>Documento Entregado</td>
                                <td>Archivo Documento Entregado</td>

                            </tr>
                            <td>
                                <div id="switch_quedocentreg_quejasDocumentos"></div>
                                <input type="hidden" name="quedocentreg_quejasDocumentos" id="quedocentreg_quejasDocumentos" /></td>

                            <td><input name="quedocarchi_quejasDocumentos" type="text" id="quedocarchi_quejasDocumentos" value="" readonly="readonly" 
                                       onclick="abrirCargaArchivo('archivoactoadmin')" /> <a href="../descargarArchivo?nombreArchivo=" 
                                       target="_blank" onclick="this.href = reHref( this.href, 'quejarchdocu_quejasRegistro' )">
                                    <img src="../images/descargar_1.png" alt="Descargar" width="30" height="30" onclick="" /></a></td>
                        </table>
                    </div>
                    <div id="tabs-3"><br />
                        <div class="boton"><input type="submit" value="Mostrar Afectados Registradas" onclick="return tabla(flexiListaOpcion, 'Lista Opción', '' )" /></div>
                        <br />
                        <table>
                            <tr>

                                <td>C&oacute;digo &Uacute;nico de Familia</td>
                                <td>Consecutivo Queja</td>
                                <td>Tipo Identificacion Beneficiario</td>
                                <td>Edentificacion Beneficiario</td>

                            </tr>
                            <tr>
                                <td><select name="codunifami_quejasAfectados" id="codunifami_quejasAfectados" 
                                            onfocus="tabla(flexiQuejaBeneficiario, 'Codigo Unico Familia',
                                                'codunifami_quejasAfectados' )" onclick="tabla(flexiQuejaBeneficiario, 
                                                'Codigo Unico Familia', 'codunifami_quejasAfectados' )"></select></td>

                                <td><select name="quejconsecut_quejasAfectados" id="quejconsecut_quejasAfectados" 
                                            onfocus="tabla(flexiQuejas, 'Consecutivo Queja',
                                                'quejconsecut_quejasAfectados' )" onclick="tabla(flexiQuejas, 
                                                'Consecutivo Queja', 'quejconsecut_quejasAfectados' )"></select></td> 

                                <td><select name="codtipoidentidad_quejasAfectados" id="codtipoidentidad_quejasAfectados" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Codigo tipo identificacion',
                                                'codtipoidentidad_quejasAfectados' )" onclick="tabla(flexiTipoIdentificacion, 
                                                'Codigo tipo identificacion', 'codtipoidentidad_quejasAfectados' )"></select></td>
                                <td><input type="text" name="identbenef_quejasAfectados" id="identbenef_quejasAfectados" value=""/></td>
                            </tr>
                            <tr>
                                <td>Observaciones</td>
                            </tr>
                            <tr>
                                <td colspan = "4" ><textarea name="quebenobserv_quejaAfectados" id="quebenobserv_quejaAfectados"> </textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4"><br />
                        <div class="boton"><input type="submit" value="Mostrar Respuestas Registrados" onclick="return tabla(flexiNivelsegopcion, 'Lista Perfiles', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo &Uacute;nico de Familia</td>
                                <td>Consecutivo Queja</td>
                                <td>Fecha Respuesta Queja</td>
                                <td>C&oacute;digo Clasificaci&oacute;n Respuesta</td>
                            </tr>

                            <tr>
                                <td><select name="codunifami_quejasRespuestas" id="codunifami_quejasRespuestas" 
                                            onfocus="tabla(flexiQuejaBeneficiario, 'Codigo Unico Familia',
                                                'codunifami_quejasRespuestas' )" onclick="tabla(flexiQuejaBeneficiario, 
                                                'Codigo Unico Familia', 'codunifami_quejasRespuestas' )"></select></td>

                                <td><select name="quejconsecut_quejasRespuestas" id="quejconsecut_quejasRespuestas" 
                                            onfocus="tabla(flexiQuejas, 'Consecutivo Queja',
                                                'quejconsecut_quejasRespuestas' )" onclick="tabla(flexiQuejas, 
                                                'Consecutivo Queja', 'quejconsecut_quejasRespuestas' )"></select></td> 

                                <td><input type="text" name="queresfecha_quejaRespuestas" id="_fecha_queresfecha_quejaRespuestas" value=""/></td>

                                <td><select name="resclacodigo_quejasRespuestas" id="resclacodigo_quejasRespuestas" 
                                            onfocus="tabla(flexiRespuestaClasificacion, 'Codigo Clasificacion Respuesta',
                                                'resclacodigo_quejasRespuestas' )" onclick="tabla(flexiRespuestaClasificacion,
                                                'Codigo Clasificacion Respuesta', 'resclacodigo_quejasRespuestas' )"></select></td>
                            </tr>
                            <tr>
                                <td>Tipo Identificacion Funcionario</td>
                                <td>Documento Identidad de Funcionario</td>
                                <td colspan="2">Percepción Usuario ante Respuesta Queja</td>
                            </tr>

                            <tr>
                                <td><select name="codtipoidentidad_quejasRespuestas" id="codtipoidentidad_quejasRespuestas" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Codigo tipo identificacion',
                                                'codtipoidentidad_quejasRespuestas' )" onclick="tabla(flexiTipoIdentificacion, 
                                                'Codigo tipo identificacion', 'codtipoidentidad_quejasRespuestas' )"></select></td>
                                <td>
                                    <input type="text" name="numidentfunc_quejasRespuestas" id="numidentfunc_quejasRespuestas" value=""/>
                                </td>
                                <td colspan = "2" ><textarea name="querespercep_quejaRespuestas" id="querespercep_quejaRespuestas"> </textarea></td>
                            </tr>

                            <tr>
                                <td>C&oacute;digo Tipo de Satisfacci&oacute;n</td>
                                <td>Archivo Documento Respuesta Queja</td>
                                <td>Observaciones Respuesta</td>
                            </tr>

                            <tr>
                                <td><select name="codtipoidentidad_quejasRespuestas" id="codtipoidentidad_quejasRespuestas" 
                                            onfocus="tabla(flexiSatifaccionTipo, 'Código Tipo de Satisfacción',
                                                'codtipoidentidad_quejasRespuestas' )" onclick="tabla(flexiSatifaccionTipo, 
                                                'Código Tipo de Satisfacción', 'codtipoidentidad_quejasRespuestas' )"></select></td>
                                <td>
                                    <input name="queresarchiv_quejasRespuestas" type="text" id="queresarchiv_quejasRespuestas" value="" readonly="readonly" 
                                           onclick="abrirCargaArchivo('archivoactoadmin')" /> <a href="../descargarArchivo?nombreArchivo=" 
                                           target="_blank" onclick="this.href = reHref( this.href, 'queresarchiv_quejasRespuestas' )">
                                        <img src="../images/descargar_1.png" alt="Descargar" width="30" height="30" onclick="" /></a>
                                </td>
                                <td colspan = "2" ><textarea name="queresobserv_quejaRespuestas" id="queresobserv_quejaRespuestas"></textarea></td>
                            </tr>
                        </table>
                    </div>


                    <br />
                    <br />

                    <div class="clearBottom"></div>
                </div>
                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Quejas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Quejas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
            </form>
        </div>
   
    </body>
</html>
