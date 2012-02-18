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
        <script type="text/javascript" src="../js/formularios/Empresas.js">
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
        <div id="ajax" class="c1"></div>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <div id="tablaContenedor"></div>
        <input type="hidden" name="postfijo" value="empresa"></input>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Empresas" /> <input type="hidden" id="servlet" value="Empresas" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">EMPRESAS</div>
            <br />
            <form id="Empresas"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> 
                <div class="boton">
                    <input type="submit" value="Mostrar Empresas Registradas" onclick="return tabla(flexiEmpresas, 'Empresas', '' )" />
                    <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Empresas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Empresas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                <br />

                <table>
                    <tr>
                        <td>Tipo Identificaci&oacute;n</td>
                        <td>Identificaci&oacute;n Empresa</td>
                        <td>D&iacute;gito Verificaci&oacute;n</td>
                        <td>Nombre Empresa</td>
                        <td>Sigla</td>

                    </tr>
                    <tr>
                        <td><select name="codtipoidentidad_empresa" id="codtipoidentidad_empresa" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_empresa' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_empresa' )"></select></td>
                        <td><input name="codempresa_empresa" type="text" id="codempresa_empresa" value="" /></td>
                        <td><input name="digitoverificacion_empresa" type="text" id="digitoverificacion_empresa" value="" /></td>
                        <td><input name="nombre_empresa" type="text" id="nombre_empresa" value="" /></td>
                        <td><input name="sigla_empresa" type="text" id="sigla_empresa" value="" /></td>
                    </tr>
                    <tr>
                        <td>Tel&eacute;fono</td>
                        <td>Fax</td>
                        <td>L&iacute;nea Gratuita</td>
                        <td>Departamento</td>
                        <td>Municipio</td>
                    </tr>
                    <tr>
                        <td><input name="telefono_empresa" type="text" id="telefono_empresa" value="" /></td>
                        <td><input name="fax_empresa" type="text" id="fax_empresa" value="" /></td>
                        <td><input name="lineagratuita_empresa" type="text" id="lineagratuita_empresa" value="" /></td>

                        <td><select name="coddepartamento_empresa" id="coddepartamento_empresa" 
                                    onfocus="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_empresa' )" 
                                    onclick="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_empresa' )"></select></td>


                        <td><select name="codmunicipio_empresa" id="codmunicipio_empresa" 
                                    onfocus="tabla(flexiMunicipio, 'Municipio', 'codmunicipio_empresa' )" 
                                    onclick="tabla(flexiMunicipio, 'Municipio', 'codmunicipio_empresa' )"></select></td>




                    </tr>
                    <tr>
                        <td>C&oacute;digo Sector</td>
                        <td>C&oacute;digo Barrio</td>
                        <td>Direcci&oacute;n</td>
                        <td>Gerente</td>
                        <td>C&oacute;digo Actividad Econ&oacute;mica</td>
                    </tr>
                    <tr>


                        <td><select name="codsubgrupo_empresa" id="codsubgrupo_empresa" 
                                    onfocus="tabla(flexiSubGrupoGeografico, 'Sector', 'codsubgrupo_empresa' )" 
                                    onclick="tabla(flexiSubGrupoGeografico, 'Sector', 'codsubgrupo_empresa' )"></select></td>


                        <td><select name="codbarrio_empresa" id="codbarrio_empresa" 
                                    onfocus="tabla(flexiBarrio, 'Barrio', 'codbarrio_empresa' )" 
                                    onclick="tabla(flexiBarrio, 'Barrio', 'codbarrio_empresa' )"></select></td>


                        <td><input name="direccion_empresa" type="text" id="direccion_empresa" value="" /></td>
                        <td><input name="gerente_empresa" type="text" id="gerente_empresa" value="" /></td>
                        <td><select name="codactividadeconomica_empresa" id="codactividadeconomica_empresa" onfocus="tabla(flexiActividadEconomica, 'Actividad Economica', 'codactividadeconomica_empresa' )" onclick="tabla(flexiActividadEconomica, 'Actividad Economica', 'codactividadeconomica_empresa' )"></select></td>
                    </tr>
                    <tr>
                        <td>
                            Sector Entidad
                        </td>
                        <td>Tipo Aportante</td>
                        <td>Correo Electronico</td>
                        <td>P&aacute;gina Web</td>
                        <td>Tipo Contribuyente DIAN</td>
                    </tr>
                    <tr>
                        <td><select name="codsectorentidad_empresa" id="codsectorentidad_empresa" 
                                    onfocus="tabla(flexiSectorEntidad, 'Sector Entidad', 'codsectorentidad_empresa' )" 
                                    onclick="tabla(flexiSectorEntidad, 'Sector Entidad', 'codsectorentidad_empresa' )"></select></td>

                        <td><select name="codtipoaportante_empresa" id="codtipoaportante_empresa" 
                                    onfocus="tabla(flexiTipoAportante, 'Tipo Aportante', 'codtipoaportante_empresa' )" 
                                    onclick="tabla(flexiTipoAportante, 'Tipo Aportante', 'codtipoaportante_empresa' )"></select></td>

                        <td><input name="email_empresa" type="text" id="email_empresa" value="" /></td>
                        <td><input name="paginaweb_empresa" type="text" id="paginaweb_empresa" value="" /></td>

                        <td><select name="codtipocontribuyente_empresa" id="codtipocontribuyente_empresa" 
                                    onfocus="tabla(flexiTipoContribuyente, 'Tipo Tipo Contribuyente', 'codtipocontribuyente_empresa' )" 
                                    onclick="tabla(flexiTipoContribuyente, 'Tipo Tipo Contribuyente', 'codtipocontribuyente_empresa' )"></select></td>



                    </tr>

                    <tr>
                        <td>C&oacute;digo Tipo Persona</td>
                        <td>Est&aacute; Instalado Sistema</td>
                        <td>C&oacute;digo Dane Empresa</td>
                    </tr>
                    <tr>
                        <td><select name="codclasepersona_empresa" id="codclasepersona_empresa" 
                                    onfocus="tabla(flexiClasePersona, 'Clase Persona', 'codclasepersona_empresa' )" 
                                    onclick="tabla(flexiClasePersona, 'Clase Persona', 'codclasepersona_empresa' )"></select></td>
                        <td>
                            <div id="switch_empresasistema_empresa"></div>
                            <input type="hidden" name="empresasistema_empresa" id="empresasistema_empresa" />
                        </td>
                        <td><input name="empcodigodane_empresa" type="text" id="empcodigodane_empresa" value="" /></td>
                    </tr>

                </table>

                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Empresas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Empresas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
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