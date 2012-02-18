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
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" /><!--  <script type="text/javascript" src="../js/jquery/jquery.js"></script>  -->
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css" />
        <script type="text/javascript" src="../js/formularios/funciones.js">
        </script>
        <script type="text/javascript" src="../js/formularios/EntidadSalud.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../js/flexigrid/css/flexigrid.css" />
        <script type="text/javascript" src="../js/flexigrid/js/flexigrid.js">
        </script>
        <script type="text/javascript" src="../js/ajax-switch/ajax-switch/jquery.iphone-switch.js">
        </script>
        <style type="text/css">
            /*<![CDATA[*/
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
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Entidades de salud" /> <input type="hidden" id="servlet" value="EntidadSalud" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">TIPO ENTIDADES DE SALUD</div>
            <br />
            <div>
                <form id="EntidadSalud" method="post" accept-charset="utf-8" name="EntidadSalud"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" id="codregimentabla" name="codregimentabla" /> <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Entidades Registradas" onclick="return tabla(flexiEntidadSalud, 'Entidades de Salud', '' )" /> <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('EntidadSalud', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('EntidadSalud', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>Empresa</td>
                            <td>Régimen</td>
                            <td>Código Entidad Salud</td>
                            <td>Tipo Entidad Salud</td>
                        </tr>
                        <tr>
                            <td><select name="empresa_entidadsalud" id="empresa_entidadsalud" onclick="tabla(flexiEmpresas, 'Empresas registradas', 'empresa_entidadsalud' )" onfocus="tabla(flexiEmpresas, 'Empresas registradas', 'empresa_entidadsalud' )"></select></td>
                            <td><select name="codregimenes_entidadsalud" id="codregimenes_entidadsalud" onclick="tabla(flexiRegimen, 'Regimen', 'codregimenes_entidadsalud' )" onfocus="tabla(flexiRegimen, 'Regimen', 'codregimenes_entidadsalud' )"></select></td>
                            <td><input name="codentidadsalud_entidadsalud" type="text" id="codentidadsalud_entidadsalud" value="" /></td>
                            <td><select name="codtipoentidadsalud_entidadsalud" id="codtipoentidadsalud_entidadsalud" onfocus="tabla(flexiEntidad, 'Entidad Salud', 'codtipoentidadsalud_entidadsalud' )" onclick="tabla(flexiEntidad, 'Entidad Salud', 'codtipoentidadsalud_entidadsalud' )">
                                    <option value="0"></option>
                                </select></td>
                        </tr>
                        <tr>
                            <td>Nivel Complejidad</td>
                            <td>Clasificación Entidad</td>
                            <td>Contacto</td>
                            <td>Cargo Contacto</td>
                        </tr>
                        <tr>
                            <td><select name="codnivelcomplejidad" id="codnivelcomplejidad" onclick="tabla(flexiComplejidad, 'Complejidades', 'codnivelcomplejidad')" onfocus="tabla(flexiComplejidad, 'Complejidades', 'codnivelcomplejidad')"></select></td>
                            <td><select name="codclasifentidad" id="codclasifentidad" onclick="tabla(flexiClasificacionentidad, 'Clasificacion entidad', 'codclasifentidad')" onfocus="tabla(flexiClasificacionentidad, 'Clasificacion entidad', 'codclasifentidad')">
                                    <option value="0"></option>
                                </select></td>
                            <td><input name="contacto" type="text" id="contacto" value="" maxlength="60" /></td>
                            <td><input name="cargocontacto" type="text" id="cargocontacto" value="" maxlength="30" /></td>
                        </tr>
                        <tr>
                            <td>Línea Gratuita</td>
                            <td>Número Funcionarios</td>
                            <td>Código Barras</td>
                            <td>Logo</td>
                        </tr>
                        <tr>
                            <td><input name="lineagratuita" type="text" id="lineagratuita" value="" maxlength="20" /></td>
                            <td><input name="funcionarios" type="text" id="funcionarios" value="0" /></td>
                            <td><input name="codigobarras" type="text" id="codigobarras" value="" /></td>
                            <td><input name="logo" type="text" id="logo" onclick="abrirCargaArchivo('logo')" value="" readonly="readonly" /> <!--<img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('logo')"/>-->
                                <img src="../images/descargar_1.png" alt="Descargar" width="30" height="30" onclick="reHref('logo' )" /></a></td>
                        </tr>
                        <tr>
                            <td>Código Habilitación</td>
                            <td>Nombre Habilitación</td>
                            <td>Tipo Especialización</td>
                            <td>Tipo Atención</td>
                        </tr>
                        <tr>
                            <td><input name="codhabilitacion" type="text" id="codhabilitacion" value="" /></td>
                            <td><input name="nombrehabilitacion" type="text" id="nombrehabilitacion" value="" /></td>
                            <td><select name="codtipoespecializacion" id="codtipoespecializacion" onclick="tabla(flexiTipoespecializacionsalud, 'Tipo especializacion salud', 'codtipoespecializacion')" onfocus="tabla(flexiTipoespecializacionsalud, 'Tipo especializacion salud', 'codtipoespecializacion')"></select></td>
                            <td><select name="codtipoatencion" id="codtipoatencion" tabindex="16" onclick="tabla(flexiTipoatencion, 'Tipo atencion', 'codtipoatencion')" onfocus="tabla(flexiTipoatencion, 'Tipo atencion', 'codtipoatencion')">
                                    <option value="0"></option>
                                </select></td>
                        </tr>
                        <tr>
                            <td>Estado Entidad</td>
                            <td>Número Acto Inscripción</td>
                            <td>Fecha Acto Administrativo</td>
                            <td>Archivo Acto Administrativo</td>
                        </tr>
                        <tr>
                            <td><select name="codestadoentidad" id="codestadoentidad" onclick="tabla(flexiEstadoentidadsalud, 'Estado entidad salud', 'codestadoentidad')" onfocus="tabla(flexiEstadoentidadsalud, 'Estado entidad salud', 'codestadoentidad')"></select></td>
                            <td><input name="numactoinscripcion" type="text" id="numactoinscripcion" value="" /></td>
                            <td><input name="fechaactoadmin" type="text" id="fechaactoadmin" value="" readonly="readonly" /></td>
                            <td><input name="archivoactoadmin" type="text" id="archivoactoadmin" value="" readonly="readonly" 
                                       onclick="abrirCargaArchivo('archivoactoadmin')" /> 
                                    <img src="../images/descargar_1.png" alt="Descargar" width="30" height="30" onclick="reHref( 'archivoactoadmin' )" /></a></td>
                        </tr>
                        <tr>
                            <td>Archivo Adicional Entidad 1</td>
                            <td>Archivo Adicional Entidad 2</td>
                        </tr>
                        <tr>
                            <td><input name="archivofi" type="text" id="archivofi" value="" readonly="readonly" onclick="abrirCargaArchivo('archivofi')" /> <!--<img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('archivofi')"/>-->
                                    <img src="../images/descargar_1.png" alt="Descargar" width="30" height="30" onclick="reHref('archivofi' )" /></a></td>
                            
                            <td><input name="archivofi2" type="text" id="archivofi2" value="" readonly="readonly" onclick="abrirCargaArchivo('archivofi2')" /> <!--<img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('archivofi2')"/>-->
                                    <img src="../images/descargar_1.png" alt="Descargar" width="30" height="30" onclick="reHref('archivofi2' )" /></a></td>
                        </tr>
                        <tr>
                            <td colspan="4"Eslogan</td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <textarea name="slogan" id="slogan" cols="115" rows="7">
                                </textarea></td>
                        </tr>
                    </table>
                    <br />
                    <!-- Acciones estan 
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('EntidadSalud', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('EntidadSalud', 'Actualizar', ''); return false" class="c2" /> <!-- <input type="submit" id="eliminar2" value="Eliminar" onclick="accionFormulario('EntidadSalud', 'Eliminar', ''); return false" style="display:none" />-->
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
        <div class="c6">
            <table id="Table_01" width="906" class="c5" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3"><img src="../images/cabezote.png" width="906" height="150" alt="" /></td>
                </tr>
                <tr valign="top">
                    <td colspan="3" width="906" height="16" class="c3" align="right"><span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a></td>
                </tr>
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
    </body>
</html>