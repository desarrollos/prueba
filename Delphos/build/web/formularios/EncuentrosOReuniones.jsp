<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %><%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %><%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %><%
    clases.VerificarUsuarioSistema v;
    v = new clases.VerificarUsuarioSistema(request, response);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="generator" content="HTML Tidy for Linux (vers 6 November 2007), see www.w3.org" />
        <script type="text/javascript" src="../js/jquery/jquery.js">
        </script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" /><!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" /><!--  <script type="text/javascript" src="../js/jquery/jquery.js"></script>  -->
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css" />
        <script type="text/javascript" src="../js/formularios/funciones.js">
        </script>
        <script type="text/javascript" src="../js/formularios/EncuentrosOReuniones.js">
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

        <style type="text/css">
            /*<![CDATA[*/
            body {
                background-color: #FFFFFF;
            }
            div.c5 {text-align: center}
            table.c4 {height: 780; border: 0px}
            td.c3 {background: url('../images/back.png')}
            td.c2 {background: url('../images/panel_02.gif')}
            div.c1 {display: none}
            /*]]>*/
        </style>
    </head>
    <body>
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <div id="tablaContenedor"></div>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Encuentros o reuniones" /> <input type="hidden" id="servlet" value="EncuentrosOReuniones" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ENCUENTROS O REUNIONES</div>
            <br />
            <form id="EncuentrosOReuniones" name="EncuentrosOReuniones">
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('EncuentrosOReuniones', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('EncuentrosOReuniones', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                <br />
                <br />
                <input type="hidden" name="pestana" id="pestana" value="Reuniones" /> <input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="Reuniones" name="Reuniones">Reuniones</a></li>
                        <li><a href="#tabs-2" id="Asistencia" name="Asistencia">Asistencia Reuniones</a></li>
                        <li><a href="#tabs-3" id="Actividades" name="Actividades">Actividades Realizadas</a></li>
                        <li><a href="#tabs-4" id="Asistentes" name="Asistentes">Asistentes Reuniones</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="boton"><input type="submit" value="Mostrar reuniones registradas" onclick="tabla(flexiEncuentroreunion, 'Reuniones', '' ); return false" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Código</td>
                                <td>Tipo Reunión</td>
                                <td>Departamento</td>
                                <td>Municipio</td>
                            </tr>
                            <tr>
                                <td><input name="encuencodigo_reuniones" type="text" id="encuencodigo_reuniones" value="" maxlength="6" /></td>
                                <td><select name="coditiporeun_reuniones" id="coditiporeun_reuniones" onfocus="tabla(flexiTipoReunion, 'Departamento', 'coditiporeun_reuniones' )" onclick="tabla(flexiTipoReunion, 'Departamento', 'coditiporeun_reuniones' )"></select></td>
                                <td><select name="coddepartamento_reuniones" id="coddepartamento_reuniones" 
                                            onfocus="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_reuniones' )"
                                            onclick="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_reuniones' )"></select></td>
                                <td><select name="codmunicipio_reuniones" id="codmunicipio_reuniones" onfocus="tabla(flexiMunicipio, 'Municipio', 'codmunicipio_reuniones' )" onclick="tabla(flexiMunicipio, 'Municipio', 'codmunicipio_reuniones' )"></select></td>
                            </tr>
                            <tr>
                                <td>Direcci&oacute;n</td>
                                <td>Lugar Referencia</td>
                                <td>Fecha</td>
                                <td>N&uacute;mero Participantes</td>
                            </tr>
                            <tr>
                                <td><input type="text" name="encuendirecc_reuniones" id="encuendirecc_reuniones" value="" /></td>
                                <td><input type="text" name="enculugarefe_reuniones" id="enculugarefe_reuniones" value="" /></td>
                                <td><input name="encuenfecha_reuniones" type="text" id="_fecha_encuenfecha_reuniones" value="" maxlength="19" readonly="readonly" /></td>
                                <td><input type="text" name="encunumepart_reuniones" id="encunumepart_reuniones" value="" /></td>
                            </tr>
                            <tr>
                                <td>Tipo Identificación Madre Lider</td>
                                <td>Numero Identificación Madre Lider</td>
                                <td>Fecha Informe</td>
                                <td>Archivo Documento Encuentro o Reunión</td>
                            </tr>
                            <tr>
                                <td><select name="codtipoidentidad_reuniones" id="codtipoidentidad_reuniones" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_reuniones' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_reuniones' )"></select></td>
                                <td><input type="text" name="encidemadlid_reuniones" id="encidemadlid_reuniones" /></td>
                                <td><input name="encufechinfo_reuniones" type="text" id="_fecha_encufechinfov" value="" maxlength="19" readonly="readonly" /></td>
                                <td><input name="encuarchdocu_reuniones" type="text" id="encuarchdocu_reuniones" 
                                           onclick="abrirCargaArchivo('encuarchdocu_reuniones')" value="" readonly="readonly" /> 
                                        <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('encuarchdocu_reuniones' )" alt="Descargar"/></a></td>
                            </tr>
                            <tr>
                                <td>Tipo Sistema</td>
                                <td>Propósito</td>
                                <td>Objetivo</td>
                                <td>Soluciones Encontradas</td>
                            </tr>
                            <tr>
                                <td><select name="tisiscodigo_reuniones" id="tisiscodigo_reuniones" onfocus="tabla(flexiTipoSistema, 'Tipo Sistema', 'tisiscodigo_reuniones' )" onclick="tabla(flexiTipoSistema, 'Tipo Sistema', 'tisiscodigo_reuniones' )"></select></td>
                                <td>
                                    <textarea name="encuenpropos_reuniones" id="encuenpropos_reuniones" cols="20" rows="4"></textarea></td>
                                <td>
                                    <textarea name="encuenobjeti_reuniones" id="encuenobjeti_reuniones" cols="20" rows="4"></textarea></td>
                                <td>
                                    <textarea name="encusoluenco_reuniones" id="encusoluenco_reuniones" cols="20" rows="4"></textarea></td>
                            </tr>
                            <tr>
                                <td>Observaciones</td>
                                <td>Archivo</td>
                                <td colspan="2">Tema Principal</td>
                            </tr>
                            <tr>
                                <td>
                                    <textarea name="encuenobserv_reuniones" cols="20" rows="4" id="encuenobserv_reuniones">
                                    </textarea></td>
                                
                                <td><input name="archivofi_reuniones" type="text" id="archivofi_reuniones" 
                                           onclick="abrirCargaArchivo('archivofi_reuniones')" value="" readonly="readonly" />
                                        <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archivofi_reuniones' )" alt="Descargar"/></a></td>
                                <td colspan="2">
                                    
                                    <textarea name="encutemaprin_reuniones" cols="45" rows="5" id="encutemaprin_reuniones">
                                    </textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2">
                        <div class="boton"><input type="submit" value="Mostrar asistencias registradas" onclick="tabla(flexiAsistencia, 'Asistencia Reuniones', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td>Código</td>
                                <td>Código Unico Familia</td>
                                <td>Tipo Identificación</td>
                                <td>Número Identificación</td>
                                <td>Pertenece Programa</td>
                            </tr>
                            <tr>
                                <td><select name="encuencodigo_asistencias" id="encuencodigo_asistencias" onclick="tabla(flexiEncuentroreunion, 'Reuniones', 'encuencodigo_asistencias' )"></select></td>
                                <td><select name="codunifami_asistencias" id="codunifami_asistencias" onclick="tabla(flexiInscripcion, 'Inscripción', 'codunifami_asistencias' )"></select></td>
                                <td><select name="codtipoidentidads_asistencias" id="codtipoidentidads_asistencias" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidads_asistencias' )"></select></td>
                                <td><input name="asisteidentis_asistencias" type="text" id="asisteidentis_asistencias" value="" /></td>
                                                                <td>
                                    <div id="switch_asispertprog_asistencias"></div>
                                    <input type="hidden" name="asispertprog_asistencias" id="asispertprog_asistencias" value="n" /></td>

                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar actividades registradas" onclick="tabla(flexiEncuentroactividad, 'Actividades', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td>Código</td>
                                <td>Tipo Actividad</td>
                                <td>Funcionario Tipo Identificaci&oacute;n</td>
                                <td>Funcionario N&uacute;mero Identificaci&oacute;n</td>
                            </tr>
                            <tr>
                                <td><select name="encuencodigos_actividades" id="encuencodigos_actividades"
                                            onclick="tabla(flexiEncuentroreunion, 'Reuniones', 'encuencodigos_actividades' )"></select></td>
                                
                                <td><select name="codtipoactividads_actividades" id="codtipoactividads_actividades"
                                            onclick="tabla(flexiTipoActividad, 'Reuniones', 'codtipoactividads_actividades' )"></select></td>
                                
                                <td><select name="codtipoidentidad_actividades" id="codtipoidentidad_actividades"
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_actividades' )"></select></td>
                                
                                <td><input type="text" name="numidentfunc_actividades" id="numidentfunc_actividades" /></td>
                                
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4">
                        <div class="boton"><input type="submit" value="Mostrar asistentes registrados" onclick="tabla(flexiAsistenteExterno, 'Asistente Externo', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td>Código</td>
                                <td>Tipo Identificación</td>
                                <td>Número Identificación</td>
                                <td>Nombres</td>
                                <td>Apellidos</td>
                            </tr>
                            <tr>
                                <td><select name="encuencodigo_asistentes" id="encuencodigo_asistentes"
                                            onclick="tabla(flexiEncuentroreunion, 'Reuniones', 'encuencodigo_asistentes' )"
                                            onfocus="tabla(flexiEncuentroreunion, 'Reuniones', 'encuencodigo_asistentes' )"></select></td>
                                
                                <td><select name="codtipoidentidad_asistentes" id="codtipoidentidad_asistentes"
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_asistentes' )" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_asistentes' )"></select></td>
                                
                                <td><input name="externidenti_asistentes" type="text" id="externidenti_asistentes" /></td>
                                <td><input type="text" name="asiextnombre_asistentes" id="asiextnombre_asistentes" /></td>
                                <td><input type="text" name="asiextapellido_asistentes" id="asiextapellido_asistentes" /></td>
                            </tr>
                            <tr>
                                <td>Tipo Asistente</td>
                                <td colspan="4">Observación</td>
                            </tr>
                            <tr>
                                <td><select name="tipasicodigo_asistentes" id="tipasicodigo_asistentes"
                                            onclick="tabla(flexiTipoAsistente, 'Tipo Identificación', 'tipasicodigo_asistentes' )"
                                            onfocus="tabla(flexiTipoAsistente, 'Tipo Identificación', 'tipasicodigo_asistentes' )"></select></td>
                                <td colspan="4">
                                    <textarea name="exterobserv_asistentes" cols="95" rows="3" id="exterobserv_asistentes">
                                    </textarea></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('EncuentrosOReuniones', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('EncuentrosOReuniones', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
        </div>
        <div class="c5">
            <table id="Table_01" width="906" class="c4" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3"><img src="../images/cabezote.png" width="906" height="150" alt="" /></td>
                </tr>
                <%-- Datos sesion --%>
                <tr valign="top">
                    <td colspan="3" width="906" height="16" class="c2" align="right"><span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a></td>
                </tr>
                <%-- Datos sesion --%>
                <tr>
                    <td class="c3" width="234" valign="top">
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
    </body>
