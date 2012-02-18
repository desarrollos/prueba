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
            Calendar.setup({inputField : "salquefecha",ifFormat : "%d/%m/%Y",button : "botonSalquefecha"});
        }
			
			//totalidad de elementos en el form
            var cajas = new Array('salqueid','salquefecha','salqueidentidadper','salquearchivo','salqueobservacion');
            var combos = new Array('codtipoidentidadper','numidentfunc','queclacodigo');
                      
            //validar
            var arrayNonulos               = new Array('salqueid');
            var arrayNumerosEnteros        = new Array('salqueid');
            var arrayCombos                = new Array('codtipoidentidadper','numidentfunc','queclacodigo');
            var arrayCadenasANCod          = new Array('salqueidentidadper');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('salquearchivo','salqueobservacion');
            var arrayNumerosDoubles        = null;
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
            <c:if test='${param.llave != null && param.llave != ""}'>
            <sql:query var="r" sql="SELECT * FROM saludqueja WHERE salqueid='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="salqueid" value="${fila.salqueid}"/>
              <c:set var="codtipoidentidadper" value="${fila.codtipoidentidadper}"/>
              <c:set var="salqueidentidadper" value="${fila.salqueidentidadper}"/>
              <fmt:formatDate value="${fila.salquefecha}" pattern="dd/MM/yyyy" var="salquefecha"/>
              <c:set var="tipquecodigo" value="${fila.tipquecodigo}"/>
              <c:set var="queclacodigo" value="${fila.queclacodigo}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              <c:set var="salquearchivo" value="${fila.salquearchivo}"/>               
              <c:set var="salqueobservacion" value="${fila.salqueobservacion}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(saludqueja.archivofi, '${ruta}${salquearchivo}') from saludqueja where salqueid='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
</textarea>



<table width="810" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
<form name="formulario" method="post" action="SaludQueja.jsp">
  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Registro Quejas Salud</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="27">&nbsp;</td>
    <td width="127"><span class="bgDescTablas" style="width: 20%"><strong>Consecutivo Queja</strong></span></td>
    <td width="174"><label><span class="sinBgDescTablas" style="width: 10%">
      <input name="salqueid" type="text" id="salqueid" value="${salqueid}" size="20" maxlength="9" />
    </span></label></td>
    <td width="18">&nbsp;</td>
    <td width="118"><strong class="bgDescTablas"><span class="bgDescTablas" style="width: 10%"><strong>Fecha</strong></span></strong></td>
    <td width="178"><span class="sinBgDescTablas" style="width: 10%">
      <input name="salquefecha" type="text" id="salquefecha" value="${salquefecha}" size="18" readonly="readonly" />
      <input name="button" type="button" id="botonSalquefecha" value="..." />
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Tipo Id. </strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidadper" id="codtipoidentidadper" style="width: 150px">
          <option id="codtipoidentidadper" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidadper}'>
                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td class="bgDescTablas"><strong>Nro. Identificaci&oacute;n</strong></td>
    <td class="sinBgDescTablas"><span class="sinBgDescTablas" style="width: 10%">
      <input name="salqueidentidadper" type="text" id="salqueidentidadper" value="${salqueidentidadper}" size="20" maxlength="18" />
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><span class="bgDescTablas" style="width: 10%"><strong>Funcionario</strong></span></td>
    <td colspan="4" class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 18%">
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
    <td><span class="bgDescTablas"><span class="bgDescTablas" style="width: 10%"><strong>Clasificaci&oacute;n Queja</strong></span></span></td>
    <td><span class="sinBgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
      <select name="queclacodigo" id="queclacodigo" style="width: 150px">
        <option id="queclacodigo" value=""></option>
        <sql:query var="r" sql="select tipquecodigo, queclacodigo, quecladescri from quejaclasificacion" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.tipquecodigo == tipquecodigo && fila.queclacodigo == queclacodigo}'>
              <option value="${fila.tipquecodigo} ${fila.queclacodigo}" selected="selected">${fila.quecladescri}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.tipquecodigo} ${fila.queclacodigo}">${fila.quecladescri}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </span></span></td>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Archivo Documento</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="salquearchivo" type="text" id="salquearchivo" size="15"  value="${salquearchivo}" readonly="readonly"/>
      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
      <c:if test='${salquearchivo != null && salquearchivo != ""}'><br>
        <a href="../temp/${salquearchivo}" target="_blank">Descargar ${salquearchivo}</a></c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center">
        <label>
        <textarea name="salqueobservacion" cols="75" rows="3" id="salqueobservacion">${salqueobservacion}</textarea>
        </label>
      </p></td>
  </tr>
        <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        llaves = 'salqueid='+document.getElementById('salqueid').value;
        validarLlave('saludqueja',llaves);
    }
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=salquearchivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=saludqueja&";
        url = url + "campos=salqueid,salqueidentidadper,salquefecha,tipquecodigo,queclacodigo,numidentfunc,salqueobservacion,salquearchivo&";
        url = url + "campoLlave=salqueid";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>