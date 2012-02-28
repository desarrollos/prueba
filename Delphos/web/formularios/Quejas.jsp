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
            <div class="titulo">QUEJAS</div>
            <br />
            <form id="Quejas"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> <input type="hidden" name="pestana" id="pestana" value="Usuarios" />
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Quejas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Quejas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br /><br />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="quejas">Registro</a></li>
                        <li><a href="#tabs-2" id="quejadocumento">Documentos</a></li>
                        <li><a href="#tabs-3" id="quejabeneficiario">Afectados</a></li>
                        <li><a href="#tabs-4" id="quejarespuesta">Respuestas</a></li>


                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Resgistros Quejas" onclick="return tabla(flexiQuejas, 'Registro Quejas', '' )" /></div>
                        <br />
                        <table>

                            <tr>
                                <td>Código &Uacute;nico Familia</td>
                                <td>Consecutivo Queja</td>
                                <td>Ciclo Pago Afectado Queja</td>
                                <td>Tipo Identificaci&oacute;n Persona Queja</td>
                            </tr>
                            <tr>
                                <td> <select  id="codunifami_quejas" name="codunifami_quejas" onfocus="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_quejas' )" onclick="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_quejas' )"></select></td>
                                <td> <input type="text" id="quejconsecut_quejas" name="quejconsecut_quejas"/></td>
                                <td> <input type="text" id="quejciclpago_quejas" name="quejciclpago_quejas"/></td>
                                <td> <select  id="codtipoidentidadpers_quejas" name="codtipoidentidadpers_quejas" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n Persona Queja', 'codtipoidentidadpers_quejas' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n Persona Queja', 'codtipoidentidadpers_quejas' )"></select></td>
                            </tr>
                            <tr>
                                <td>Identificación Persona Queja</td>
                                <td>Fecha Queja</td>
                                <td>Código Tipo de Queja</td>
                                <td>Tipo Identificacion Funcionario Recibe la Queja</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="quejidentifi_quejas" name="quejidentifi_quejas"/></td>
                                <td><input type="text" id="_fecha_quejfecha_quejas" name="quejfecha_quejas" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <select  id="quejaclasificacion_quejas_1" name="quejaclasificacion_quejas_1" onfocus="tabla(flexiQuejaClasificacion, 'Código Tipo de Queja', 'quejaclasificacion_quejas_1' )" onclick="tabla(flexiQuejaClasificacion, 'Código Tipo de Queja', 'quejaclasificacion_quejas_1' )"></select></td>

                                <td> <select  id="codtipoidentidad_quejas" name="codtipoidentidad_quejas" onfocus="tabla(flexiTipoIdentificacion,
                                    'Tipo Identificaci&oacute;n Funcionario Recibe Queja', 'codtipoidentidad_quejas' )"
                                              onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n Persona Queja', 'codtipoidentidad_quejas' )"></select></td>
                            </tr>
                            <tr>
                                <td>Numero Dcumento Funcionario</td>
                                <td>Archivo Documento Queja</td>
                                <td>Observaciones Queja</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="numidentfunc_quejas" name="numidentfunc_quejas"/></td>
                                <td><input name="quejarchdocu_quejas" type="text" id="quejarchdocu_quejas" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('quejarchdocu_quejas')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('quejarchdocu_quejas' )" alt="Descargar" /></td>
                                <td colspan="2"><textarea id="quejobservac_quejas" name="quejobservac_quejas" cols="50" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2"><br />
                        <div class="boton"><input type="submit" value="Mostrar Documentos Registrados" onclick="return tabla(flexiDocumentoQuejas, 'Grupos Seguridad', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo &Uacute;nico de Familia</td>
                                <td>C&oacute;digo Tipo Documento Asociado</td>



                            </tr>
                            <tr>
                                <td><select name="quejas_quejadocumento_1" id="quejas_quejadocumento_1" 
                                            onfocus="tabla(flexiQuejas, 'Quejas',
                                                'quejas_quejadocumento_1' )" onclick="tabla(flexiQuejas, 
                                                'Quejas', 'quejas_quejadocumento_1' )"></select></td>


                                <td><select name="codtipodctoasociado_quejadocumento" id="codtipodctoasociado_quejadocumento" 
                                            onfocus="tabla(flexiTipoDocumentoAsociado, 'Codigo Tipo Documento Asociado',
                                                'codtipodctoasociado_quejadocumento' )" onclick="tabla(flexiTipoDocumentoAsociado, 
                                                'Codigo Tipo Documento Asociado', 'codtipodctoasociado_quejadocumento' )"></select></td>


                            </tr>
                            <tr>
                                <td>Documento Entregado</td>
                                <td>Archivo Documento Entregado</td>

                            </tr>
                            <td>

                                <div id="switch_quedocentreg_quejadocumento"></div>
                                <input type="hidden" name="quedocentreg_quejadocumento" id="quedocentreg_quejadocumento" />


                                <td><input name="quedocarchi_quejadocumento" type="text" id="quedocarchi_quejadocumento"
                                           size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('quedocarchi_quejadocumento')" /> 
                                    <img src="../images/descargar_1.png" width="30" height="30"  alt="Subir Archivo" onclick="reHref('quedocarchi_quejadocumento' )" /></td>

                        </table>
                    </div>
                    <div id="tabs-3"><br />
                        <div class="boton"><input type="submit" value="Mostrar Afectados Registradas" onclick="return tabla(flexiQuejaBeneficiario, 'Beneficiarios Afectados Queja', '' )" /></div>
                        <br />
                        <table>

                            <tr>
                                <td>Quejas</td>
                                <td>Beneficiario</td>
                            </tr>
                            <tr>
                                <td> <select  id="quejas_quejabeneficiario_1" name="quejas_quejabeneficiario_1" 
                                              onfocus="tabla(flexiQuejas, 'Quejas', 'quejas_quejabeneficiario_1' )" 
                                              onclick="tabla(flexiQuejas, 'Quejas', 'quejas_quejabeneficiario_1' )"></select></td>

                                <td> <select  id="beneficiario_quejabeneficiario_1" name="beneficiario_quejabeneficiario_1" 
                                              onfocus="tabla(flexiBeneficiario, 'Queja', 'beneficiario_quejabeneficiario_1' )" 
                                              onclick="tabla(flexiBeneficiario, 'Queja', 'beneficiario_quejabeneficiario_1' )"></select></td>

                            </tr>
                            <tr>
                                <td>Observaciones Beneficiario Queja</td>
                            </tr>
                            <tr>
                                <td colspan="2"> <textarea id="quebenobserv_quejabeneficiario" name="quebenobserv_quejabeneficiario" 
                                                           cols="50" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4"><br />
                        <div class="boton"><input type="submit" value="Mostrar Respuestas Registrados" onclick="return tabla(flexiQuejaRespuesta, 'Respuestas Quejas', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Quejas</td>
                                <td>Fecha Respuesta Queja</td>
                                <td>C&oacute;digo Clasificaci&oacute;n Respuesta</td>
                            </tr>

                            <tr>
                                <td><select name="quejas_quejarespuesta_1" id="quejas_quejarespuesta_1" 
                                            onfocus="tabla(flexiQuejas, 'Quejas',
                                                'quejas_quejarespuesta_1' )" onclick="tabla(flexiQuejaBeneficiario, 
                                                'Quejas', 'quejas_quejarespuesta_1' )"></select></td>


                                <td><input type="text" name="queresfecha_quejarespuesta" readonly="readonly" id="_fecha_queresfecha_quejarespuesta" value=""/></td>

                                <td><select name="resclacodigo_quejarespuesta" id="resclacodigo_quejarespuesta" 
                                            onfocus="tabla(flexiRespuestaClasificacion, 'Codigo Clasificacion Respuesta',
                                                'resclacodigo_quejarespuesta' )" onclick="tabla(flexiRespuestaClasificacion,
                                                'Codigo Clasificacion Respuesta', 'resclacodigo_quejarespuesta' )"></select></td>
                            </tr>
                            <tr>
                                <td>Tipo Identificacion Funcionario</td>
                                <td>Documento Identidad de Funcionario</td>
                                
                            </tr>

                            <tr>
                                <td><select name="codtipoidentidad_quejarespuesta" id="codtipoidentidad_quejarespuesta" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Codigo tipo identificacion',
                                                'codtipoidentidad_quejarespuesta' )" onclick="tabla(flexiTipoIdentificacion, 
                                                'Codigo tipo identificacion', 'codtipoidentidad_quejarespuesta' )"></select></td>
                                <td>
                                    <input type="text" name="numidentfunc_quejarespuesta" id="numidentfunc_quejarespuesta" value=""/>
                                </td>
                                
                            </tr>

                            <tr>
                                <td>C&oacute;digo Tipo de Satisfacci&oacute;n</td>
                                <td>Archivo Documento Respuesta Queja</td>
                                
                            </tr>

                            <tr>
                                <td><select name="tipsatcodigo_quejarespuesta" id="tipsatcodigo_quejarespuesta" 
                                            onfocus="tabla(flexiSatifaccionTipo, 'Código Tipo de Satisfacción',
                                                'tipsatcodigo_quejarespuesta' )" onclick="tabla(flexiSatifaccionTipo, 
                                                'Código Tipo de Satisfacción', 'tipsatcodigo_quejarespuesta' )"></select></td>
                                
                                <td><input name="queresarchiv_quejarespuesta" type="text" id="queresarchiv_quejarespuesta"
                                           size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('queresarchiv_quejarespuesta')" /> 
                                    <img src="../images/descargar_1.png" width="30" height="30"  alt="Subir Archivo" onclick="reHref('queresarchiv_quejarespuesta' )" /></td>
                                
                            </tr>
                            <tr>
                                <td colspan="2">Percepción Usuario ante Respuesta Queja</td>
                                
                            </tr>
                            <tr>
                                <td colspan = "2" ><textarea name="querespercep_quejarespuesta" id="querespercep_quejarespuesta" cols="45"></textarea></td>
                            </tr>
                            <tr>
                                <td>Observaciones Respuesta</td>
                                
                            </tr>
                            <tr>
                                <td colspan = "2" ><textarea name="queresobserv_quejarespuesta" id="queresobserv_quejarespuesta" cols="45"></textarea></td>
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
