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
		Calendar.setup({inputField : "esttemfecact",ifFormat : "%d/%m/%Y",button : "botonesttemfecact"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('esttemid','esttemfecact','esttemidenti','esttemquien','esttemarchiv','esttemaccion','esttemobserv');
            var combos = new Array('codtipoidentidad','tipestcodigo');
			
            var arrayNonulos               	= new Array('esttemid');
            var arrayNumerosEnteros        	= new Array('esttemid');
            var arrayCombos               	= new Array('codtipoidentidad','tipestcodigo');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= new Array('esttemquien');
            var arrayComentarios           	= new Array('esttemarchiv','esttemaccion','esttemobserv');
            var arrayNumerosDoubles        	= null;
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
    <c:if test='${param.llave != null && param.llave != ""}'>
            <sql:query var="r" sql="SELECT * FROM estimulaciontemprana WHERE esttemid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="esttemid" value="${fila.esttemid}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="esttemidenti" value="${fila.esttemidenti}"/>
              <fmt:formatDate value="${fila.esttemfecact}" pattern="dd/MM/yyyy" var="esttemfecact"/>  
              <c:set var="esttemquien" value="${fila.esttemquien}"/>
              <c:set var="tipestcodigo" value="${fila.tipestcodigo}"/>
              <c:set var="esttemaccion" value="${fila.esttemaccion}"/>
              <c:set var="esttemarchiv" value="${fila.esttemarchiv}"/>  
              <c:set var="esttemobserv" value="${fila.esttemobserv}"/> 
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(estimulaciontemprana.archivofi, '${ruta}${esttemarchiv}') from estimulaciontemprana WHERE esttemid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
               
            </jsp2:forEach>
            <table width="811" border="0" class="tablaContenido">
<form name="formulario" method="post" action="RegistroEstimulacionTemprana.jsp">
    <span id="mensajeControlador">${msj}</span>


  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Registro Estimulaci&oacute;n Temprana</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="28">&nbsp;</td>
    <td width="130"><span class="bgDescTablas" style="width: 20%"><strong>Id Registro</strong></span></td>
    <td width="166"><span class="sinBgDescTablas" style="width: 60%">
      <input name="esttemid" type="text" id="esttemid" value="${esttemid}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
    <td width="23">&nbsp;</td>
    <td width="116"><span class="bgDescTablas" style="width: 20%"><strong>Fecha Actividad</strong></span></td>
    <td width="179"><span class="sinBgDescTablas" style="width: 20%">
      <input name="esttemfecact" type="text" id="esttemfecact" value="${esttemfecact}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button" type="button" id="botonesttemfecact" value="..." />
      </span></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidad" id="codtipoidentidad">
         <option id="codtipoidentidad" value=""></option>
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
    <td><span class="bgDescTablas" style="width: 20%"><strong>Nro. Identificaci&oacute;n</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="esttemidenti" type="text" id="esttemidenti" value="${esttemidenti}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Quien Realiz&oacute; la Actividad</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="esttemquien" type="text" id="esttemquien" value="${esttemquien}" size="20" maxlength="80" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Estimulaci&oacute;n</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="tipestcodigo" id="tipestcodigo">
        <option id="tipestcodigo" value=""></option>
        <sql:query var="r" sql="select tipestcodigo, tipestdescri from tipoestimulacion" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.tipestcodigo == tipestcodigo}'>
              <option value="${fila.tipestcodigo}" selected="selected">${fila.tipestdescri}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.tipestcodigo}">${fila.tipestdescri}</option>
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
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Archivo Documento Actividades</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
      <input name="esttemarchiv" type="text" id="esttemarchiv" size="15"  value="${esttemarchiv}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${esttemarchiv != null && esttemarchiv != ""}'><br />
        <a href="../temp/${esttemarchiv}" target="_blank">Descargar ${esttemarchiv}</a> </c:if>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center"><strong><span class="bgDescTablas" style="width: 20%; height: 85px;"><strong>Acciones de Estimulaci&oacute;n Temprana</strong></span></strong></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 60%; height: 85px;">
        <textarea cols="75" rows="3" name="esttemaccion" id="esttemaccion" onkeypress="javascript:return permite(event, 'com')">${esttemaccion}</textarea>
        </span></p></td>
    </tr>
  <tr>
    <td colspan="6"><p align="center"><span class="bgDescTablas" style="width: 20%; height: 85px;"><strong>Observaciones</strong></span></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 63%; height: 85px;">
        <textarea cols="75" rows="3" name="esttemobserv" id="esttemobserv" onkeypress="javascript:return permite(event, 'com')">${esttemobserv}</textarea></span></p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        url = url + "campo=esttemarchiv";
        
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
        llaves = 'esttemid='+document.getElementById('esttemid').value;
        validarLlave('estimulaciontemprana',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=estimulaciontemprana&";
        url = url + "campos=esttemid,codtipoidentidad,esttemidenti,esttemfecact,esttemquien,tipestcodigo,esttemaccion&";
        url = url + "campoLlave=esttemid";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>