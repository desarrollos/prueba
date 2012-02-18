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
		
		function configurar()
            {
		Calendar.setup({inputField : "fechadilig",ifFormat : "%d/%m/%Y %H:%M:%S",button : "botonFechadilig", showsTime:true, timeFormat:"24",daFormat : "%d/%m/%Y %H:%M:%S"});
                Calendar.setup({inputField : "fechainscr",ifFormat : "%d/%m/%Y %H:%M:%S",button : "botonFechainscr", showsTime:true, timeFormat:"24",daFormat : "%d/%m/%Y %H:%M:%S"});	
		Calendar.setup({inputField : "fechaaprobac",ifFormat : "%d/%m/%Y %H:%M:%S",button : "botonFechaaprobac", showsTime:true, timeFormat:"24",daFormat : "%d/%m/%Y %H:%M:%S"});	
	    }
            
            //totalidad de elementos en el form
            var cajas = new Array('codunifami','idenjefhog','numerdecla','fechadilig','fechainscr','numcuebanc','numeromesa','meno7anyos','meno7a18anyos','fechaaprobac','arcdocapro','numeraprob','archcomins','observacion');
            var combos = new Array('codempresas','tiidenjefhog','coddepartamentore','codmunicipiore','codsubgrupo','barriores','codentidadsaluds','codbanco','numidentfuncs','coditipben','codempresaaprs','numidentfuncdils','codiestfam');
			
            var arrayNonulos               	= new Array('codunifami','fechadilig','fechainscr','fechaaprobac');
            var arrayNumerosEnteros        	= new Array('meno7anyos','meno7a18anyos');
            var arrayCombos               	= new Array('codempresas','tiidenjefhog','coddepartamentore','codmunicipiore','codsubgrupo','barriores','codentidadsaluds','codbanco','numidentfuncs','coditipben','codempresaaprs','numidentfuncdils','codiestfam');
            var arrayCadenasANCod          	= new Array('codunifami','idenjefhog','numerdecla','numcuebanc','numeromesa','numeraprob');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('arcdocapro','archcomins','observacion');
            var arrayNumerosDoubles        	= null;
                        
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
            <sql:query var="r" sql="SELECT * FROM inscripcion WHERE codunifami='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifami" value="${fila.codunifami}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="codempresas" value="${fila.codempresa}"/>
              <c:set var="tiidenjefhog" value="${fila.tiidenjefhog}"/>             
              <c:set var="idenjefhog" value="${fila.idenjefhog}"/>
              <c:set var="numerdecla" value="${fila.numerdecla}"/>
              <fmt:formatDate value="${fila.fechadilig}" pattern="dd/MM/yyyy HH:mm:ss" var="fechadilig"/>
              <fmt:formatDate value="${fila.fechainscr}" pattern="dd/MM/yyyy HH:mm:ss" var="fechainscr"/>
              <c:set var="coddepartamentore" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipiore" value="${fila.codmunicipio}"/>
              <c:set var="codsubgrupo" value="${fila.codsubgrupo}"/>
              <c:set var="barriores" value="${fila.codbarrio}"/>
              <c:set var="codregimenes" value="${fila.codregimenes}"/>
              <c:set var="codentidadsalud" value="${fila.codentidadsalud}"/>
              <c:set var="numcuebanc" value="${fila.numcuebanc}"/>
              <c:set var="codbanco" value="${fila.codbanco}"/>             
              <c:set var="codtipoidenfunapr" value="${fila.codtipoidenfunapr}"/>
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              <c:set var="numeromesa" value="${fila.numeromesa}"/>
              <c:set var="coditipben" value="${fila.coditipben}"/>
              <c:set var="meno7anyos" value="${fila.meno7anyos}"/>
              <c:set var="meno7a18anyos" value="${fila.meno7a18anyos}"/>
              <c:set var="residmunic" value="${fila.residmunic}"/>
              <c:set var="comproblig" value="${fila.comproblig}"/>
              <fmt:formatDate value="${fila.fechaaprobac}" pattern="dd/MM/yyyy HH:mm:ss" var="fechaaprobac"/>
              <c:set var="codtipoidenfundil" value="${fila.codtipoidenfundil}"/>
              <c:set var="numidentfuncdil" value="${fila.numidentfuncdil}"/>
              <c:set var="codtipoidentidadapr" value="${fila.codtipoidentidadapr}"/>
              <c:set var="codempresaapr" value="${fila.codempresaapr}"/>
              <c:set var="arcdocapro" value="${fila.arcdocapro}"/>
              <c:set var="numeraprob" value="${fila.numeraprob}"/>
              <c:set var="codiestfam" value="${fila.codiestfam}"/>
              <c:set var="archcomins" value="${fila.archcomins}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(inscripcion.archivofi, '${ruta}${arcdocapro}') from inscripcion where codunifami='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta1 = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta1 = ruta1.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta1);
              %>
              <sql:query var="r" sql="select lo_export(inscripcion.archivofi2, '${ruta1}${archcomins}') from inscripcion where codunifami='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
            
            <form name="formulario" id="formulario" method="post" action="Vinculacion1.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Inscripci&oacute;n</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td class="bgDescTablas"><strong>C&oacute;digo Unico Familia</strong></td>
                <td><span class="sinBgDescTablas">
                  <input name="codunifami" type="text" id="codunifami" value="${codunifami}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Empresa Aprobadora</strong></td>
                <td><label>
                <select name="codempresas" id="codempresas" style="width: 150px">
                  <option id="codempresas" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codempresa == codempresas}'>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="150"><span class="bgDescTablas"><strong class="bgDescTablas">Tipo Identificaci&oacute;n Jefe Hogar</strong></span></td>
                <td width="160"><select name="tiidenjefhog" id="tiidenjefhog" style="width: 150px">
                  <option id="tiidenjefhog" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipoidentidad == tiidenjefhog}'>
                        <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="12">&nbsp;</td>
                <td width="128" class="bgDescTablas"><strong>Identificaci&oacute;n Jefe Hogar</strong></td>
                <td width="167"><input name="idenjefhog" type="text" id="idenjefhog" value="${idenjefhog}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')"></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong class="bgDescTablas">No. Declaraci&oacute;n</strong></span></td>
                <td><input name="numerdecla" type="text" id="numerdecla" value="${numerdecla}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'num_car_cod')"></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong class="bgDescTablas">Fecha y Hora Diligenciamiento</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <input name="fechadilig" type="text" id="fechadilig"  value="${fechadilig}" size="16" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button" type="button" id="botonFechadilig" value="..." />
                  </span></span></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong class="bgDescTablas">Fecha y Hora Inscripci&oacute;n</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="fechainscr" type="text" id="fechainscr"  value="${fechainscr}" size="16" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="botonFechainscr" type="button" id="botonFechainscr" value="..." />
                  </span></span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Departamento</strong></td>
                <td class="bgDescTablas">
                  <select name="coddepartamentore" id="coddepartamentore" onChange="cargarMunicipios2();" style="width: 150px">
                    <option value=""></option>
                    <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddepartamento == coddepartamentore}'>
                          <option value="${fila.coddepartamento}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddepartamento}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Municipio</strong></td>
                <td><span id="spanMunicipio2"><c:choose>
                  <c:when test="${codmunicipiore != null}">
                    <select name="codmunicipiore" id="codmunicipiore" style="width: 150px" onChange="cargarSubgrupos();">
                      <option value=""></option>
                      <sql:query var="r" sql="select codmunicipio, nombre from municipio where coddepartamento=${coddepartamentore} order by nombre" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codmunicipio == codmunicipiore}'>
                            <option value="${fila.codmunicipio}" selected="selected">${fila.nombre}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codmunicipio}">${fila.nombre}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select>
                  </c:when>
                  <c:otherwise>
                    <select name="select" disabled="disabled">
                      <option value=""></option>
                    </select>
                  </c:otherwise>
                </c:choose></span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                
                <td class="bgDescTablas"><strong>SubGrupo Geografico</strong></td>
                <td><span id="spanSubgrupo"><c:choose>
                  <c:when test="${codsubgrupo != null}">
                    <select name="codsubgrupo" id="codsubgrupo" style="width:150px" onChange="cargarBarrios();">
                      <option value=""></option>
                      <sql:query var="r" sql="select codsubgrupo, nombre from subgrupogeografico where coddepartamento=${coddepartamentore} and codmunicipio=${codmunicipiore} order by nombre" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codsubgrupo == codsubgrupo}'>
                            <option value="${fila.codsubgrupo}" selected="selected">${fila.nombre}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codsubgrupo}">${fila.nombre}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select>
                  </c:when>
                  <c:otherwise>
                    <select name="select2" disabled="disabled">
                      <option value=""></option>
                    </select>
                  </c:otherwise>
                </c:choose></span></td>

                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Barrio</strong></td>
                <td><span id="spanBarrio"><label>
                <c:choose>
                  <c:when test="${barriores != null}">
                    <select name="barriores" id="barriores" style="width: 150px">
                      <option value=""></option>
                      <sql:query var="r" sql="select codbarrio, nombre from barrio where coddepartamento=${coddepartamentore} and codmunicipio=${codmunicipiore} and codsubgrupo=${codsubgrupo} order by nombre" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codbarrio == barriores}'>
                            <option value="${fila.codbarrio}" selected="selected">${fila.nombre}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codbarrio}">${fila.nombre}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select>
                  </c:when>
                  <c:otherwise>
                    <select name="select3" disabled="disabled">
                      <option value=""></option>
                    </select>
                  </c:otherwise>
                </c:choose>
