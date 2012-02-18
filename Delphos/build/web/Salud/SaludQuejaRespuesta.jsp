<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

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
            Calendar.setup({inputField : "saqurefecha",ifFormat : "%d/%m/%Y",button : "botonSaqurefecha"});
        }
			
			//totalidad de elementos en el form
            var cajas = new Array('saqurefecha','saqurearchivo','saqurepercepcion','saqureobservacion');
            var combos = new Array('salqueids','resclacodigos','numidentfunc');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('salqueids','resclacodigos','numidentfunc');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('saqurearchivo','saqurepercepcion','saqureobservacion');
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
            <c:if test='${param.salqueid != null && param.resclacodigo != null && param.salqueid != ""}'>
            <sql:query var="r" sql="SELECT * FROM saludquejarespuesta WHERE salqueid=${param.salqueid} AND resclacodigo='${param.resclacodigo}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="salqueidf" value="${fila.salqueid}"/>
              <c:set var="resclacodigof" value="${fila.resclacodigo}"/>
              <fmt:formatDate value="${fila.saqurefecha}" pattern="dd/MM/yyyy" var="saqurefecha"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              <c:set var="saqurepercepcion" value="${fila.saqurepercepcion}"/>
              <c:set var="tipsatcodigo" value="${fila.tipsatcodigo}"/>
              <c:set var="saqurearchivo" value="${fila.saqurearchivo}"/>              
              <c:set var="saqureobservacion" value="${fila.saqureobservacion}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(saludquejarespuesta.archivofi, '${ruta}${saqurearchivo}') from saludquejarespuesta WHERE salqueid=${param.salqueid} AND resclacodigo='${param.resclacodigo}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
    
<table width="678" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
<form name="formulario" method="post" action="SaludQuejaRespuesta.jsp">
  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Respuesta Quejas Salud</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="125"><p class="bgDescTablas"><strong class="bgDescTablas">Consecutivo Queja</strong></p></td>
    <td colspan="4"><label>
      <select name="salqueids" id="salqueids" style="width: 150px">
        <option id="salqueids" value=""></option>
        <sql:query var="r" sql="select salqueid from saludqueja" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.salqueid == salqueidf}'>
              <option value="${fila.salqueid}" selected="selected">${fila.salqueid}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.salqueid}">${fila.salqueid}</option>
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
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 10%"><strong>Fecha</strong></span></td>
    <td width="170"><span class="sinBgDescTablas" style="width: 20%">
      <input name="saqurefecha" type="text" id="saqurefecha" value="${saqurefecha}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button" type="button" id="botonSaqurefecha" value="..." />
      </span>    </span></td>
    <td width="16">&nbsp;</td>
    <td width="126"><span class="bgDescTablas" style="width: 20%"><strong>Clasificaci&oacute;n Respuesta</strong></span></td>
    <td width="176"><span class="sinBgDescTablas" style="width: 20%">
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
    <td><span class="sinBgDescTablas" style="width: 25%">
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
    <td><span class="bgDescTablas" style="width: 10%"><strong>Archivo Documento</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="saqurearchivo" type="text" id="saqurearchivo" size="15"  value="${saqurearchivo}" readonly="readonly"/>
      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
      <c:if test='${saqurearchivo != null && saqurearchivo != ""}'><br>
        <a href="../temp/${saqurearchivo}" target="_blank">Descargar ${saqurearchivo}</a></c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Percepci&oacute;n del Usuario</strong></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 40%">
        <textarea name="saqurepercepcion" cols="75" rows="3" id="saqurepercepcion">${saqurepercepcion}</textarea>
      </span></p></td>
  </tr>
  <tr>
    <td colspan="6"><p align="center"><strong><span class="bgDescTablas" style="width: 15%"><strong>Observaciones</strong></span></strong></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 40%">
        <textarea name="saqureobservacion" cols="75" rows="3" id="saqureobservacion">${saqureobservacion}</textarea>
      </span></p></td>
    </tr>
        <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="salqueid" id="salqueid" value="" >
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
        llaves = 'salqueid='+document.getElementById('salqueids').value+',';
		llaves+= 'resclacodigo='+document.getElementById('resclacodigos').value;
        validarLlave('saludquejarespuesta',llaves);
    }
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=saqurearchivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=saludquejarespuesta&";
        url = url + "campos=salqueid,resclacodigo,saqurefecha,codtipoidentidad,numidentfunc,saqurepercepcion,tipsatcodigo,saqurearchivo&";
        url = url + "campoLlave=salqueid,resclacodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>