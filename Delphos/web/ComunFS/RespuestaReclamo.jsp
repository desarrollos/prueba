<!--
	Familias en accion
-->
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
<title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
        <script type="text/javascript" src="../js/jsCalendar/calendar.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/lang/calendar-es.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../js/formsAJAX/fomularioAjax.js"></script>
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
		Calendar.setup({inputField : "resrecfecha",ifFormat : "%d/%m/%Y",button : "botonresrecfecha"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('resrecfecha','resrecarcdoc','resrecpercep','resrecobserv');
            var combos = new Array('reclamconsecs','resclacodigo','numidentfuncs');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('reclamconsecs','resclacodigo','numidentfuncs');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('resrecarcdoc','resrecpercep','resrecobserv');
            var arrayNumerosDoubles        	= null;
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
         <center>
            <c:if test='${param.codunifami != null && param.reclamconsec != null && param.reclamconsec != ""}'>
            <sql:query var="r" sql="SELECT * FROM respuestareclamo WHERE codunifami='${param.codunifami}' AND reclamconsec=${param.reclamconsec}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamis" value="${fila.codunifami}"/>
              <c:set var="reclamconsecf" value="${fila.reclamconsec}"/>
              <fmt:formatDate value="${fila.resrecfecha}" pattern="dd/MM/yyyy" var="resrecfecha"/>
              <c:set var="resclacodigo" value="${fila.resclacodigo}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfuncf" value="${fila.numidentfunc}"/>
              <c:set var="resrecpercep" value="${fila.resrecpercep}"/>              
              <c:set var="tipsatcodigo" value="${fila.tipsatcodigo}"/>              
              <c:set var="resrecarcdoc" value="${fila.resrecarcdoc}"/>              
              <c:set var="resrecobserv" value="${fila.resrecobserv}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(respuestareclamo.archivofi, '${ruta}${resrecarcdoc}') from respuestareclamo WHERE codunifami='${param.llave}' AND reclamconsec=${param.reclamconsec}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
    
<form name="formulario" method="post" action="RespuestaReclamo.jsp">

<table width="845" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Respuesta Reclamo</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="158"><strong class="bgDescTablas">Consecutivo Reclamo</strong></td>
    <td colspan="4"><label><span class="sinBgDescTablas" style="width: 15%">
    <select name="reclamconsecs" id="reclamconsecs" style="width: 150px">
      <option id="reclamconsecs" value=""></option>
      <sql:query var="r" sql="select codunifami, reclamconsec from reclamo" dataSource="jdbc/delphos" scope="page"/>
      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <c:choose>
          <c:when test='${fila.codunifami == codunifamis && fila.reclamconsec == reclamconsecf}'>
            <option value="${fila.codunifami} ${fila.reclamconsec}" selected="selected">${fila.reclamconsec}</option>
          </c:when>
          <c:otherwise>
            <option value="${fila.codunifami} ${fila.reclamconsec}">${fila.reclamconsec}</option>
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
      <input name="resrecfecha" type="text" id="resrecfecha" value="${resrecfecha}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button" type="button" id="botonresrecfecha" value="..." />
      </span>    </span></td>
    <td width="26">&nbsp;</td>
    <td width="111"><span class="bgDescTablas" style="width: 10%"><strong>Clasificaci&oacute;n Respuesta</strong></span></td>
    <td width="173"><span class="sinBgDescTablas" style="width: 13%">
      <select name="resclacodigo" id="resclacodigo" style="width: 150px">
           <option id="resclacodigo" value=""></option>
          <sql:query var="r" sql="select resclacodigo, rescladescri from respuestaclasificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.resclacodigo == resclacodigo}'>
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
      <select name="numidentfuncs" id="numidentfuncs" style="width: 150px">
          <option id="numidentfuncs" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidadf && fila.numidentfunc == numidentfuncf}'>
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
      <input name="resrecarcdoc" type="text" id="resrecarcdoc" size="15"  value="${resrecarcdoc}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${resrecarcdoc != null && resrecarcdoc != ""}'><br />
        <a href="../temp/${resrecarcdoc}" target="_blank">Descargar ${resrecarcdoc}</a> </c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center"><strong class="bgDescTablas">Percepci&oacute;n del Usuario</strong></p>
      <p align="center">
        <textarea cols="75" rows="3" name="resrecpercep" id="resrecpercep" onkeypress="javascript:return permite(event, 'com')">${resrecpercep}</textarea>
      </p></td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center" class="tablaContenido"> 
        <textarea cols="75" rows="3" name="resrecobserv" id="resrecobserv" onkeypress="javascript:return permite(event, 'com')">${resrecobserv}</textarea>
        </p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="reclamconsec" id="reclamconsec" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <input type="button" onClick="buscar();" value="Buscar" tabindex="17">
		  <label>&nbsp;</label>
		  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/> -->
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
        <jsp:include page="../footer.jsp" />    </td>
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
        url = url + "campo=resrecarcdoc";
        
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
        var cad = document.getElementById('reclamconsecs').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codunifami='+cad2[0]+',';
	llaves+= 'reclamconsec='+cad2[1];
		
        validarLlave('respuestareclamo',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=respuestareclamo&";
        url = url + "campos=codunifami,reclamconsec,resrecfecha,resclacodigo,codtipoidentidad,numidentfunc&";
        url = url + "campoLlave=codunifami,reclamconsec";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>