</label></span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong class="bgDescTablas">IPS Asignada</strong></td>
                <td colspan="4"><select name="codentidadsaluds" id="codentidadsaluds" style="width: 150px">
                  <option id="codentidadsaluds" value=""></option>
                  <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codregimenes == codregimenes && fila.codentidadsalud == codentidadsalud}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>No. Cuenta Bancaria</strong></td>
                <td class="bgDescTablas"><input name="numcuebanc" type="text" id="numcuebanc" value="${numcuebanc}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')"></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Banco</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codbanco" id="codbanco" style="width: 150px">
                    <option id="codbanco" value=""></option>
                    <sql:query var="r" sql="select codbanco, nombre from banco a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codbanco == codbanco}'>
                          <option value="${fila.codbanco}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codbanco}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong class="bgDescTablas">Funcionario Aprueba</strong></td>
                <td class="bgDescTablas"><select name="numidentfuncs" id="numidentfuncs" style="width: 150px">
                  <option id="numidentfuncs" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipoidentidad == codtipoidenfunapr && fila.numidentfunc == numidentfunc}'>
                        <option value="${fila.codtipoidentidad} ${fila.numidentfunc}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.numidentfunc}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong class="bgDescTablas">No. Mesa</strong></td>
                <td class="bgDescTablas"><input name="numeromesa" type="text" id="numeromesa" value="${numeromesa}" size="20" maxlength="10" onKeyPress="javascript:return permite(event, 'num_car_cod')"></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Tipo Beneficiario</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="coditipben" id="coditipben" style="width: 150px">
                    <option id="coditipben" value=""></option>
                    <sql:query var="r" sql="select coditipben, desctipben from tipobeneficiario" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coditipben == coditipben}'>
                          <option value="${fila.coditipben}" selected="selected">${fila.desctipben}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coditipben}">${fila.desctipben}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>No. Ni&ntilde;os Menores de 7 a&ntilde;os</strong></td>
                <td class="bgDescTablas"><input name="meno7anyos" type="text" id="meno7anyos" value="${meno7anyos}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'nume')"></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>No. Ni&ntilde;os entre 7 y 18 a&ntilde;os</strong></td>
                <td><input name="meno7a18anyos" type="text" id="meno7a18anyos" value="${meno7a18anyos}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'nume')"></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Reside Municipio</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${residmunic == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="residmunic" value="S" id="residmunic_0" checked="true" tabindex="17"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="residmunic" value="N" id="residmunic_1" tabindex="17"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="residmunic" value="S" id="residmunic_0" tabindex="17"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="residmunic" value="N" id="residmunic_1" checked="true" tabindex="17"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Se compromete con obligaciones</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${comproblig == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="comproblig" value="S" id="comproblig_0" checked="true" tabindex="18"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="comproblig" value="N" id="comproblig_1" tabindex="18"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="comproblig" value="S" id="comproblig_0" tabindex="18"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="comproblig" value="N" id="comproblig_1" checked="true" tabindex="18"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 8%"><strong>Fecha Aprobaci&oacute;n</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="fechaaprobac" type="text" id="fechaaprobac"  value="${fechaaprobac}" size="16" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="botonFechaaprobac" type="button" id="botonFechaaprobac" value="..." />
                  </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Empresa Aprobadora</strong></td>
                <td><span class="bgDescTablas">
                  <select name="codempresaaprs" id="codempresaaprs" style="width: 150px">
                    <option id="codempresaaprs" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codempresa == codempresaapr}'>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong class="bgDescTablas">Funcionario Diligencia</strong></td>
                <td><select name="numidentfuncdils" id="numidentfuncdils" style="width: 150px">
                  <option id="numidentfuncdils" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipoidentidad == codtipoidenfundil && fila.numidentfunc == numidentfuncdil}'>
                        <option value="${fila.codtipoidentidad} ${fila.numidentfunc}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.numidentfunc}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Documento Afiliaci&oacute;n</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="arcdocapro" type="text" id="arcdocapro" size="15"  value="${arcdocapro}" readonly/>
                  <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                  <c:if test='${arcdocapro != null}'> <br>
                    <a href="../temp/${arcdocapro}" target="_blank">Descargar ${arcdocapro}</a></c:if>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">No. Aprobaci&oacute;n</strong></td>
                <td><input name="numeraprob" type="text" id="numeraprob" value="${numeraprob}" size="20" maxlength="45" onKeyPress="javascript:return permite(event, 'num_car_cod')"></td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Estado Familia</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codiestfam" id="codiestfam" style="width: 150px">
                    <option id="codiestfam" value=""></option>
                    <sql:query var="r" sql="select codiestfam, descestfam from estadofamilia" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codiestfam == codiestfam}'>
                          <option value="${fila.codiestfam}" selected="selected">${fila.descestfam}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codiestfam}">${fila.descestfam}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Comprobante Inscripci&oacute;n</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="archcomins" type="text" id="archcomins" size="15"  value="${archcomins}" readonly/>
                  <a href="#" onClick="abrirCargaArchivo1();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                  <c:if test='${archcomins != null}'> <br>
                    <a href="../temp/${archcomins}" target="_blank">Descargar ${archcomins}</a> </c:if>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Observaciones</strong></p>
                  <p align="center">
                    <label>
                    <textarea name="observacion" cols="75" rows="3" id="observacion" onKeyPress="javascript:return permite(event, 'com')">${observacion}</textarea>
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
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="23"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="24"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="25"/> -->
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
        <jsp:include page="../footer.jsp" />   </td>
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
        llaves = 'codunifami='+document.getElementById('codunifami').value;
        validarLlave('inscripcion',llaves);
    }
    
    configurar();
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=arcdocapro";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
    function abrirCargaArchivo1()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archcomins";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=inscripcion&";
        url = url + "campos=codunifami,codempresa,fechadilig,fechainscr,numcuebanc,numeromesa,coditipben,residmunic&";
        url = url + "campoLlave=codunifami";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }
	
