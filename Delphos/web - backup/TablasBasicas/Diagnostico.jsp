<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>
<head>
<title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

        <script type="text/javascript" src="../js/jsCalendar/calendar.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/lang/calendar-es.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>

        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
        <script type="text/javascript" src="../js/pestanas/jquery-1.2.2.pack.js"></script>
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script><script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('coddiagnostico','tiempotratamiento','numerouvr','codigoalterno','codigorips','tarifasmdlv','codigobarras','descripcion','costo');
            var combos = new Array ('coddiag298','coddiagnostico3char','codnivelcomplejidad','codclasediagnostico','codambitodiagnostico',' codeventoepidem','codprotocodiagn','codmanualdiagnostico','codgrupodiagn');
            
            //validar
            var arrayNonulos               	= new Array ('coddiagnostico');
            var arrayNumerosEnteros        	= new Array ('tiempotratamiento','numerouvr');
            var arrayCombos               	= new Array ('coddiag298','coddiagnostico3char','codnivelcomplejidad','codclasediagnostico','codambitodiagnostico',' codeventoepidem','codprotocodiagn','codmanualdiagnostico','codgrupodiagn');
            var arrayCadenasANCod          	= new Array ('coddiagnostico','codigoalterno','codigorips','tarifasmdlv','codigobarras');
            var arrayCadenasA              	= null;            
            var arrayComentarios           	= new Array ('descripcion');
            var arrayNumerosDoubles        	= new Array ('costo');
                        
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
<!-- ImageReady Slices (panel.psd) -->
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
</tr>
<tr>
    <td width="234" height="529" valign="top" style="background: url('../images/back.png')">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
                    <jsp:include page="../menu.jsp" />
                </td>
            </tr>
        </table>
    </td>
    <td valign="top">
        
        <center>
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM diagnostico WHERE coddiagnostico='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="coddiagnostico" value="${fila.coddiagnostico}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="coddiag298" value="${fila.coddiag298}"/>
              <c:set var="coddiagnostico3char" value="${fila.coddiagnostico3char}"/>             
              <c:set var="codnivelcomplejidad" value="${fila.codnivelcomplejidad}"/>
              <c:set var="codclasediagnostico" value="${fila.codclasediagnostico}"/>
              <c:set var="codambitodiagnostico" value="${fila.codambitodiagnostico}"/>              
              <c:set var="codeventoepidem" value="${fila.codeventoepidem}"/>              
              <c:set var="codprotocodiagn" value="${fila.codprotocodiagn}"/>
              <c:set var="codmanualdiagnostico" value="${fila.codmanualdiagnostico}"/>
              <c:set var="codgrupodiagn" value="${fila.codgrupodiagn}"/>
              <c:set var="codigoalterno" value="${fila.codigoalterno}"/>
              <c:set var="codigorips" value="${fila.codigorips}"/>
              <c:set var="costo" value="${fila.costo}"/>             
              <c:set var="permitehombre" value="${fila.permitehombre}"/>
              <c:set var="permitemujer" value="${fila.permitemujer}"/>
              <c:set var="senotifica" value="${fila.senotifica}"/>
              <c:set var="diagnutricion" value="${fila.diagnutricion}"/>
              <c:set var="tiempotratamiento" value="${fila.tiempotratamiento}"/>
              <c:set var="tarifasmdlv" value="${fila.tarifasmdlv}"/>
              <c:set var="numerouvr" value="${fila.numerouvr}"/>
              <c:set var="codigobarras" value="${fila.codigobarras}"/>
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="Diagnostico.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Diagn&oacute;stico</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>C&oacute;digo Diagn&oacute;stico</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <input name="coddiagnostico" type="text" id="coddiagnostico" value="${coddiagnostico}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Alterno</strong></td>
                <td><label>
                  <input name="codigoalterno" type="text" id="codigoalterno" value="${codigoalterno}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="150"><span class="bgDescTablas"><strong>Diagn&oacute;stico 298</strong></span></td>
                <td width="160"><select name="coddiag298" id="coddiag298" style="width: 150px" tabindex="3">
                  <option id="coddiag298" value=""></option>
                  <sql:query var="r" sql="select coddiag298, descripcion from diagnostico298" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.coddiag298 == coddiag298}'>
                        <option value="${fila.coddiag298}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.coddiag298}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="12">&nbsp;</td>
                <td width="128" class="bgDescTablas"><strong>Diagn&oacute;stico 3 Caracteres</strong></td>
                <td width="167"><select name="coddiagnostico3char" id="coddiagnostico3char" style="width: 150px" tabindex="4">
                  <option id="coddiagnostico3char" value=""></option>
                  <sql:query var="r" sql="select coddiagnostico3char, descripcion from diagnostico3char" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.coddiagnostico3char == coddiagnostico3char}'>
                        <option value="${fila.coddiagnostico3char}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.coddiagnostico3char}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Nivel Complejidad</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codnivelcomplejidad" id="codnivelcomplejidad" style="width: 150px" tabindex="5">
                    <option id="codnivelcomplejidad" value=""></option>
                    <sql:query var="r" sql="select codnivelcomplejidad, descripcion from nivelcomplejidad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codnivelcomplejidad == codnivelcomplejidad}'>
                          <option value="${fila.codnivelcomplejidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codnivelcomplejidad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Clase Diagn&oacute;stico</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codclasediagnostico" id="codclasediagnostico" style="width: 150px" tabindex="6">
                    <option id="codclasediagnostico" value=""></option>
                    <sql:query var="r" sql="select codclasediagnostico, descripcion from clasediagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codclasediagnostico == codclasediagnostico}'>
                          <option value="${fila.codclasediagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codclasediagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                  </span></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Ambito Diagn&oacute;stico</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codambitodiagnostico" id="codambitodiagnostico" style="width: 150px" tabindex="7">
                    <option id="codambitodiagnostico" value=""></option>
                    <sql:query var="r" sql="select codambitodiagnostico, descripcion from ambitodiagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codambitodiagnostico == codambitodiagnostico}'>
                          <option value="${fila.codambitodiagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codambitodiagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Evento Epidemiologico</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codeventoepidem" id="codeventoepidem" style="width: 150px" tabindex="8">
                    <!--<option id="codeventoepidem" value=""></option>-->
                    <sql:query var="r" sql="select codeventoepidem, descripcion from eventoepidemiologico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codeventoepidem == codeventoepidem}'>
                          <option value="${fila.codeventoepidem}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codeventoepidem}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Protocolo Diagn&oacute;stico</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codprotocodiagn" id="codprotocodiagn" style="width: 150px" tabindex="9">
                    <option id="codprotocodiagn" value=""></option>
                    <sql:query var="r" sql="select codprotocodiagn, descripcion from protocolodiagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codprotocodiagn == codprotocodiagn}'>
                          <option value="${fila.codprotocodiagn}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codprotocodiagn}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Manual Diagn&oacute;stico</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                <select name="codmanualdiagnostico" id="codmanualdiagnostico" style="width: 150px" tabindex="10">
                  <option id="codmanualdiagnostico" value=""></option>
                  <sql:query var="r" sql="select codmanualdiagnostico, descripcion from manualdiagnostico" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codmanualdiagnostico == codmanualdiagnostico}'>
                        <option value="${fila.codmanualdiagnostico}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codmanualdiagnostico}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </span></span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Grupo Diagn&oacute;stico</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codgrupodiagn" id="codgrupodiagn" style="width: 150px" tabindex="11">
                    <option id="codgrupodiagn" value=""></option>
                    <sql:query var="r" sql="select codgrupodiagn, codsubgrupodiagn, descripcion from subgrupodiagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codgrupodiagn == codgrupodiagn && codsubgrupodiagn == codsubgrupodiagn}'>
                          <option value="${fila.codgrupodiagn} ${fila.codsubgrupodiagn}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codgrupodiagn} ${fila.codsubgrupodiagn}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo RIPS</strong></td>
                <td><label>
                  <input name="codigorips" type="text" id="codigorips" value="${codigorips}" size="20" maxlength="10" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="12">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Costo</strong></td>
                <td><label>
                  <input name="costo" type="text" id="costo" value="${costo}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="13">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Diagn&oacute;stico de Nutrici&oacute;n</strong></td>
                <td class="bgDescTablas"><label><c:choose>
                            <c:when test = '${diagnutricion == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="diagnutricion" value="S" id="diagnutricion_0" checked="true" tabindex="14"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="diagnutricion" value="N" id="diagnutricion_1" tabindex="14"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="diagnutricion" value="S" id="diagnutricion_0" tabindex="14"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="diagnutricion" value="N" id="diagnutricion_1" checked="true" tabindex="14"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Diagn&oacute;stico de Notificaci&oacute;n</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${senotifica == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="senotifica" value="S" id="senotifica_0" checked="true" tabindex="15"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="senotifica" value="N" id="senotifica_1" tabindex="15"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="senotifica" value="S" id="senotifica_0" tabindex="15"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="senotifica" value="N" id="senotifica_1" checked="true" tabindex="15"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Barras</strong></td>
                <td><label>
                  <input name="codigobarras" type="text" id="codigobarras" value="${codigobarras}" size="20" maxlength="75" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="16">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Permite Hombre</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${permitehombre == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitehombre" value="S" id="permitehombre_0" checked="true" tabindex="17"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitehombre" value="N" id="permitehombre_1" tabindex="17"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitehombre" value="S" id="permitehombre_0" tabindex="17"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitehombre" value="N" id="permitehombre_1" checked="true" tabindex="17"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Permite Mujer</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${permitemujer == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitemujer" value="S" id="permitemujer_0" checked="true" tabindex="18"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitemujer" value="N" id="permitemujer_1" tabindex="18"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitemujer" value="S" id="permitemujer_0" tabindex="18"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitemujer" value="N" id="permitemujer_1" checked="true" tabindex="18"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tiempo Tratamiento</strong></td>
                <td><label>
                  <input name="tiempotratamiento" type="text" id="tiempotratamiento" value="${tiempotratamiento}" size="20" maxlength="5" onKeyPress="javascript:return permite(event, 'nume')" tabindex="19">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tarifa en SMLV</strong></td>
                <td><label>
                  <input name="tarifasmdlv" type="text" id="tarifasmdlv" value="${tarifasmdlv}" size="20" maxlength="10" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="20">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Cantidad UVR </strong></td>
                <td colspan="4"><label>
                  <input name="numerouvr" type="text" id="numerouvr" value="${numerouvr}" size="20" maxlength="5" onKeyPress="javascript:return permite(event, 'nume')" tabindex="21">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Descripci&oacute;n</strong></p>
                  <p align="center">
                    <label>
                    <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onKeyPress="javascript:return permite(event, 'com')" tabindex="22">
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="26"> -->
		  <label>&nbsp;</label>
                  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="23"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="24"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="25"/>
               </div>
            </td>
           </tr>
          </table>
        </form>
        </center>
        
    </td>
</tr>
<tr>
    <td>
        <jsp:include page="../footer.jsp" />    </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    //funciones control
    function accion(x)
    {        
        if(validar(arrayNonulos, arrayNumerosEnteros, arrayCombos, arrayCadenasANCod, arrayCadenasA, arrayComentarios, arrayNumerosDoubles))
        {
            if(x == 1)
            {
                document.getElementById('valpk').value = 1;
            }
            else if(x == 2)
            {
                document.getElementById('valpk').value = 2;
            }
            else if(x == 3)
            {
                document.getElementById('valpk').value = 3;
            }
            validarPK();            
        }
    } 
    
    //-------VALIDACION PK
    function validarPK()
    {
        llaves = 'coddiagnostico='+document.getElementById('coddiagnostico').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('diagnostico',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=diagnostico&";
        url = url + "campos=coddiagnostico,descripcion,coddiag298,coddiagnostico3char,codnivelcomplejidad,costo,senotifica,diagnutricion&";
        url = url + "campoLlave=coddiagnostico";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>