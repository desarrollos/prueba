<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
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
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
         function configurar()
        {
            Calendar.setup({inputField : "fechainicio",ifFormat : "%d/%m/%Y",button : "botonFechainicio"});
            Calendar.setup({inputField : "fechafinal",ifFormat : "%d/%m/%Y",button : "botonFechafinal"});
            Calendar.setup({inputField : "fechalegalizac",ifFormat : "%d/%m/%Y",button : "botonFechalegalizac"});
			Calendar.setup({inputField : "fechasuscripcion",ifFormat : "%d/%m/%Y",button : "botonFechasuscripcion"});
        }
                     
            //totalidad de elementos en el form
            var cajas = new Array('codcontratos','numero','descripcion','objeto','fechainicio','fechafinal','valor','fechalegalizac','nroradicacion','fechasuscripcion','usuariosconttrato','codigobarras','archivo','formapago','observacion');
            var combos = new Array('codemprcontratista','codemprcontratante','codtipocontrato','codclasecontrato','codentidadsaluds','codmodalidadcontrato','codtipocubrimupc','codgrupopoblacion','codaplicacioncontrato','coddepartamento','codmunicipio','codnorma','codmodalidadcontrato');
                      
            //validar
            var arrayNonulos               = new Array('codcontratos');
            var arrayNumerosEnteros        = new Array('usuariosconttrato');
            var arrayCombos                = new Array('codemprcontratista','codemprcontratante','codtipocontrato','codclasecontrato','codentidadsaluds','codmodalidadcontrato','codtipocubrimupc','codgrupopoblacion','codaplicacioncontrato','coddepartamento','codmunicipio','codnorma','codmodalidadcontrato');
            var arrayCadenasANCod          = new Array('codcontratos','numero','nroradicacion','codigobarras');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('descripcion','objeto','archivo','formapago','observacion');
            var arrayNumerosDoubles        = new Array('valor');
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[0]);">
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null}">
            <sql:query var="r" sql="SELECT * FROM contrato WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codregimen" value="${fila.codregimen}"/>
              <c:set var="numero" value="${fila.numero}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>           
              <c:set var="objeto" value="${fila.objeto}"/>
              <fmt:formatDate value="${fila.fechainicio}" pattern="dd/MM/yyyy" var="fechainicio"/>
              <fmt:formatDate value="${fila.fechafinal}" pattern="dd/MM/yyyy" var="fechafinal"/>
              <c:set var="codtipocontrato" value="${fila.codtipocontrato}"/>
              <c:set var="codgrupopoblacion" value="${fila.codgrupopoblacion}"/>
              <c:set var="codaplicacioncontrato" value="${fila.codaplicacioncontrato}"/>
              <c:set var="codclasecontrato" value="${fila.codclasecontrato}"/>
              <c:set var="codtipocubrimupc" value="${fila.codtipocubrimupc}"/>
              <c:set var="anyoinicial" value="${fila.anyoinicial}"/>
              <c:set var="mesinicial" value="${fila.mesinicial}"/>
              <c:set var="codestadocontrato" value="${fila.codestadocontrato}"/>
              <c:set var="formapago" value="${fila.formapago}"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
              <c:set var="valor" value="${fila.valor}"/>
              <c:set var="archivo" value="${fila.archivo}"/>
              <c:set var="codigobarras" value="${fila.codigobarras}"/>
              <fmt:formatDate value="${fila.fechalegalizac}" pattern="dd/MM/yyyy" var="fechalegalizac"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="codmodalidadcontrato" value="${fila.codmodalidadcontrato}"/>
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>
              <c:set var="codnorma" value="${fila.codnorma}"/>
              <c:set var="fechanorma" value="${fila.fechanorma}"/>
              <c:set var="nroradicacion" value="${fila.nroradicacion}"/>
              <fmt:formatDate value="${fila.fechasuscripcion}" pattern="dd/MM/yyyy" var="fechasuscripcion"/>
              <c:set var="codtipoidencontratante" value="${fila.codtipoidencontratante}"/>
              <c:set var="codemprcontratante" value="${fila.codemprcontratante}"/>
              <c:set var="codtipoidencontratista" value="${fila.codtipoidencontratista}"/>
              <c:set var="codemprcontratista" value="${fila.codemprcontratista}"/>
              <c:set var="usuariosconttrato" value="${fila.usuariosconttrato}"/>              
                        
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(contrato.archivofi, '${ruta}${archivo}') from contrato where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
            
            
  <form name="formulario" method="post" action="Contrato1.jsp">    
  <table width="767" border="0" class="tablaContenido">
  <span id="mensajeControlador">${msj}</span>
  <tr>
	<td colspan="6" class="titulo1"><div align="center">Datos Basicos </div></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Contratista</strong></td>
    <td class="sinBgDescTablas">
    <select name="codemprcontratista" id="codemprcontratista" style="width: 150px">
               <option id="codemprcontratista" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidencontratista && fila.codempresa == codemprcontratista}'>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
    <td>&nbsp;</td>
    <td class="bgDescTablas"><strong>Contratante</strong></td>
    <td class="sinBgDescTablas">
    <select name="codemprcontratante" id="codemprcontratante" style="width: 150px">
               <option id="codemprcontratante" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidencontratante && fila.codempresa == codemprcontratante}'>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td width="30">&nbsp;</td>
	<td width="142"><span class="bgDescTablas"><strong>Codigo</strong></span></td>
	<td width="200" class="sinBgDescTablas"><input name="codcontratos" type="text" id="codcontratos" value="${codcontratof}" size="20" maxlength="18" /></td>
	<td width="19">&nbsp;</td>
	<td width="130" class="bgDescTablas"><strong>Numero</strong></td>
	<td width="237" class="sinBgDescTablas">
	  <input  name="numero" type="text" id="numero" value="${numero}" size="20" maxlength="20" />	</td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Tipo</strong></td>
	<td class="sinBgDescTablas">
    <select name="codtipocontrato" id="codtipocontrato" style="width: 150px">
             <option id="codtipocontrato" value=""></option>
                  <sql:query var="r" sql="select codtipocontrato, descripcion from tipocontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipocontrato == codtipocontrato}'>
                        <option value="${fila.codtipocontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipocontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Clase</strong></td>
	<td class="sinBgDescTablas">
    <select name="codclasecontrato" id="codclasecontrato" style="width: 150px">
              <option id="codclasecontrato" value=""></option>
                  <sql:query var="r" sql="select codclasecontrato, descripcion from clasecontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codclasecontrato == codclasecontrato}'>
                        <option value="${fila.codclasecontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codclasecontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripcion</strong></p>
      <p align="center"><strong>    
        <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" />
      </strong></p></td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Entidad Salud</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codentidadsaluds" id="codentidadsaluds" style="width: 150px">
               <option id="codentidadsaluds" value=""></option>
                  <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codentidadsalud == codentidadsaludf && fila.codregimenes == codregimenesf}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Modalidad</strong></td>
	<td class="sinBgDescTablas">
	  <select name="codmodalidadcontrato" id="codmodalidadcontrato" style="width: 150px">
               <option id="codmodalidadcontrato" value=""></option>
                  <sql:query var="r" sql="select codmodalidadcontrato, descripcion from modalidadcontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codmodalidadcontrato == codmodalidadcontrato}'>
                        <option value="${fila.codmodalidadcontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codmodalidadcontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select></td>
  </tr>
  <tr>
	<td height="21" colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td height="27" class="bgDescTablas"><strong>Cubrimiento UPC</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codtipocubrimupc" id="codtipocubrimupc" style="width: 150px">
              <option id="codtipocubrimupc" value=""></option>
                  <sql:query var="r" sql="select codregimen, codtipocubrimupc, anyoinicial, mesinicial from upcs" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codregimen == codregimen && fila.codtipocubrimupc == codtipocubrimupc && fila.anyoinicial == anyoinicial && fila.mesinicial == mesinicial}'>
                        <option value="${fila.codregimen} ${fila.codtipocubrimupc} ${fila.anyoinicial} ${fila.mesinicial}" selected="selected">${fila.codtipocubrimupc}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codregimen} ${fila.codtipocubrimupc} ${fila.anyoinicial} ${fila.mesinicial}">${fila.codtipocubrimupc}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Grupo Poblacional</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codgrupopoblacion" id="codgrupopoblacion" style="width: 150px">
           <option id="codgrupopoblacion" value=""></option>
                  <sql:query var="r" sql="select codgrupopoblacion, descripcion from grupopoblacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codgrupopoblacion == codgrupopoblacion}'>
                        <option value="${fila.codgrupopoblacion}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codgrupopoblacion}">${fila.descripcion}</option>
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
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Aplicacion Contrato</strong></td>
	<td class="sinBgDescTablas"><label></label>
	  <select name="codaplicacioncontrato" id="codaplicacioncontrato" style="width: 150px">
            <option id="codaplicacioncontrato" value=""></option>
                  <sql:query var="r" sql="select codaplicacioncontrato, descripcion from aplicacioncontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codaplicacioncontrato == codaplicacioncontrato}'>
                        <option value="${fila.codaplicacioncontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codaplicacioncontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Estado</strong></td>
	<td class="sinBgDescTablas"><label></label>
	  <select name="codestadocontrato" id="codestadocontrato" style="width: 150px">
        <option id="codestadocontrato" value=""></option>
        <sql:query var="r" sql="select codestadocontrato, descripcion from estadocontrato" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.codestadocontrato == codestadocontrato}'>
              <option value="${fila.codestadocontrato}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.codestadocontrato}">${fila.descripcion}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
	<td colspan="6"><div align="center" class="titulo1">Datos Contractuales </div></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Objeto</strong></p>
      <p align="center"><strong>
        <textarea name="objeto" cols="75" rows="3" class="sinBgDescTablas" id="objeto">${objeto}</textarea>
      </strong></p></td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas">&nbsp;</td>
    </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Inicio</strong></td>
	<td class="sinBgDescTablas"><input name="fechainicio" type="text" id="fechainicio" value="${fechainicio}" size="15" readonly="true" />
      <input name="button" type="button" id="botonFechainicio" value="..." /></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Fin</strong></td>
	<td class="sinBgDescTablas"><input name="fechafinal" type="text" id="fechafinal" value="${fechafinal}" size="15" readonly="true" />
      <input name="button2" type="button" id="botonFechafinal" value="..." /></td>
  </tr>
  <tr>
	<td height="28" colspan="6" class="bgDescTablas">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><label><strong>Departamento</strong></label></td>
    <td class="bgDescTablas"><label>
      <select name="coddepartamento" id="coddepartamento" onChange="cargarMunicipios();">
        <option value=""></option>
        <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.coddepartamento == coddepartamento}'>
              <option value="${fila.coddepartamento}" selected="selected">${fila.nombre}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.coddepartamento}">${fila.nombre}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </label></td>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Municipio</strong></td>
    <td class="bgDescTablas">
	<span id="spanMunicipio">
                    <c:choose>
                        <c:when test="${codmunicipio != null}">
                        <select name="codmunicipio" id="codmunicipio">
                        <option value=""></option>
                        <sql:query var="r" sql="select codmunicipio, nombre from municipio where coddepartamento='${coddepartamento}' order by nombre" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                            <c:when test='${fila.codmunicipio == codmunicipio}'>
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
                        <select disabled>
                            <option value=""></option>
                        </select>
                        </c:otherwise>
                    </c:choose>
                </span></td>
  </tr>
  <tr>
	<td height="27" colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td height="27" class="bgDescTablas"><strong>Valor</strong></td>
	<td colspan="4" class="sinBgDescTablas"><label>
	  <input name="valor" type="text" id="valor" value="${valor}" size="20" maxlength="15" />
	</label>	  <label></label></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Legalizacion</strong></td>
	<td class="sinBgDescTablas"><label>
	  <input name="fechalegalizac" type="text" id="fechalegalizac" value="${fechalegalizac}" size="15" readonly="true" />
      <input name="button3" type="button" id="botonFechalegalizac" value="..." />
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Nro. Radicacion</strong></td>
	<td class="sinBgDescTablas"><label>
	  <input name="nroradicacion" type="text" id="nroradicacion" value="${nroradicacion}" size="20" maxlength="20" />
	</label></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Norma</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codnorma" id="codnorma" style="width: 150px">
         <option id="codnorma" value=""></option>
                  <sql:query var="r" sql="select codtiponorma, codnorma, fechanorma, referencia from normas"  dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtiponorma == codtiponorma && fila.codnorma == codnorma && fila.fechanorma == fechanorma}'>
                        <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}" selected="selected">${fila.referencia}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}">${fila.referencia}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Suscripcion</strong></td>
	<td><span class="sinBgDescTablas">
	  <input name="fechasuscripcion" type="text" id="fechasuscripcion" value="${fechasuscripcion}" size="15" readonly="true" />
      <input name="button322" type="button" id="botonFechasuscripcion" value="..." />
	</span></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Modalidad Contrato </strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codmodalidadcontrato" id="codmodalidadcontrato" style="width: 150px">
           <option id="codmodalidadcontrato" value=""></option>
                  <sql:query var="r" sql="select codmodalidadcontrato, descripcion from modalidadcontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codmodalidadcontrato == codmodalidadcontrato}'>
                        <option value="${fila.codmodalidadcontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codmodalidadcontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Nro. Usuarios</strong></td>
	<td class="sinBgDescTablas"><label>
	  <input name="usuariosconttrato" type="text" id="usuariosconttrato" value="${usuariosconttrato}" size="20" maxlength="8" />
	</label></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Codigo Barras</strong></span></td>
    <td><span class="sinBgDescTablas">
      <input name="codigobarras" type="text" id="codigobarras" value="${codigobarras}" size="20" maxlength="70" />
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Archivo</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
      <c:if test='${archivo != null && archivo != ""}'><br>
        <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Forma Pago</strong></p>
    <p align="center"><span class="bgDescTablas">
      <textarea name="formapago" cols="75" rows="3" id="formapago">${formapago}</textarea>
    </span></p></td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center" class="bgDescTablas"><strong>
        <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
        </strong></p></td>
  </tr>
  <tr>
    <td height="26" colspan="6"><p align="center" class="bgDescTablas">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
    			  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
              <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->&nbsp;</p>
			  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
			  </td>
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
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
		
		var cad = document.getElementById('codentidadsaluds').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
				
        llaves+= 'codcontrato='+document.getElementById('codcontratos').value;
		
        validarLlave('contrato',llaves);
    } 
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=contrato&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,codregimen,numero,descripcion,objeto,fechainicio,fechafinal,fechalegalizac,fechasuscripcion&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }
	
	var req;

function cargarMunicipios() 
{
   var departamento = document.getElementById("coddepartamento");
   var url = "../ServletSeleccionarMunicipios?codDepartamento=" + encodeURIComponent(departamento.value);
   if (typeof XMLHttpRequest != "undefined") 
       req = new XMLHttpRequest();
   else if (window.ActiveXObject) 
       req = new ActiveXObject("Microsoft.XMLHTTP");
   req.open("GET", url, true);
   req.onreadystatechange = callbackSeleccionarMunicipios;
   req.send(null);
}

function callbackSeleccionarMunicipios() 
{
    if (req.readyState == 4) 
        if (req.status == 200) 
            obtenerListadoMunicipios();
}

function obtenerListadoMunicipios()
{
    var mdiv = document.getElementById("spanMunicipio");
    var select, xmlMunicipios, i, cantMunicipios, municipio, codMunicipio;
    
    xmlMunicipios = req.responseXML.getElementsByTagName("municipios")[0];
    cantMunicipios = xmlMunicipios.getElementsByTagName("municipio").length;
    
    select = "<select name=\"codmunicipio\" id=\"codmunicipio\" style=\"width:150px\">";
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

</script>
</body>
</html>