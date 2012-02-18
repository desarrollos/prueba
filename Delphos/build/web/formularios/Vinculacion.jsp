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
        <script type="text/javascript" src="../js/formularios/Vinculacion.js">
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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Inscripcion" /> <input type="hidden" id="servlet" value="Vinculacion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Inscripci&oacute;n</div>
            <br />
            <div>
                <form id="Vinculacion" method="post" accept-charset="utf-8" name="Vinculacion"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Vinculaciones " onclick="return tabla(flexiVinculacion, 'Inscripciones Registradas', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Vinculacion', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Vinculacion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td><strong>C&oacute;digo Unico Familia </strong></td>
                            <td><strong>Empresa Aprobadora </strong></td>
                            <td><strong>Tipo Identificaci&oacute;n Jefe Hogar </strong></td>
                            <td><strong>Identificaci&oacute;n Jefe Hogar </strong></td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="codunifami_inscripcion" name="codunifami_inscripcion"/></td>
                            <td> <select name="codtipoidentidad_inscripcion" id="codtipoidentidad_inscripcion" onfocus="tabla(flexiEmpresas, 'Empresas Registradas', 'codtipoidentidad_inscripcion' )" onclick="tabla(flexiEmpresas, 'Empresas Registradas', 'codtipoidentidad_inscripcion' )"></select></td>
                            <td> <select name="tiidenjefhog_inscripcion" id="tiidenjefhog_inscripcion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'tiidenjefhog_inscripcion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'tiidenjefhog_inscripcion' )"></select></td>
                            <td> <input type="text" id="idenjefhog_inscripcion" name="idenjefhog_inscripcion"/></td>
                        </tr>
                        <tr>
                            <td><strong>Numero Declaraci&oacute;n </strong></td>
                            <td><strong>Fecha-Hora Diligenciamiento</strong> </td>
                            <td><strong>Fecha-Hora Inscripci&oacute;n</strong> </td>
                            <td><strong>Departamento</strong> </td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="numerdecla_inscripcion" name="numerdecla_inscripcion"/></td>
                            <td><input name="fechadilig_inscripcion" type="text" id="_fecha_fechadilig_inscripcion" value="" maxlength="19" readonly="readonly" /></td>
                            <td><input name="fechainscr_inscripcion" type="text" id="_fecha_fechainscr_inscripcion" value="" maxlength="19" readonly="readonly" /></td>
                            <td> <select name="coddepartamento_inscripcion" id="coddepartamento_inscripcion" onfocus="tabla(flexiDepartamento, 'Departamentos', 'coddepartamento_inscripcion' )" onclick="tabla(flexiDepartamento, 'Departamentos', 'coddepartamento_inscripcion' )"></select></td>
                        </tr>
                        <tr>
                            <td><strong>Municipio </strong></td>
                            <td><strong>Subgrupo Geogr&aacute;fico</strong> </td>
                            <td><strong>Barrio</strong> </td>
                            <td><strong>IPS Asignada</strong> </td>
                        </tr>
                        <tr>
                            <td> <select name="codmunicipio_inscripcion" id="codmunicipio_inscripcion" onfocus="tabla(flexiMunicipio, 'Municipios', 'codmunicipio_inscripcion' )" onclick="tabla(flexiMunicipio, 'Municipios', 'codmunicipio_inscripcion' )"></select></td>
                            <td> <select name="codsubgrupo_inscripcion" id="codsubgrupo_inscripcion" onfocus="tabla(flexiSubGrupoGeografico, 'Subgrupos Geográficos Registrados', 'codsubgrupo_inscripcion' )" onclick="tabla(flexiSubGrupoGeografico, 'Subgrupos Geográficos Registrados', 'codsubgrupo_inscripcion' )"></select></td>
                            <td> <select name="codbarrio_inscripcion" id="codbarrio_inscripcion" onfocus="tabla(flexiBarrio, 'Barrios Registrados', 'codbarrio_inscripcion' )" onclick="tabla(flexiBarrio, 'Barrios Registrados', 'codbarrio_inscripcion' )"></select></td>
                            <td> <select name="codregimenes_inscripcion" id="codregimenes_inscripcion" onfocus="tabla(flexiEntidadSalud, 'IPS Registradas', 'codregimenes_inscripcion' )" onclick="tabla(flexiEntidadSalud, 'IPS Registradas', 'codregimenes_inscripcion' )"></select></td>
                        </tr>
                        <tr>
                            <td><strong>N&uacute;mero Cuenta Bancaria </strong></td>
                            <td><strong>Banco</strong> </td>
                            <td><strong>Funcionario Aprueba</strong> </td>
                            <td><strong>N&uacute;mero Mesa</strong> </td>
                        </tr>
                        <tr>
                            <td><input type="text" id="numcuebanc_inscripcion" name="numcuebanc_inscripcion"/></td>
                            <td> <select name="codbanco_inscripcion" id="codbanco_inscripcion" onfocus="tabla(flexiBanco, 'Bancos Registrados', 'codbanco_inscripcion' )" onclick="tabla(flexiBanco, 'Bancos Registrados', 'codbanco_inscripcion' )"></select></td>
                            <td> <select name="codtipoidenfunapr_inscripcion" id="codtipoidenfunapr_inscripcion" onfocus="tabla(flexiFuncionario, 'Funcionarios Registrados', 'codtipoidenfunapr_inscripcion' )" onclick="tabla(flexiFuncionario, 'Funcionarios Registrados', 'codtipoidenfunapr_inscripcion' )"></select></td>
                            <td><input type="text" id="numeromesa_inscripcion" name="numeromesa_inscripcion"/></td>
                        </tr>
                        <tr>
                            <td><strong>Tipo Beneficiario </strong></td>
                            <td><strong>Ni&ntilde;os Menores a 7 A&ntilde;os  </strong> </td>
                            <td><strong>Ni&ntilde;os Entre 7 y 18 A&ntilde;os</strong> </td>
                            <td><strong>Reside Municipio</strong> </td>
                        </tr>
                        <tr>
                            <td> <select name="coditipben_inscripcion" id="coditipben_inscripcion" onfocus="tabla(flexiTipoBeneficiario, 'Tipos de Beneficiarios Registrados', 'coditipben_inscripcion' )" onclick="tabla(flexiTipoBeneficiario, 'Tipos de Beneficiarios Registrados', 'coditipben_inscripcion' )"></select></td>
                            <td><input type="text" id="meno7anyos_inscripcion" name="meno7anyos_inscripcion"/></td>
                            <td><input type="text" id="meno7a18anyos_inscripcion" name="meno7a18anyos_inscripcion"/></td>
                            <td><div id="switch_residmunic_inscripcion"></div> <input type="hidden" name="residmunic_inscripcion" id="residmunic_inscripcion" /></td>
                        </tr>
                        <tr>
                            <td><strong>Se Compromete con Obligaciones </strong></td>
                            <td><strong>Fecha Aprobaci&oacute;n</strong> </td>
                            <td><strong>Empresa Aprobadora</strong> </td>
                            <td><strong>Funcionario Diligente</strong> </td>
                        </tr>
                        <tr>
                            <td><div id="switch_comproblig_inscripcion"></div> <input type="hidden" name="comproblig_inscripcion" id="comproblig_inscripcion" /></td>
                            <td><input name="fechaaprobac_inscripcion" type="text" id="_fecha_fechaaprobac_inscripcion" value="" maxlength="19" readonly="readonly" /></td>
                            <td> <select name="codtipoidentidadapr_inscripcion" id="codtipoidentidadapr_inscripcion" onfocus="tabla(flexiEntidadSalud, 'IPS Registradas', 'codtipoidentidadapr_inscripcion' )" onclick="tabla(flexiEntidadSalud, 'IPS Registradas', 'codtipoidentidadapr_inscripcion' )"></select></td>
                            <td> <select name="codtipoidenfundil_inscripcion" id="codtipoidenfundil_inscripcion" onfocus="tabla(flexiFuncionario, 'Funcionarios Registrados', 'codtipoidenfundil_inscripcion' )" onclick="tabla(flexiFuncionario, 'Funcionarios Registrados', 'codtipoidenfundil_inscripcion' )"></select></td>
                        </tr>
                        <tr>
                            <td><strong>Documento Afiliaci&oacute;n</strong></td>
                            <td><strong>N&uacute;mero Afiliaci&oacute;n</strong> </td>
                            <td><strong>Estado Familia</strong> </td>
                            <td><strong>Comprobante Inscripci&oacute;n</strong> </td>
                        </tr>
                        <tr>
                            <td><input name="arcdocapro_inscripcion" type="text" id="arcdocapro_inscripcion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('arcdocapro_inscripcion')" />
                                <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('arcdocapro_inscripcion' )" alt="Descargar" /></td>
                            <td><input type="text" id="numeraprob_inscripcion" name="numeraprob_inscripcion"/></td>
                            <td> <select name="codiestfam_inscripcion" id="codiestfam_inscripcion" onfocus="tabla(flexiEstadoFamilia, 'Estados de Familia Registrados', 'codiestfam_inscripcion' )" onclick="tabla(flexiEstadoFamilia, 'Estados de Familia Registrados', 'codiestfam_inscripcion' )"></select></td>
                            <td><input name="archcomins_inscripcion" type="text" id="archcomins_inscripcion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archcomins_inscripcion')" />
                                <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archcomins_inscripcion' )" alt="Descargar" /></td>
                        </tr>
                        <tr>
                            <th colspan="4"><strong>Observaciones</strong></th>
                        </tr>
                        <tr>
                            <td  colspan="4"><textarea name="observacion_inscripcion" id="observacion_inscripcion" cols="110" rows="4"></textarea></td>
                        </tr>

                    </table>
                    <br />
                    <!-- Acciones estan
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Vinculacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Vinculacion', 'Actualizar', ''); return false" class="c2" />
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