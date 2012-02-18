<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>


<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
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
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('anyos','numerosmdlv','valoractividad','valorhonmedico','valorhonanest','valordersala','valormasucu','valorperfusion','ayuda');
            var combos = new Array('codtipometodologias','codactividadsaluds','mesinicials','mesfinal','codgrupoquirurgico','codnivelcomplejidad','coduvr','codactividadsaludhonmed','codactividadsaludhonanes','codactividadsaluddersala','codactividadsaludmasucu','codactividadsaludperfu');
			
            var arrayNonulos               	= new Array('anyos');
            var arrayNumerosEnteros        	= new Array('anyos','numerosmdlv');
            var arrayCombos               	= new Array('codtipometodologias','codactividadsaluds','mesinicials','mesfinal','codgrupoquirurgico','codnivelcomplejidad','coduvr','codactividadsaludhonmed','codactividadsaludhonanes','codactividadsaluddersala','codactividadsaludmasucu','codactividadsaludperfu');			
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('ayuda');
            var arrayNumerosDoubles        	= new Array('valoractividad','valorhonmedico','valorhonanest','valordersala','valormasucu','valorperfusion');

	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[0]);">

<!-- ImageReady Slices (panel.psd) -->
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
</tr>
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <c:if test='${param.codtipometodologia != null && param.codactividadsalud != null && param.anyo != null && param.mesinicial != null && param.codtipometodologia != "" && param.codactividadsalud != "" && param.anyo != "" && param.mesinicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM manualliquidacion WHERE codtipometodologia=${param.codtipometodologia} AND codactividadsalud=${param.codactividadsalud} AND anyo=${param.anyo} AND mesinicial=${param.mesinicial}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipometodologiaf" value="${fila.codtipometodologia}"/>
              <c:set var="codactividadsaludf" value="${fila.codactividadsalud}"/>
              <c:set var="anyof" value="${fila.anyo}"/>
              <c:set var="mesinicialf" value="${fila.mesinicial}"/>             
              <c:set var="mesfinal" value="${fila.mesfinal}"/>
              <c:set var="codgrupoquirurgico" value="${fila.codgrupoquirurgico}"/>
              <c:set var="codnivelcomplejidad" value="${fila.codnivelcomplejidad}"/>              
              <c:set var="coduvr" value="${fila.coduvr}"/>              
              <c:set var="aplicauvr" value="${fila.aplicauvr}"/>
              <c:set var="numerosmdlv" value="${fila.numerosmdlv}"/>
              <c:set var="valoractividad" value="${fila.valoractividad}"/>
              <c:set var="ayuda" value="${fila.ayuda}"/>
              <c:set var="codactividadsaludhonmed" value="${fila.codactividadsaludhonmed}"/>
              <c:set var="valorhonmedico" value="${fila.valorhonmedico}"/>             
              <c:set var="codactividadsaludhonanes" value="${fila.codactividadsaludhonanes}"/>
              <c:set var="valorhonanest" value="${fila.valorhonanest}"/>
              <c:set var="codactividadsaluddersala" value="${fila.codactividadsaluddersala}"/>
              <c:set var="valordersala" value="${fila.valordersala}"/>
              <c:set var="codactividadsaludmasucu" value="${fila.codactividadsaludmasucu}"/>
              <c:set var="valormasucu" value="${fila.valormasucu}"/>
              <c:set var="codactividadsaludperfu" value="${fila.codactividadsaludperfu}"/>
              <c:set var="valorperfusion" value="${fila.valorperfusion}"/>
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="ManualLiquidacion.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Manual Liquidaci&oacute;n</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="171"><span class="bgDescTablas"><strong>Tipo Metodolog&iacute;a</strong></span></td>
                <td width="150">
                <select name="codtipometodologias" id="codtipometodologias" style="width: 150px" tabindex="1">
                  <option id="codtipometodologias" value=""></option>
                  <sql:query var="r" sql="select codtipometodologia, descripcion from tipometodologia" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipometodologia == codtipometodologiaf}'>
                        <option value="${fila.codtipometodologia}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipometodologia}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="11">&nbsp;</td>
                <td width="124" class="bgDescTablas"><strong>Actividad Salud</strong></td>
                <td width="161">
                <select name="codactividadsaluds" id="codactividadsaluds" style="width: 150px" tabindex="2">
                  <option id="codactividadsaluds" value=""></option>
                  <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codactividadsalud == codactividadsaludf}'>
                        <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
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
                <td><span class="bgDescTablas"><strong>Mes Inicial</strong></span></td>
                <td><label>
                  <select name="mesinicials" id="mesinicials" tabindex="3">
                    <option id="mesinicials" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesinicialf}">
                                            <option value="0${mesinicialf}" selected>0${mesinicialf}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesinicialf}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                  </select>
                </label></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Mes Final</strong></td>
                <td><select name="mesfinal" id="mesfinal" tabindex="4">
                  <option id="mesfinal" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesfinal}">
                                            <option value="0${mesfinal}" selected>0${mesfinal}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesfinal}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                </select></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>A&ntilde;o</strong></td>
                <td><label>
                  <input name="anyos" type="text" id="anyos" value="${anyof}" size="20" maxlength="4" onKeyPress="javascript:return permite(event, 'nume')" tabindex="5">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Grupo Quirurgico</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                <select name="codgrupoquirurgico" id="codgrupoquirurgico" style="width: 150px" tabindex="6">
                  <option id="codgrupoquirurgico" value=""></option>
                  <sql:query var="r" sql="select codgrupoquirurgico, descripcion from grupoquirurgico" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codgrupoquirurgico == codgrupoquirurgico}'>
                        <option value="${fila.codgrupoquirurgico}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codgrupoquirurgico}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>Nivel Complejidad</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codnivelcomplejidad" id="codnivelcomplejidad" style="width: 150px" tabindex="7">
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
                <td><strong class="bgDescTablas">Uvr</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="coduvr" id="coduvr" style="width: 150px" tabindex="8">
                    <option id="coduvr" value=""></option>
                    <sql:query var="r" sql="select coduvr, descripcion from uvr" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coduvr == coduvr}'>
                          <option value="${fila.coduvr}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coduvr}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Aplica Uvr</strong></td>
                <td class="bgDescTablas"> <label><c:choose>
                            <c:when test = '${aplicauvr == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicauvr" value="S" id="aplicauvr_0" checked="true" tabindex="9"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicauvr" value="N" id="aplicauvr_1" tabindex="9"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicauvr" value="S" id="aplicauvr_0" tabindex="9"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicauvr" value="N" id="aplicauvr_1" checked="true" tabindex="9"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Numero de SMDLV</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="numerosmdlv" type="text" id="numerosmdlv" value="${numerosmdlv}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'nume')" tabindex="10">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Valor Actividad</strong></td>
                <td colspan="4"><input name="valoractividad" type="text" id="valoractividad" value="${valoractividad}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="11"></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Actividad Salud Honorarios Medicos</strong></td>
                <td><select name="codactividadsaludhonmed" id="codactividadsaludhonmed" style="width: 150px" tabindex="12">
                  <option id="codactividadsaludhonmed" value=""></option>
                  <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codactividadsalud == codactividadsaludhonmed}'>
                        <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Valor Honorarios Medicos</strong></td>
                <td><label>
                  <input name="valorhonmedico" type="text" id="valorhonmedico" value="${valorhonmedico}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="13">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Actividad Salud Honorarios Anestesiologo</strong></td>
                <td><select name="codactividadsaludhonanes" id="codactividadsaludhonanes" style="width: 150px" tabindex="14">
                  <option id="codactividadsaludhonanes" value=""></option>
                  <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codactividadsalud == codactividadsaludhonanes}'>
                        <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Valor Honorarios Anestesiologo</strong></td>
                <td><label>
                  <input name="valorhonanest" type="text" id="valorhonanest" value="${valorhonanest}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="15">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Actividad Salud Derechos Sala</strong></td>
                <td><select name="codactividadsaluddersala" id="codactividadsaluddersala" style="width: 150px" tabindex="16">
                  <option id="codactividadsaluddersala" value=""></option>
                  <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codactividadsalud == codactividadsaluddersala}'>
                        <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Valor Derechos Sala</strong></td>
                <td><label>
                  <input name="valordersala" type="text" id="valordersala" value="${valordersala}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="17">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Actividad Salud Materiales</strong></td>
                <td><select name="codactividadsaludmasucu" id="codactividadsaludmasucu" style="width: 150px" tabindex="18">
                  <option id="codactividadsaludmasucu" value=""></option>
                  <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codactividadsalud == codactividadsaludmasucu}'>
                        <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Valor Materiales</strong></td>
                <td><label>
                  <input name="valormasucu" type="text" id="valormasucu" value="${valormasucu}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="19">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Actividad Salud Perfusi&oacute;n</strong></td>
                <td><label>
                  <select name="codactividadsaludperfu" id="codactividadsaludperfu" style="width: 150px" tabindex="20">
                    <option id="codactividadsaludperfu" value=""></option>
                    <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codactividadsalud == codactividadsaludperfu}'>
                          <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Valor Perfusi&oacute;n</strong></td>
                <td><label>
                <input name="valorperfusion" type="text" id="valorperfusion" value="${valorperfusion}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="21">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Ayuda</strong></p>
                <p align="center"><strong>
                  <label>
                  <input name="ayuda" type="text" id="ayuda" value="${ayuda}" size="75" maxlength="80" onKeyPress="javascript:return permite(event, 'com')" tabindex="22">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipometodologia" id="codtipometodologia" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="anyo" id="anyo" value="" >
                  <input type="hidden" name="mesinicial" id="mesinicial" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="26">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="23"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="24"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="25"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
          </table>
        </form>
        </center>
        
    </td>
</tr>

<tr>
    <td>
        <jsp:include page="../footer.jsp" />
	</td>
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
        llaves = 'codtipometodologia='+document.getElementById('codtipometodologias').value+',';
        llaves+= 'codactividadsalud='+document.getElementById('codactividadsaluds').value+',';
        llaves+= 'anyo='+document.getElementById('anyos').value+',';
        llaves+= 'mesinicial='+document.getElementById('mesinicials').value;
        validarLlave('manualliquidacion',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=manualliquidacion&";
        url = url + "campos=codtipometodologia,codactividadsalud,anyo,mesinicial,mesfinal,aplicauvr,numerosmdlv,valoractividad&";
        url = url + "campoLlave=codtipometodologia,codactividadsalud,anyo,mesinicial";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>