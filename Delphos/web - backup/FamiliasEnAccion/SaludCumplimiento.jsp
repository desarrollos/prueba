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
		Calendar.setup({inputField : "salcumfecini",ifFormat : "%d/%m/%Y",button : "botonsalcumfecini"});
		Calendar.setup({inputField : "salcumfecfin",ifFormat : "%d/%m/%Y",button : "botonsalcumfecfin"});
	    }
		   
		    //totalidad de elementos en el form
            var cajas = new Array('salcumidentis','salcumfecini','salcumfecfin','salcumobserv');
            var combos = new Array('codtipoidentidads','codtiporequisitos','codestcumplimiento');
			
            var arrayNonulos               	= new Array('salcumidentis');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipoidentidads','codtiporequisitos','codestcumplimiento');
            var arrayCadenasANCod          	= new Array('salcumidenti');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('salcumobserv');
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
            <c:if test="${param.codtipoidentidad != null && param.salcumidenti != null}">
            <sql:query var="r" sql="SELECT * FROM saludcumplimiento WHERE codtipoidentidad='${param.codtipoidentidad}' AND salcumidenti='${param.salcumidenti}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="salcumidentif" value="${fila.salcumidenti}"/>
              <fmt:formatDate value="${fila.salcumfecini}" pattern="dd/MM/yyyy" var="salcumfecini"/>
              <fmt:formatDate value="${fila.salcumfecfin}" pattern="dd/MM/yyyy" var="salcumfecfin"/>
              <c:set var="codtiporequisitof" value="${fila.codtiporequisito}"/>
              <c:set var="coditipbenf" value="${fila.coditipben}"/>
              <c:set var="codactividadsaludf" value="${fila.codactividadsalud}"/>
              <c:set var="codestcumplimiento" value="${fila.codestcumplimiento}"/>  
              <c:set var="salcumobserv" value="${fila.salcumobserv}"/>  
            </jsp2:forEach>
            
<form name="formulario" method="post" action="SaludCumplimiento.jsp">
<table width="808" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Cumplimiento Salud</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="27">&nbsp;</td>
    <td width="127"><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
    <td width="175"><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidads" id="codtipoidentidads" style="width: 150px">
               <option id="codtipoidentidads" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidadf}'>
                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td width="15">&nbsp;</td>
    <td width="141"><span class="bgDescTablas" style="width: 20%"><strong> Nro. Identificaci&oacute;n</strong></span></td>
    <td width="157"><span class="sinBgDescTablas" style="width: 20%">
      <input name="salcumidentis" type="text" id="salcumidentis" value="${salcumidentif}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Fecha Inicial</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="salcumfecini" type="text" id="salcumfecini" value="${salcumfecini}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button" type="button" id="botonsalcumfecini" value="..." />
      </span></span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Fecha Final</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="salcumfecfin" type="text" id="salcumfecfin" value="${salcumfecfin}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button2" type="button" id="botonsalcumfecfin" value="..." />
      </span></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Requisito</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtiporequisitos" id="codtiporequisitos" style="width: 150px">
               <option id="codtiporequisitos" value=""></option>
          <sql:query var="r" sql="select codtiporequisito, coditipben, codactividadsalud, requisdescri from requisitos" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtiporequisito == codtiporequisitof && fila.coditipben == coditipbenf && fila.codactividadsalud == codactividadsaludf}'>
                <option value="${fila.codtiporequisito} ${fila.coditipben} ${fila.codactividadsalud}" selected="selected">${fila.requisdescri}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtiporequisito} ${fila.coditipben} ${fila.codactividadsalud}">${fila.requisdescri}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Estado Cumplimiento</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codestcumplimiento" id="codestcumplimiento" style="width: 150px">
        <option id="codestcumplimiento" value=""></option>
        <sql:query var="r" sql="select codestcumplimiento, descripcion from estadocumplimiento" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.codestcumplimiento == codestcumplimiento}'>
              <option value="${fila.codestcumplimiento}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.codestcumplimiento}">${fila.descripcion}</option>
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
    <td colspan="6"><p align="center"><strong><span class="bgDescTablas"><strong>Observaciones</strong></span></strong></p>
      <p align="center">
        <textarea cols="75" rows="3" name="salcumobserv" id="salcumobserv" onkeypress="javascript:return permite(event, 'com')">${salcumobserv}</textarea>
      </p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="salcumidenti" id="salcumidenti" value="" >
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
        llaves = 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
        llaves+= 'salcumidenti='+document.getElementById('salcumidentis').value;
        validarLlave('saludcumplimiento',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=saludcumplimiento&";
        url = url + "campos=codtipoidentidad,salcumidenti,salcumfecini,salcumfecfin,codtiporequisito,coditipben,codactividadsalud,codestcumplimiento&";
        url = url + "campoLlave=codtipoidentidad,salcumidenti";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>