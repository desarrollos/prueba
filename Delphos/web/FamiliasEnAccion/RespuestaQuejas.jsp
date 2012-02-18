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
<head>
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
        <script type="text/javascript" src="../js/pestanas/jquery-1.2.2.pack.js"></script>
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
           
            function configurar()
            {
		Calendar.setup({inputField : "queresfecha",ifFormat : "%d/%m/%Y",button : "botonqueresfecha"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('queresfecha','queresarchiv','querespercep','queresobserv');
            var combos = new Array('quejconsecuts','resclacodigo','numidentfunc','tipsatcodigo');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('quejconsecuts','resclacodigo','numidentfunc','tipsatcodigo');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('queresarchiv','querespercep','queresobserv');
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
            <c:if test='${param.codunifami != null && param.quejconsecut != null && param.quejconsecut != ""}'>
            <sql:query var="r" sql="SELECT * FROM quejarespuesta WHERE codunifami='${param.codunifami}' AND quejconsecut=${param.quejconsecut}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="quejconsecutf" value="${fila.quejconsecut}"/>
              <fmt:formatDate value="${fila.queresfecha}" pattern="dd/MM/yyyy" var="queresfecha"/>
              <c:set var="resclacodigo" value="${fila.resclacodigo}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              <c:set var="querespercep" value="${fila.querespercep}"/>
              <c:set var="tipsatcodigo" value="${fila.tipsatcodigo}"/>              
              <c:set var="queresarchiv" value="${fila.queresarchiv}"/>
              <c:set var="queresobserv" value="${fila.queresobserv}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(quejarespuesta.archivofi, '${ruta}${queresarchiv}') from quejarespuesta WHERE codunifami='${param.codunifami}' AND quejconsecut=${param.quejconsecut}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
    
<form name="formulario" method="post" action="RespuestaQuejas.jsp">
<span id="mensajeControlador">${msj}</span>
<table width="678" border="0" class="tablaContenido">

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Respuesta Quejas</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="125"><p class="bgDescTablas"><strong class="bgDescTablas">Consecutivo Queja</strong></p></td>
    <td colspan="4"><label>
      <select name="quejconsecuts" id="quejconsecuts" style="width: 150px">
        <option id="quejconsecuts" value=""></option>
        <sql:query var="r" sql="select codunifami, quejconsecut from quejas" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.codunifami == codunifamif && fila.quejconsecut == quejconsecutf}'>
              <option value="${fila.codunifami} ${fila.quejconsecut}" selected="selected">${fila.quejconsecut}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.codunifami} ${fila.quejconsecut}">${fila.quejconsecut}</option>
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
      <input name="queresfecha" type="text" id="queresfecha" value="${queresfecha}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button" type="button" id="botonqueresfecha" value="..." />
      </span>    </span></td>
    <td width="16">&nbsp;</td>
    <td width="126"><span class="bgDescTablas" style="width: 20%"><strong>Clasificaci&oacute;n Respuesta</strong></span></td>
    <td width="176"><span class="sinBgDescTablas" style="width: 20%">
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
      <input name="queresarchiv" type="text" id="queresarchiv" size="15"  value="${queresarchiv}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${queresarchiv != null && queresarchiv != ""}'><br />
        <a href="../temp/${queresarchiv}" target="_blank">Descargar ${queresarchiv}</a> </c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Percepci&oacute;n del Usuario</strong></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 40%">
        <textarea name="querespercep" cols="75" rows="3" id="querespercep" onkeypress="javascript:return permite(event, 'com')">${querespercep}</textarea>
      </span></p></td>
  </tr>
  <tr>
    <td colspan="6"><p align="center"><strong><span class="bgDescTablas" style="width: 15%"><strong>Observaciones</strong></span></strong></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 40%">
        <textarea name="queresobserv" cols="75" rows="3" id="queresobserv" onkeypress="javascript:return permite(event, 'com')">${queresobserv}</textarea>
      </span></p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="quejconsecut" id="quejconsecut" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17"> -->
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
        <jsp:include page="../footer.jsp" />   </td>
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
        url = url + "campo=queresarchiv";
        
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
        var cad = document.getElementById('quejconsecuts').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codunifami='+cad2[0]+',';
		llaves+= 'quejconsecut='+cad2[1];
		
        validarLlave('quejarespuesta',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=quejarespuesta&";
        url = url + "campos=codunifami,quejconsecut,queresfecha,resclacodigo,codtipoidentidad,numidentfunc,querespercep,tipsatcodigo&";
        url = url + "campoLlave=codunifami,quejconsecut";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>