var req2;
    function cargarMunicipios2()
    {
       var departamento = document.getElementById("coddepartamentore");
       var url = "../ServletSeleccionarMunicipios?codDepartamento=" + encodeURIComponent(departamento.value);
       if (typeof XMLHttpRequest != "undefined")
           req2 = new XMLHttpRequest();
       else if (window.ActiveXObject)
           req2 = new ActiveXObject("Microsoft.XMLHTTP");
       req2.open("GET", url, true);
       req2.onreadystatechange = callbackSeleccionarMunicipios2;
       req2.send(null);
    }
    function callbackSeleccionarMunicipios2()
    {
        if (req2.readyState == 4)
            if (req2.status == 200)
                obtenerListadoMunicipios2();
    }
    function obtenerListadoMunicipios2()
    {
        var mdiv = document.getElementById("spanMunicipio2");
        var select, xmlMunicipios, i, cantMunicipios, municipio, codMunicipio;
        xmlMunicipios = req2.responseXML.getElementsByTagName("municipios")[0];
        cantMunicipios = xmlMunicipios.getElementsByTagName("municipio").length;
        select = "<select name=\"codmunicipiore\" id=\"codmunicipiore\" style=\"width:150px\" onChange=\"cargarSubgrupos();\">";
        select = select + "<option value=\"\">Seleccione el Municipio</option>";
        for(i=0; i<cantMunicipios; i++ )
        {
            codMunicipio = xmlMunicipios.getElementsByTagName("codMunicipio")[i];
            nombre = xmlMunicipios.getElementsByTagName("nombre")[i];
            select = select+"<option value=\""+codMunicipio.childNodes[0].nodeValue+"\">"+nombre.childNodes[0].nodeValue+"</option>";
        }
        select = select+"</select>";
        mdiv.innerHTML = select;
    }
    
    //-------SUBGRUPOS
    function cargarSubgrupos()
    {
       var municipio = document.getElementById("codmunicipiore");
       var departamento = document.getElementById("coddepartamentore");
       var url = "../ServletSeleccionarBarrios?codMunicipio=" + encodeURIComponent(municipio.value)+"&codDepartamento=" + encodeURIComponent(departamento.value)+"&tabla=subgrupogeografico";
       if (typeof XMLHttpRequest != "undefined") 
           req = new XMLHttpRequest();
       else if (window.ActiveXObject) 
           req = new ActiveXObject("Microsoft.XMLHTTP");
       req.open("GET", url, true);
       req.onreadystatechange = callbackSeleccionarSubgrupos;
       req.send(null);
    }
    
    function callbackSeleccionarSubgrupos()
    {
        if (req.readyState == 4) 
            if (req.status == 200) 
                obtenerListadoSubgrupos();
    }
    
    function obtenerListadoSubgrupos()
    { 
        var mdiv = document.getElementById("spanSubgrupo");
        var select, xmlSubgrupos, i, cantSubgrupos, subgrupo, codSubgrupo;

        xmlSubgrupos = req.responseXML.getElementsByTagName("subgrupos")[0];
        cantSubgrupos = xmlSubgrupos.getElementsByTagName("subgrupo").length;

        select = "<select name=\"codsubgrupo\" id=\"codsubgrupo\" style=\"width:150px\" onchange=\"cargarBarrios();\">";
        select = select + "<option value=\"\">Seleccione el Subgrupo</option>";
        for(i=0; i<cantSubgrupos; i++ )
        {
            codSubgrupo = xmlSubgrupos.getElementsByTagName("codsubgrupo")[i];
            subgrupo = xmlSubgrupos.getElementsByTagName("nombre")[i];

            select = select+"<option value=\""+codSubgrupo.childNodes[0].nodeValue+"\">"+subgrupo.childNodes[0].nodeValue+"</option>";
        }
        select = select+"</select>";
        mdiv.innerHTML = '&nbsp;';
        mdiv.innerHTML = select;
    }
    
    //-----------------BARRIOS
    function cargarBarrios()
    {
       var subgrupo = document.getElementById("codsubgrupo");
       var municipio = document.getElementById("codmunicipiore");
       var departamento = document.getElementById("coddepartamentore");
       var url = "../ServletSeleccionarBarrios?codMunicipio=" + encodeURIComponent(municipio.value)+"&codDepartamento=" + encodeURIComponent(departamento.value)+"&codSubgrupo=" + encodeURIComponent(subgrupo.value)+"&tabla=barrio";
       if (typeof XMLHttpRequest != "undefined") 
           req = new XMLHttpRequest();
       else if (window.ActiveXObject) 
           req = new ActiveXObject("Microsoft.XMLHTTP");
       req.open("GET", url, true);
       req.onreadystatechange = callbackSeleccionarBarrios;
       req.send(null);
    }
    
    function callbackSeleccionarBarrios()
    {
        if (req.readyState == 4) 
            if (req.status == 200) 
                obtenerListadoBarrios();
    }
    
    function obtenerListadoBarrios()
    { 
        var mdiv = document.getElementById("spanBarrio");
        var select, xmlBarrios, i, cantBarrios, barrio, codBarrio;

        xmlBarrios = req.responseXML.getElementsByTagName("barrios")[0];
        cantBarrios = xmlBarrios.getElementsByTagName("barrio").length;

        select = "<select name=\"barriores\" id=\"barriores\" style=\"width:150px\">";
        select = select + "<option value=\"\">Seleccione el Barrio</option>";
        for(i=0; i<cantBarrios; i++ )
        {
            codBarrio = xmlBarrios.getElementsByTagName("codbarrio")[i];
            barrio = xmlBarrios.getElementsByTagName("nombre")[i];

            select = select+"<option value=\""+codBarrio.childNodes[0].nodeValue+"\">"+barrio.childNodes[0].nodeValue+"</option>";
        }
        select = select+"</select>";
        mdiv.innerHTML = '&nbsp;';
        mdiv.innerHTML = select;
    }

</script>
</body>
</html>