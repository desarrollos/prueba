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
		Calendar.setup({inputField : "quejfecha",ifFormat : "%d/%m/%Y",button : "botonquejfecha"});
	    }
            
			//totalidad de elementos en el form
            var cajas = new Array('quejconsecuts','quejciclpago','quejfecha','quejidentifi','quejarchdocu','quejobservac');
            var combos = new Array('codunifamis','codtipoidentidadpers','numidentfunc','queclacodigo');
			
            var arrayNonulos               	= new Array('quejconsecuts');
            var arrayNumerosEnteros        	= new Array('quejconsecuts','quejciclpago');
            var arrayCombos               	= new Array('codunifamis','codtipoidentidadpers','numidentfunc','queclacodigo');
            var arrayCadenasANCod          	= new Array('quejidentifi');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('quejarchdocu','quejobservac');
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
            <sql:query var="r" sql="SELECT * FROM quejas WHERE codunifami='${param.codunifami}' AND quejconsecut=${param.quejconsecut}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="quejconsecutf" value="${fila.quejconsecut}"/>
              <c:set var="quejciclpago" value="${fila.quejciclpago}"/>
              <c:set var="codtipoidentidadpers" value="${fila.codtipoidentidadpers}"/>
              <c:set var="quejidentifi" value="${fila.quejidentifi}"/>
              <fmt:formatDate value="${fila.quejfecha}" pattern="dd/MM/yyyy" var="quejfecha"/>
              <c:set var="tipquecodigo" value="${fila.tipquecodigo}"/>
              <c:set var="queclacodigo" value="${fila.queclacodigo}"/>               
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              <c:set var="quejarchdocu" value="${fila.quejarchdocu}"/>
              <c:set var="quejobservac" value="${fila.quejobservac}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(quejas.archivofi, '${ruta}${quejarchdocu}') from quejas WHERE codunifami='${param.codunifami}' AND quejconsecut=${param.quejconsecut}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
           </jsp2:forEach>
</textarea>



<table width="810" border="0" class="tablaContenido">
<form name="formulario" method="post" action="RegistroQuejas.jsp">
<span id="mensajeControlador">${msj}</span>


  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Registro Quejas</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="27">&nbsp;</td>
    <td width="127"><span class="bgDescTablas" style="width: 15%"><strong>C&oacute;digo &Uacute;nico Familia</strong></span></td>
    <td width="174"><label>
    <select name="codunifamis" id="codunifamis" style="width: 150px">
      <option id="codunifamis" value=""></option>
      <sql:query var="r" sql="select codunifami from inscripcion" dataSource="jdbc/delphos" scope="page"/>
      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <c:choose>
          <c:when test='${fila.codunifami == codunifamif}'>
            <option value="${fila.codunifami}" selected="selected">${fila.codunifami}</option>
          </c:when>
          <c:otherwise>
            <option value="${fila.codunifami}">${fila.codunifami}</option>
          </c:otherwise>
        </c:choose>
      </jsp2:forEach>
    </select>
    </label></td>
    <td width="18">&nbsp;</td>
    <td width="118"><span class="bgDescTablas" style="width: 20%"><strong>Consecutivo Queja</strong></span></td>
    <td width="178"><span class="sinBgDescTablas" style="width: 10%">
      <input name="quejconsecuts" type="text" id="quejconsecuts" value="${quejconsecutf}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Ciclo Pago Afectado</strong></td>
    <td><span class="sinBgDescTablas" style="width: 17%"><span class="sinBgDescTablas" style="width: 10%">
      <input name="quejciclpago" type="text" id="quejciclpago" value="${quejciclpago}" size="20" onkeypress="javascript:return permite(event, 'nume')"/>
      </span></span></td>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas"><span class="bgDescTablas" style="width: 10%"><strong>Fecha</strong></span></strong></td>
    <td><span class="sinBgDescTablas" style="width: 17%">
      <input name="quejfecha" type="text" id="quejfecha" value="${quejfecha}" size="15" readonly="readonly" />
</span>
      <input name="button" type="button" id="botonquejfecha" value="..." />
</span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Tipo Id. </strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidadpers" id="codtipoidentidadpers" style="width: 150px">
          <option id="codtipoidentidadpers" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidad}'>
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
      <input name="quejidentifi" type="text" id="quejidentifi" value="${quejidentifi}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
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
      <input name="quejarchdocu" type="text" id="quejarchdocu" size="15"  value="${quejarchdocu}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${quejarchdocu != null && quejarchdocu != ""}'><br>
        <a href="../temp/${quejarchdocu}" target="_blank">Descargar ${quejarchdocu}</a> </c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center">
        <label>
        <textarea name="quejobservac" cols="75" rows="3" id="quejobservac">${quejobservac}</textarea>
        </label>
      </p></td>
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
          </form>
          </table>
        
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
        url = url + "campo=quejarchdocu";
        
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
        llaves = 'codunifami='+document.getElementById('codunifamis').value+',';
        llaves+= 'quejconsecut='+document.getElementById('quejconsecuts').value;
        validarLlave('quejas',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=quejas&";
        url = url + "campos=codunifami,quejconsecut,quejciclpago,codtipoidentidadpers,quejidentifi,quejfecha,tipquecodigo,queclacodigo&";
        url = url + "campoLlave=codunifami,quejconsecut";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>