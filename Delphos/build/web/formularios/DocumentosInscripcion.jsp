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
        <script type="text/javascript" src="../js/formularios/DocumentosInscripcion.js">
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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Estado Titular" /> <input type="hidden" id="servlet" value="DocumentosInscripcion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">DOCUMENTO INCRIPCION</div>
            <br />
            <div>
                <form id="DocumentosInscripcion" method="post" accept-charset="utf-8" name="DocumentosInscripcion"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Documentos de Incripci�n " onclick="return tabla(flexiDocumentoInscripcion, 'Documento Inscripcion', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('DocumentosInscripcion', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('DocumentosInscripcion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                    <br />
                    <table>


                        <tr>
                            <td>C�digo �nico Familia</td>
                            <td>Tipo Documento Asociado</td>
                            <td>Tipo Identificacion</td>
                        </tr>
                        <tr>
                            <td> <select  id="codunifami_documentoinscripcion" name="codunifami_documentoinscripcion" onfocus="tabla(flexiVinculacion, 'Incripciones', 'codunifami_documentoinscripcion' )" onclick="tabla(flexiVinculacion, 'Incripciones', 'codunifami_documentoinscripcion' )"></select></td>
                            <td> <select  id="codtipodctoasociado_documentoinscripcion" name="codtipodctoasociado_documentoinscripcion" onfocus="tabla(flexiTipoDocumentoAsociado, 'Tipo Documento Asociado', 'codtipodctoasociado_documentoinscripcion' )" onclick="tabla(flexiTipoDocumentoAsociado, 'Tipo Documento Asociado', 'codtipodctoasociado_documentoinscripcion' )"></select></td>
                            <td> <select  id="codtipoidentidad_documentoinscripcion" name="codtipoidentidad_documentoinscripcion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_documentoinscripcion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_documentoinscripcion' )"></select></td>
                        </tr>
                        <tr>
                            <td>Numero Identificacion</td>
                            <td>Archivo Documento</td>
                            <td>Descripci�n</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="idenperdoc_documentoinscripcion" name="idenperdoc_documentoinscripcion"/></td>
                            <td><input name="archidocum_documentoinscripcion" type="text" id="archidocum_documentoinscripcion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archidocum_documentoinscripcion')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archidocum_documentoinscripcion' )" alt="Descargar" /></td>
                            <td> <input type="text" id="descripcion_documentoinscripcion" name="descripcion_documentoinscripcion"/></td>
                        </tr>

                    </table>
                    <!-- Acciones estan
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('DocumentosInscripcion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('DocumentosInscripcion', 'Actualizar', ''); return false" class="c2" />
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