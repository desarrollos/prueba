<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %><%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %><%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %><%
    clases.VerificarUsuarioSistema v;
    v = new clases.VerificarUsuarioSistema(request, response);


%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="generator" content="HTML Tidy for Linux (vers 6 November 2007), see www.w3.org" />
        <script type="text/javascript" src="../js/jquery/jquery.js">
        </script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" /><!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css" />
        <script type="text/javascript" src="../js/formularios/funciones.js">
        </script>
        <script type="text/javascript" src="../js/formularios/Usuarios.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../js/flexigrid/css/flexigrid.css" />
        <script type="text/javascript" src="../js/flexigrid/js/flexigrid.js">
        </script>
        <script type="text/javascript" src="../js/ajax-switch/ajax-switch/jquery.iphone-switch.js">
        </script>
        <style type="text/css">
            /*<![CDATA[*/
            body {
                background-color: #FFFFFF;
            }
            div.c6 {text-align: center}
            table.c5 {height: 780; border: 0px}
            td.c4 {background: url('../images/back.png')}
            td.c3 {background: url('../images/panel_02.gif')}
            input.c2 {display:none}
            div.c1 {display: none}
            /*]]>*/
        </style>
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
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Quejas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Quejas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
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

                                <td>Identificaci�n Persona Queja</td>
                                <td>Fecha Queja</td>
                                <td>C�digo Tipo de Queja</td>
                                <td>C�digo Clasificaci�n Queja</td>

                            </tr>
                            <tr>

                                <td><input type="text" name="quejidentifi_qiejaRegistro" id="quejidentifi_qiejaRegistro" value="" /></td>
                                <td><input type="text" name="quejfecha_qiejaRegistro" id="_fecha_quejfecha_qiejaRegistro" value="" /></td>
                                <td><select name="tipquecodigo_quejasRegistro" id="tipquecodigo_quejasRegistro" 
                                            onfocus="tabla(flexiTipoQueja, 'Codigo tipo Queja',
                                                'tipquecodigo_quejasRegistro' )" onclick="tabla(flexiTipoQueja, 
                                                'C�digo Tipo de Queja', 'tipquecodigo_quejasRegistro' )"></select></td>
                                <td><select name="queclacodigo_quejasRegistro" id="queclacodigo_quejasRegistro" 
                                            onfocus="tabla(flexiQuejaClasificacion, 'C�digo Clasificaci�n Queja',
                                                'queclacodigo_quejasRegistro' )" onclick="tabla(flexiflexiQuejaClasificacionTipoQueja, 
                                                'C�digo Clasificaci�n Queja', 'queclacodigo_quejasRegistro' )"></select></td>
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
                        <div class="boton"><input type="submit" value="Mostrar Afectados Registradas" onclick="return tabla(flexiListaOpcion, 'Lista Opci�n', '' )" /></div>
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
                                <td colspan="2">Percepci�n Usuario ante Respuesta Queja</td>
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
                                            onfocus="tabla(flexiSatifaccionTipo, 'C�digo Tipo de Satisfacci�n',
                                                'codtipoidentidad_quejasRespuestas' )" onclick="tabla(flexiSatifaccionTipo, 
                                                'C�digo Tipo de Satisfacci�n', 'codtipoidentidad_quejasRespuestas' )"></select></td>
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
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Quejas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Quejas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
            </form>
        </div>
        <div class="c6">
            <table id="Table_01" width="906" class="c5" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3"><img src="../images/cabezote.png" width="906" height="150" alt="" /></td>
                </tr>
                <%-- Datos sesion --%>
                <tr valign="top">
                    <td colspan="3" width="906" height="16" class="c3" align="right"><span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a></td>
                </tr>
                <%-- Datos sesion --%>
                <tr>
                    <td class="c4" width="234" valign="top">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top"></td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top"></td>
                </tr>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td height="42" colspan="3"><img src="../images/panel_07.gif" width="906" height="23" alt="" /></td>
                </tr>
            </table>
        </div>
        <!-- End ImageReady Slices -->
    </body>
</html>