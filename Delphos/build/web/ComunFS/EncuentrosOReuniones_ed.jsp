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
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

        <!--  <script type="text/javascript" src="../js/jquery/jquery.js"></script>  -->
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js"></script>

        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css">
        <script type="text/javascript" src="../js/formularios/funciones.js"></script>
        <script type="text/javascript" src="../js/formularios/EncuentrosOReuniones.js"></script>

        <link rel="stylesheet" type="text/css" href="../js/flexigrid/css/flexigrid.css">
        <script type="text/javascript" src="../js/flexigrid/js/flexigrid.js"></script>


    </head>


    <body bgcolor="#FFFFFF">
        <div id="ajax" style="display: none"></div>
        <div id="mensaje" style="display: none"></div>
        <input type="hidden" id="respuestaAjax" />
        <!-- Aqui saldra el flexigrid para la tabla -->
        <div id="tablaContenedor"></div>
        <input type="hidden" id="combo" />
        <input type="hidden" id="nombreFormulario" value="Encuentros o reuniones" />
        <input type="hidden" id="servlet" value="EncuentrosOReuniones" />

        <div id="dialog" style="display: none" >
            <div class="encabezado"> </div>
            <div class="titulo">ENCUENTROS O REUNIONES</div>
            <br />
            <form id="EncuentrosOReuniones">
                <input type="hidden" id="codigo" name="codigo" />
                <input type="hidden" name="accion" id="accion" value="" />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1">Reuniones</a></li>
                        <li><a href="#tabs-2">Asistencia</a></li>
                        <li><a href="#tabs-3">Actividades</a></li>
                        <li><a href="#tabs-4">Asistentes</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="boton"><input type="submit" value="Mostrar reuniones registradas" onclick="tabla(flexiEncuentroreunion, 'Reuniones', '' )" /></div> 

                        <div id="tab_0_botones_0">PRUEBA</div>

                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo</td>
                                <td>Tipo de reuni&oacute;n</td>
                                <td>Departamento</td><td>Municipio</td>
                            </tr>
                            <tr>
                                <td><input name="encuencodigo_re" type="text" id="encuencodigo_re" value="" maxlength="6"/></td>
                                <td><select name="coditiporeun_re" id="coditiporeun_re"></select></td>
                                <td><select name="coddepartamento_re" id="coddepartamento"></select></td>
                                <td><select name="codmunicipio_re" id="codmunicipio_re"></select></td>
                            </tr>

                            <tr>
                                <td>Direcci&oacute;n</td>
                                <td>Lugar de referencia</td>
                                <td>Fecha</td><td>Numero de participantes</td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="text" name="encuendirecc" id="encuendirecc" value=""/>   
                                </td>
                                <td>
                                    <input type="text" name="enculugarefe" id="enculugarefe" value=""/> 
                                </td>
                                <td>
                                    <input name="encuenfecha" type="text" id="encuenfecha"  value="" maxlength="19" readonly="readonly"/>
                                </td>
                                <td>
                                    <input type="text" name="encunumepart" id="encunumepart" value=""/>
                                </td>
                            </tr>

                            <tr>
                                <td>Tipo de identificaci&oacute;n madre lider</td>
                                <td>Numero de identificaci&oacute;n madre lider</td>
                                <td>Fecha informe</td>
                                <td>Archivo</td>
                            </tr>
                            <tr>
                                <td><select name="codtipoidentidad" id="codtipoidentidad"></select></td>
                                <td><input  type="text" name="encidemadlid" id="encidemadlid"/></td>
                                <td>
                                    <input name="encufechinfo" type="text" id="encufechinfo"  value="" maxlength="19" readonly="readonly"/>
                                </td>
                                <td>
                                    <input name="encuarchdocu" type="text" id="encuarchdocu"  value="" readonly="readonly" />
                                </td>
                            </tr>

                            <tr>
                                <td>Tipo sistema</td>
                                <td>Prop&oacute;sito</td>
                                <td>Objetivo</td>
                                <td>Soluciones encontradas</td>
                            </tr>
                            <tr>
                                <td><select name="tisiscodigo" id="tisiscodigo"></select></td>
                                <td><textarea name="encuenpropos" id="encuenpropos" cols="20" rows="4"></textarea></td>
                                <td>
                                    <textarea name="encuenobjeti" id="encuenobjeti" cols="20" rows="4"></textarea>
                                </td>
                                <td>
                                    <textarea name="encusoluenco" id="encusoluenco" cols="20" rows="4" ></textarea>
                                </td>
                            </tr>

                            <tr>
                                <td>Observaciones</td>
                                <td>Archivofi</td>
                                <td colspan="2">Tema principal</td>
                            </tr>
                            <tr>
                                <td>
                                    <textarea name="encuenobserv" cols="20" rows="4" id="encuenobserv"></textarea>
                                </td>
                                <td>
                                    <input name="logo" type="text" id="archivofi"  onclick="abrirCargaArchivo('archivofi')"  value="" readonly="readonly"/>
                                    <img src="../images/subir.png" width="30" height="30" onclick="abrirCargaArchivo('archivofi')"/>
                                    <a href="../descargarArchivo?nombreArchivo=" target="_blank" onclick=" this.href = reHref( this.href, 'archivofi' ) "><img src="../images/descargar_1.png" width="30" height="30" onclick=""/></a>

                                </td>
                                <td colspan="2">
                                    <textarea name="encutemaprin" cols="45" rows="5" id="encutemaprin"></textarea>

                                </td>
                            </tr>


                        </table>

                        <div id="tab_1_botones_0">PRUEBA</div>
                    </div>
                    <div id="tabs-2">
                        <div class="boton"><input type="submit" value="Mostrar asistencias registradas" onclick="tabla(flexiEntidadSalud, 'Entidades de Salud', '' )" /></div> 
                        <br />
                        <div id="tab_2_botones_0"></div>
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo </td>
                                <td>C&oacute;digo unico familia</td>
                                <td>Tipo identificaci&oacute;n</td>
                                <td>N&uacute;mero identificaci&oacute;n</td>
                                <td>Pertenece al Programa</td>
                            </tr>
                            <tr>
                                <td><select name="encuencodigo_asis" id="encuencodigo_asis"></select></td>
                                <td><select name="codunifami_asis" id="codunifami_asis"></select></td>
                                <td><select name="codtipoidentidads_asis" id="codtipoidentidads_asis"></select></td>
                                <td><input name="asisteidentis_asis" type="text" id="asisteidentis_asis" value="" /></td>
                                <td>
                                   <input type="radio" name="asispertprog" value="S" id="asispertprog_1" checked="true"/>
                                   <input type="radio" name="asispertprog" value="S" id="asispertprog_0"/>
                                </td>
                                
                            </tr>
                        </table>
                        <div id="tab_3_botones_1"></div>
                        
                    </div>
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar actividades registradas" onclick="tabla(flexiEntidadSalud, 'Entidades de Salud', '' )" /></div>
                        <br />
                        <div id="tab_4_botones_2"></div>
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo </td>
                                <td>Tipo actividad</td>
                                <td>Funcionario</td>
                            </tr>
                            <tr>
                                <td><select name="encuencodigos" id="encuencodigos"></select></td>
                                <td><select name="codtipoactividads" id="codtipoactividads"></select></td>
                                <td><select name="numidentfunc" id="numidentfunc"></select></td>
                            </tr>
                        </table>
                        <div id="tab_5_botones_2"></div>
                        
                    </div>
                    <div id="tabs-4">
                       <div class="boton"><input type="submit" value="Mostrar asistentes registrados" onclick="tabla(flexiEntidadSalud, 'Entidades de Salud', '' )" /></div> 
                       <br />
                       <div id="tab_6_botones_3"></div>
                       <br />
                       <table>
                           <tr>
                               <td>C&oacute;digo</td>
                               <td>Tipo identificaci&oacute;n</td>
                                <td>N&uacute;mero identificaci&oacute;n</td>
                                <td>Nombres</td>
                                <td>Apellidos</td>
                           </tr>
                           <tr>
                               <td><select name="encuencodigo_asistentes" id="encuencodigo_asistentes"></select></td>
                               <td><select name="codtipoidentidad_asistentes" id="codtipoidentidadex_asistentes"></select></td>
                               <td><input name="externidenti" type="text" id="externidenti"/></td>
                               <td><input type="text" name="asiextnombre" id="asiextnombre"/></td>    
                               <td><input type="text" name="asiextapellido" id="asiextapellido"/></td>
                               
                           </tr
                           <tr>
                               <td>Tipo Asistente</td>
                               <td colspan="4">Observaci&oacute;n</td>
                           </tr>
                           <tr>
                               <td><select name="tipasicodigo" id="tipasicodigo"></select></td>
                               <td colspan="4"><textarea name="exterobserv" cols="95" rows="3" id="exterobserv"></textarea></td>
                           </tr>
                           
                       </table>
                       <div id="tab_7_botones_3"></div>
                    </div>
                </div>
            </form>
        </div>
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
    </body>

</html>