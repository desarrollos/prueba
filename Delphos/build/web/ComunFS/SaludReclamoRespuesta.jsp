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
		
		function configurar()
        {
            Calendar.setup({inputField : "sarerefecha",ifFormat : "%d/%m/%Y",button : "botonSarerefecha"});
        }
            //totalidad de elementos en el form
            var cajas = new Array('sarerefecha','sarerearchivo','sarerepercepcion','sarereobservacion');
            var combos = new Array('salrecids','resclacodigos','numidentfunc','tipsatcodigo');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('salrecids','resclacodigos','numidentfunc','tipsatcodigo');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('sarerearchivo','sarerepercepcion','sarereobservacion');
            var arrayNumerosDoubles        = null;
            
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
            <c:if test='${param.salrecid != null && param.salrecid !="" && param.resclacodigo != null}'>
            <sql:query var="r" sql="SELECT * FROM saludreclamorespuesta WHERE salrecid=${param.salrecid} AND resclacodigo='${param.resclacodigo}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              
              <c:set var="salrecidf" value="${fila.salrecid}"/>
              <c:set var="resclacodigof" value="${fila.resclacodigo}"/>              
              <fmt:formatDate value="${fila.sarerefecha}" pattern="dd/MM/yyyy" var="sarerefecha"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/> 
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              
              <c:set var="sarerepercepcion" value="${fila.sarerepercepcion}"/>
              <c:set var="tipsatcodigo" value="${fila.tipsatcodigo}"/>
              <c:set var="sarerearchivo" value="${fila.sarerearchivo}"/>              
              
              <c:set var="sarereobservacion" value="${fila.sarereobservacion}"/>
             
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(saludreclamorespuesta.archivofi, '${ruta}${sarerearchivo}') from saludreclamorespuesta where salrecid=${param.salrecid} AND resclacodigo='${param.resclacodigo}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
    
<table width="845" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
<form name="formulario" method="post" action="SaludReclamoRespuesta.jsp">

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Respuesta Reclamo Salud</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="158"><strong class="bgDescTablas">Consecutivo Reclamo</strong></td>
    <td colspan="4"><label><span class="sinBgDescTablas" style="width: 15%">
    <select name="salrecids" id="salrecids" style="width: 150px">
      <option id="salrecids" value=""></option>
      <sql:query var="r" sql="select salrecid from saludreclamo" dataSource="jdbc/delphos" scope="page"/>
      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <c:choose>
          <c:when test='${fila.salrecid == salrecidf}'>
            <option value="${fila.salrecid}" selected="selected">${fila.salrecid}</option>
          </c:when>
          <c:otherwise>
            <option value="${fila.salrecid}">${fila.salrecid}</option>
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
    <td><span class="bgDescTablas" style="width: 15%"><strong>Fecha</strong></span></td>
    <td width="158"><span class="sinBgDescTablas" style="width: 20%">
      <input name="sarerefecha" type="text" id="sarerefecha" value="${sarerefecha}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button" type="button" id="botonSarerefecha" value="..." />
      </span>    </span></td>
    <td width="26">&nbsp;</td>
    <td width="111"><span class="bgDescTablas" style="width: 10%"><strong>Clasificaci&oacute;n Respuesta</strong></span></td>
    <td width="173"><span class="sinBgDescTablas" style="width: 13%">
      <select name="resclacodigos" id="resclacodigos" style="width: 150px">
           <option id="resclacodigos" value=""></option>
          <sql:query var="r" sql="select resclacodigo, rescladescri from respuestaclasificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.resclacodigo == resclacodigof}'>
                <option value="${fila.resclacodigo}" selected="selected">${fila.rescladescri}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.resclacodigo}">${fila.rescladescri}</option>
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
    <td class="bgDescTablas"><strong class="bgDescTablas">Funcionario</strong></td>
    <td colspan="4"><label><span class="sinBgDescTablas" style="width: 15%">
      <select name="numidentfunc" id="numidentfunc" style="width: 150px">
          <option id="numidentfunc" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidad && fila.numidentfunc == numidentfunc}'>
                <option value="${fila.codtipoidentidad} ${fila.numidentfunc}" selected="selected">${fila.nombre}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoidentidad} ${fila.numidentfunc}">${fila.nombre}</option>
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
    <td><strong class="bgDescTablas">Tipo Satisfacci&oacute;n</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="tipsatcodigo" id="tipsatcodigo" style="width: 150px">
        <option id="tipsatcodigo" value=""></option>
        <sql:query var="r" sql="select tipsatcodigo, tipsatdescri from satisfacciontipo" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.tipsatcodigo == tipsatcodigo}'>
              <option value="${fila.tipsatcodigo}" selected="selected">${fila.tipsatdescri}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.tipsatcodigo}">${fila.tipsatdescri}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Archivo Documento</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="sarerearchivo" type="text" id="sarerearchivo" size="15"  value="${sarerearchivo}" readonly="readonly"/>
      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
      <c:if test='${sarerearchivo != null && sarerearchivo != ""}'><br>
        <a href="../temp/${sarerearchivo}" target="_blank">Descargar ${sarerearchivo}</a></c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center"><strong class="bgDescTablas">Percepci&oacute;n del Usuario</strong></p>
      <p align="center">
        <textarea cols="75" rows="3" name="sarerepercepcion" id="sarerepercepcion">${sarerepercepcion}</textarea>
      </p></td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center" class="tablaContenido"> 
        <textarea cols="75" rows="3" name="sarereobservacion" id="sarereobservacion">${sarereobservacion}</textarea>
        </p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="salrecid" id="salrecid" value="" >
                  <input type="hidden" name="resclacodigo" id="resclacodigo" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
	</form>
       </table>
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
	configurar();
	
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
        llaves = 'salrecid='+document.getElementById('salrecids').value+',';
		llaves+= 'resclacodigo='+document.getElementById('resclacodigos').value;
        validarLlave('saludreclamorespuesta',llaves);
    }
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=sarerearchivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }

    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=saludreclamorespuesta&";
        url = url + "campos=salrecid,resclacodigo,sarerefecha,numidentfunc,sarerepercepcion,tipsatcodigo,sarerearchivo&";
        url = url + "campoLlave=salrecid,resclacodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>