<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>


<%
    clases.VerificarUsuarioSistema v;
    v = new clases.VerificarUsuarioSistema(request, response);
%>

<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        
    
        <script type="text/javascript" src="../js/jquery/jquery.js">
        
        
        </script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

        <!--  <script type="text/javascript" src="../js/jquery/jquery.js"></script>  -->
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js"></script>

        <style type="text/css">@import url('../carga_archivos/poblacion/css-poblacion.css');</style>

        <script type="text/javascript" src="../carga_archivos/poblacion/js-poblacion-reuzables.js"></script>
        <script type="text/javascript" src="../carga_archivos/poblacion/js-poblacion.js">
        </script>

        <link rel="stylesheet" type="text/css" href="../js/flexigrid/css/flexigrid.css">
        <script type="text/javascript" src="../js/flexigrid/js/flexigrid.js"></script>


        

    </head>
    <body bgcolor="#FFFFFF">
        <div id="dialogError" style="display:none" title="">
        </div>
        <div id="encabezadosContenedor">

        </div>

        <div id="formatoFecha" style="display:none" title="">
        </div>
        <div id="ajaxError">

        </div>
        <div id="encabezadoError" title="Error" style="display: none">
            Ocurrio un error al registrar el encabezado, intenta nuevamente
        </div>
        <input type="hidden" id="todoDelimitador" value="" />
        <input type="hidden" id="criterioSeleccionado" value="" />

        <input type="hidden" id="selectOption" />
        <input type="hidden" id="selectIndexAnterior" />
        <div id="seleccioneTipoIdCedula" style="display:none">
            Es obligatorio seleccionar <strong>"TIPO ID" </strong> y <strong> "CEDULA" </strong>
        </div>

        <form id="datosFormulario" name="datosFormulario" method="post">
            <input type="hidden" name="tiposFecha" id="tiposFecha" value="" />
            <input type="hidden" name="elFormato" id="elFormato" value="" />
            <input type="hidden" name="soloFechas" id="soloFechas" value="" />
            <input type="hidden" id="ripsSubidos" />
            <input type="hidden" id="ripActual" />
            <input type="hidden" id="avanzarObligatorio" value="si" />
            <input type="hidden" id="noReGuardarMismoEncabezado" value="si" name="noReGuardarMismoEncabezado" />
            <input type="hidden" id="noAvanzarConTab" value="no"/>
            <input type="hidden" id="numeroId" />
            <input type="hidden" id="prueba" />
            <input type="hidden" id="posCampos" name="posCampos" />

            <div id="advertenciaModificacionPoblacion" title="Advertencia" style="display:none">Est� acci�n modificara permanentemente la base de datos, est� completamente seguro que desea continuar ?</div>
            <div id="registrosAComparar" style="display:none" title="Registros seleccionados para ser comparados"></div>
            <div id="finAsistente" style="display:none" title="Fin del asistente">
                Fin del asistente, pulse en <strong>FINALIZAR</strong> para salir
            </div>
            <div id="ripsCargadosCorrectamente" style="display:none">
                Los Rips se cargaron correctamente a la base de datos
            </div>
            <div id="seleccioneRegimen" style="display:none" title="Error">
                Por favor seleccione un r&eacute;gimen
            </div>

            <div id="subirMasRips" style="display:none" title="Rips">
                Los rips seleccionados se cargaron correctamente <br />
                Des&eacute;a seleccionar mas rips ?
            </div>
            <div id="seleccioneDetalle" style="display:none" title="Seleccione detalle">
                Para continuar, es necesario que seleccione otro rip m&aacute;s
            </div>
            <div id="poblacionRipCargado" style="display:none" title="Carga completada">
                El archivo se cargo completamente, pulsa en aceptar para continuar con
                las novedades y las inconcistencias.

            </div>
            <div id="confirmarCargaArchivos" style="display:none">
                La informaci&oacute;n se cargara en la base de datos.
            </div>
            <div id="confirmarCargarPoblacion" style="display:none">
                La informaci&oacute;n se cargara en la base de datos, desea continuar ?
            </div>

            <div id="diferenteDeIgnorar"  style="display:none">
                Seleccione una opci&oacute;n diferente de <strong>IGNORAR</strong>
            </div>
            <div id="seleccionarMasDeUnNuevo"  style="display:none">
                Debe seleccionar almenos <strong>1 registro</strong>
            </div>
            <div id="errorColumnaRepetida" style="display:none">

            </div>
            <div id="seleccionArchivosASubir" style="display:none">
                Seleccione los rips a subir 
                <jsp:include page="../carga_archivos/rips/seleccionRips.jsp" />

            </div>

            <div id="seleccioneArchivo" style="display:none">
                Seleccione un archivo para subir
            </div>
            <div id="adjuntandoDocumento" style="display:none">
                El documento se adjunto correctamente.
            </div>
            <div id="noPermitido" title="Error" style="display:none">
                Esta acci&oacute;n no esta permitida
            </div>
            <div id="stopAjaxRegistrarEncabezado"></div>
            <div id="ajaxStart" title="Procesando petici&oacute;n" style="display:none;">
                <img src="../images/ajax-loader.gif" alt="Cargando..."/><br />
                El servidor esta procesando su informaci&oacute;n <br /> espere un momento porfavor.
            </div>
            <div id="encabezadoNoSeEncontro" style="display: none" title="Encabezado no encontrato">
                El encabezado no se encontr&oacute;, intente nuevamente
            </div>

            <div id="criterio_busqueda_resultado" style="display:none">

            </div>
            <div id="sin_registros" style="display:none">
                No hay registros para procesar
            </div>
            <!-- Se usa la misma capa para mostrar coincidencias, registros nuevos y cantidad novedades -->
            <div id="opcion_seleccionada" style="display: none">

            </div>
            <div id="si_selecciona_otro_criterio" style="display: none">
                Los datos modificados durante la selecci�n del criterio volveran a la normalidad
            </div>
            <div id="dialog_registro_coincidente" style="display: none">


            </div>




            <input type="hidden" id="error" value="0" />
            <input type="hidden" id="posicionTab" value="0" />
            <div id="verificarCampo" title="Error de validaci&oacute;n" style="display:none; text-align: justify">
                Porfavor verifique los campos marcados.
            </div>
            
            <div id="continuarConsultarEncabezado" style="display: none">
                Digite el ID del encabezado <input type="text" name="idEncabezadoBuscar" id="idEncabezadoBuscar" />
                <input type="submit" name="buscarEncabezado" id="buscarEncabezado"  value="Buscar" onclick="continuarConsultarEncabezado()" />
                <input type="submit" name="mostrarEncabezados" id="mostrarEncabezados" value="Mostrar encabezados registros" />
            </div>

            <div id="idEncabezadoParaReporte" style="display:none">

            </div>
            <div id="idEncabezado" title="Atenci&oacute;n" style="display:none; text-align: justify">
                <!--<div id="fondo">-->
                El encabezado registrado, ha generado la siguiente informaci&oacute;n,
                porfavor no la pierda. <br />
                <div id="info"></div>
                <!--</div>-->

            </div>


            <!-- ImageReady Slices (panel.psd) -->
            ${msj}

            <center>
                <table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="3">
                            <img src="../images/cabezote.png" width="906" height="150" alt="" />
                        </td>
                    </tr>
                    <%-- Datos sesion --%>
                    <tr valign="top">
                        <td colspan="3" width="906" height="16" style="background: url('../images/panel_02.gif')" align="right">
                            <span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a>
                        </td>
                    </tr>
                    <%-- Datos sesion --%>
                    <tr>
                        <td style="background: url('../images/back.png')" width="234" valign="top">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="left" valign="top">
                                        <jsp:include page="../menu.jsp" />  
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">


                            <form name="formulario" id="formulario" action="CargarArchivo.jsp" method="post" enctype="multipart/form-data">
                                <div class="menu">

                                    <div id="contenedor-encabezados">
                                        <div id="registrarEncabezado">
                                            <div id="tabs">
                                                <ul id="tabsAsistente">
                                                    <li><a href="#tabs-1" dir="encabezado">Encabezado</a></li>
                                                    <li><a href="#tabs-2">Poblacion/Rips</a></li>
                                                    <li><a href="#tabs-3">Seleccionar columnas</a></li>
                                                    <li><a href="#tabs-4">Novedades/Inconsistencias</a></li>
                                                </ul>
                                                <div id="tabs-1">

                                                    <jsp:include page="../carga_archivos/poblacion/registrar-encabezado.jsp" />

                                                </div>
                                                <div id="tabs-2">
                                                    <div id="contenido-tab-2">

                                                    </div>
                                                    <!-- Campos necesarios -->
                                                    <input type="hidden" name="codtipoestrucarch" id="codtipoestrucarch" value="${param.codtipoestrucarch}" />
                                                    <input type="hidden" name="idencabezado" id="idencabezado" value="${param.idencabezado}" />
                                                    <input type="hidden" name="accion" id="accion" value="${param.accion}" />
                                                    <!-- -->
                                                    <div id="mostrarCargaPoblacion" style="display:none">
                                                        <jsp:include page="../Salud/CargaArchivoPoblacion.jsp" />
                                                    </div>
                                                    <div id="mostrarCargaRips" style="display:none">
                                                        <div id="subidaRips" style="display:none">
                                                            <jsp:include page="../Salud/CargaArchivoRips.jsp" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tabs-3">
                                                    <div id="contenido-tab-3">

                                                    </div>
                                                </div>
                                                <div id="tabs-4">
                                                    <div id="tabs_incon_nove">
                                                        <ul>
                                                            <li><a href="#tabs_incon_nove-1">Inconcistencias</a></li>
                                                            <li><a href="#tabs_incon_nove-2" onclick="establecerPosCampos()">Novedades</a></li>
                                                        </ul>
                                                        <div id="tabs_incon_nove-1">

                                                        </div>
                                                        <div id="tabs_incon_nove-2">

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="consultarEncabezado">

                                        </div>
                                        <div id="inconclusoEncabezado">

                                        </div>


                                    </div>
                                    <%
                                        String opcion = request.getParameter("o");
                                        System.out.println(opcion);

                                        if (opcion.equals("r")) {
                                    %>
                                    <script> document.write('<input type="submit" name="registrarEncabezado" class="mostrarCapa" alt="#registrarEncabezado-registrar" title="Registrar encabezado" value="Registrar \n encabezados" />');</script>
                                    <%                                            }
                                        if (opcion.equals("c")) {
                                    %>
                                    <script> document.write('<input type="submit" name="consultarEncabezado" class="mostrarCapa" alt="#registrarEncabezado-ver" title="Consultar encabezados" value="Consultar \n encabezados" /><br />');</script>
                                    <%                                            }
                                        if (opcion.equals("t")) {
                                    %>
                                    <script>
                                        document.write('<input type="submit" name="registrarEncabezado" class="mostrarCapa" alt="#registrarEncabezado-registrar" title="Registrar encabezado" value="Registrar \n encabezados" />');
                                        document.write('<input type="submit" name="consultarEncabezado" class="mostrarCapa" alt="#registrarEncabezado-ver" title="Consultar encabezados" value="Consultar \n encabezados" /><br />');
                                        document.write('<input type="submit" name="inconclusoEncabezado" class="mostrarCapa" alt="#registrarEncabezado-continuar" title="Encabezados inconclusos" value="Encabezados \n inconclusos" />');
                                        
                                    </script>
                                    <%                                            }
                                    %>                                                                                 


                                </div>
                                <input type="hidden" id="tipoRip" name="tipoRip" value="" />
                            </form>



                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <img src="../images/panel_06.gif" width="906" height="1" alt="" />
                        </td>
                    </tr>
                    <tr>
                        <td height="42" colspan="3">
                            <img src="../images/panel_07.gif" width="906" height="23" alt="" />    </td>
                    </tr>
                </table>
            </center>
            <!-- End ImageReady Slices -->
        </form>
    </body>
</html>











