<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>


<%
    clases.VerificarUsuarioSistema v;
    v = new clases.VerificarUsuarioSistema(request, response);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

        <!--<link type="text/css" href="../css/columnal/columnal-0.85/code/css/columnal.css" rel="Stylesheet" />-->

        <!--  <script type="text/javascript" src="../js/jquery/jquery.js"></script>  -->
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js"></script>

        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css">
        <script type="text/javascript" src="../js/formularios/funciones.js"></script>
        <script type="text/javascript" src="../js/formularios/EntidadSalud.js"></script>

        <link rel="stylesheet" type="text/css" href="../js/flexigrid/css/flexigrid.css">
        <script type="text/javascript" src="../js/flexigrid/js/flexigrid.js"></script>


    </head>


    <body bgcolor="#FFFFFF">
        <div id="ajax" style="display: none"></div>
        <div id="mensaje" style="display: none"> </div>
        <input type="hidden" id="respuestaAjax" />
        <!-- Aqui saldra el flexigrid para la tabla -->
        <div id="tablaContenedor"></div>
        <input type="hidden" id="combo" />
        <input type="hidden" id="nombreFormulario" value="Entidades de salud" />
        <input type="hidden" id="servlet" value="EntidadSalud" />

        <div id="dialog" style="display: none" >

            <div class="encabezado"> </div>
            <div class="titulo">ENTIDADES DE SALUD</div>

            <br />
            <div>
                <form id="EntidadSalud" method="post" accept-charset="UTF-8">
                    <input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" id="codregimentabla" name="codregimentabla" />
                    <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton">
                        <input type="submit" value="Mostrar Entidades Registradas" onclick="return tabla(flexiEntidadSalud, 'Entidades de Salud', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('EntidadSalud', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('EntidadSalud', 'Actualizar', ''); return false" style="display:none"  />
                        <input type="submit" id="volver_registro1"  value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" style="display:none" />
                    </div>

                    <table>
                        <br /><br />


                        <tr>
                            <td>Empresa</td><td>R&eacute;gimen</td><td>C&oacute;digo Entidad Salud</td><td>Tipo Entidad Salud</td>
                        </tr>
                        <tr>
                            <td><select name="codempresa" id="codempresa" onclick="tabla(flexiEmpresas, 'Empresas registradas', 'codempresa' )" ></select></td>
                            <td><select name="codregimen" id="codregimen" onclick="tabla(flexiRegimen, 'Regimen', 'codregimen' )"></select></td>                                
                            <td>
                                <input name="codentidadsaluds" type="text" id="codentidadsaluds" value="${codentidadsaludf}"  maxlength="18" />    
                            </td> 
                            <td>
                                <select name="codtipoentidadsalud" id="codtipoentidadsalud" onclick="tabla(flexiEntidad, 'Entidad Salud', 'codtipoentidadsalud' )">

                                </select>                                

                            </td>                                


                        </tr>    



                        <tr>
                            <td>Nivel Complejidad</td>
                            <td>Clasificaci&oacute;n Entidad</td>
                            <td>Contacto</td>
                            <td>Cargo Contacto</td>

                        </tr>
                        <tr>
                            <td><select name="codnivelcomplejidad" id="codnivelcomplejidad" onclick="tabla(flexiComplejidad, 'Complejidades', 'codnivelcomplejidad')">

                                </select></td>
                            <td><select name="codclasifentidad" id="codclasifentidad" onclick="tabla(flexiClasificacionentidad, 'Clasificacion entidad', 'codclasifentidad')">

                                </select></td>
                            <td><input name="contacto" type="text" id="contacto" value="" maxlength="60"></td>
                            <td><input name="cargocontacto" type="text" id="cargocontacto" value=""  maxlength="30" /></td>


                        <tr>
                            <td>L&iacute;nea Gratuita</td>
                            <td>N&uacute;mero Funcionarios</td>
                            <td>C&oacute;digo Barras</td>
                            <td>Logo</td>
                        </tr>
                        <tr>
                            <td><input name="lineagratuita" type="text" id="lineagratuita" value=""  maxlength="20" /></td>
                            <td><input name="funcionarios" type="text" id="funcionarios" value="0"  /></td>
                            <td><input name="codigobarras" type="text" id="codigobarras" value=""  /></td>
                            <td>
                                <input name="logo" type="text" id="logo"  onclick="abrirCargaArchivo('logo')"  value="" readonly="readonly"/>
                                <!--<img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('logo')"/>-->
                                <a href="../descargarArchivo?nombreArchivo=" target="_blank" onclick=" this.href = reHref( this.href, 'logo' ) "><img src="../images/descargar_1.png" width="30" height="30" onclick=""/></a>

                            </td>

                        </tr>
                        <tr>
                            <td>C&oacute;digo Habilitaci&oacute;n</td>
                            <td>Nombre Habilitaci&oacute;n</td>
                            <td>Tipo Especializaci&oacute;n</td>
                            <td>Tipo Atenci&oacute;n</td>
                        </tr>
                        <tr>
                            <td><input name="codhabilitacion" type="text" id="codhabilitacion" value="" /></td>
                            <td><input name="nombrehabilitacion" type="text" id="nombrehabilitacion" value=""  /></td>
                            <td><select name="codtipoespecializacion" id="codtipoespecializacion" onclick="tabla(flexiTipoespecializacionsalud, 'Tipo especializacion salud', 'codtipoespecializacion')">

                                </select></td>
                            <td>
                                <select name="codtipoatencion" id="codtipoatencion" tabindex="16" onclick="tabla(flexiTipoatencion, 'Tipo atencion', 'codtipoatencion')">

                                </select>                                    
                            </td>
                        </tr>

                        <tr>
                            <td>Estado Entidad</td>
                            <td>N&uacute;mero Acto Inscripci&oacute;n</td>
                            <td>Fecha Acto Administrativo</td>
                            <td>Archivo Acto Administrativo</td>
                        </tr>
                        <tr>
                            <td> <select name="codestadoentidad" id="codestadoentidad"  onclick="tabla(flexiEstadoentidadsalud, 'Estado entidad salud', 'codestadoentidad')">

                                </select></td>
                            <td><input name="numactoinscripcion" type="text" id="numactoinscripcion" value=""  /></td>
                            <td><input name="fechaactoadmin" type="text" id="fechaactoadmin"  value=""  readonly="readonly"/></td>
                            <td>
                                <input name="archivoactoadmin" type="text" id="archivoactoadmin"   value="" readonly="readonly" onclick="abrirCargaArchivo('archivoactoadmin')"/>
                                <!--<img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('archivoactoadmin')"/>-->
                                <a href="../descargarArchivo?nombreArchivo=" target="_blank" onclick="this.href = reHref( this.href, 'archivoactoadmin' ) "><img src="../images/descargar_1.png" width="30" height="30" onclick=""/></a>
                            </td>
                        </tr>


                        <tr>
                            <td>Archivo Adicional Entidad 1</td><td>Archivo Adicional Entidad 2</td>
                        </tr>
                        <tr>
                            <td>
                                <input name="archivofi" type="text" id="archivofi"  value="" readonly="readonly" onclick="abrirCargaArchivo('archivofi')"/>
                                <!--<img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('archivofi')"/>-->
                                <a href="../descargarArchivo?nombreArchivo=" target="_blank" onclick="this.href = reHref( this.href, 'archivofi' ) "><img src="../images/descargar_1.png" width="30" height="30" onclick=""/></a>                                    
                            </td>
                            <td>
                                <input name="archivofi2" type="text" id="archivofi2"   value="" readonly="readonly" onclick="abrirCargaArchivo('archivofi2')"/>
                                <!--<img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('archivofi2')"/>-->
                                <a href="../descargarArchivo?nombreArchivo=" target="_blank" onclick="this.href = reHref( this.href, 'archivofi2' ) "><img src="../images/descargar_1.png" width="30" height="30" onclick=""/></a>                                                                       
                            </td>
                        </tr>

                        <tr>
                            <td colspan="4">Slogan</td>
                        </tr>
                        <tr>
                            <td colspan="4"><textarea name="slogan" id="slogan" cols="115" rows="7"></textarea></td>
                        </tr>



                    </table>    

                    <br />
                    <!-- Acciones estan 
                    1 - > registrar
                    2 -> actualizar -->

                    <div class="boton">
                        <input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('EntidadSalud', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" />


                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('EntidadSalud', 'Actualizar', ''); return false" style="display:none"  />
                        <!-- <input type="submit" id="eliminar2" value="Eliminar" onclick="accionFormulario('EntidadSalud', 'Eliminar', ''); return false" style="display:none" />-->
                        <input type="submit" id="volver_registro2"  value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" style="display:none" />                            
                    </div>

                </form>

                <div class="boton">


                </div>    
            </div>

        </div>
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


            </td>
        </tr>
        <tr>

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










