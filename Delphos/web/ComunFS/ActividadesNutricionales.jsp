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
                Calendar.setup({inputField : "nutregfecact",ifFormat : "%d/%m/%Y",button : "botonnutregfecact"});
                Calendar.setup({inputField : "nutregfecreg",ifFormat : "%d/%m/%Y",button : "botonnutregfecreg"});
            }

            //totalidad de elementos en el form
            var cajas = new Array('nutregid','nutregideper','nutregidemad','nutregfecact','nutregfecreg','nutregarchiv','nutregobserv');
            var combos = new Array('codtipoidentidadper','codtipoidentidadma','codtipoactividad');
			
            var arrayNonulos               	= new Array('nutregid','nutregfecact','nutregfecreg');
            var arrayNumerosEnteros        	= new Array('nutregid');
            var arrayCombos               	= new Array('codtipoidentidadper','codtipoidentidadma','codtipoactividad');
            var arrayCadenasANCod          	= new Array('nutregideper','nutregidemad');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('nutregarchiv','nutregobserv');
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
            <sql:query var="r" sql="SELECT * FROM nutricionregistro WHERE nutregid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="nutregid" value="${fila.nutregid}"/>
              <c:set var="codtipoidentidadper" value="${fila.codtipoidentidadper}"/>
              <c:set var="nutregideper" value="${fila.nutregideper}"/>
              <c:set var="codtipoidentidadma" value="${fila.codtipoidentidadma}"/>
              <c:set var="nutregidemad" value="${fila.nutregidemad}"/>
              <c:set var="nutregfecact" value="${fila.nutregfecact}"/>
              <c:set var="nutregfecreg" value="${fila.nutregfecreg}"/>
              <c:set var="codtipoactividad" value="${fila.codtipoactividad}"/>              
              <c:set var="nutregarchiv" value="${fila.nutregarchiv}"/>
              <c:set var="nutregobserv" value="${fila.nutregobserv}"/>
              
              <fmt:formatDate value="${fila.nutregfecact}" pattern="dd/MM/yyyy" var="nutregfecact"/>
              <fmt:formatDate value="${fila.nutregfecreg}" pattern="dd/MM/yyyy" var="nutregfecreg"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(nutricionregistro.archivofi, '${ruta}${nutregarchiv}') from nutricionregistro where nutregid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
                    
            </jsp2:forEach>    
  <table width="811" border="0" class="tablaContenido">
<form name="formulario" method="post" action="ActividadesNutricionales.jsp">
    
              <span id="mensajeControlador">${msj}</span>
  <tr>
    <td colspan="6"><div align="center" class="titulo1">Actividades Nutricionales</div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="149"><span class="bgDescTablas"><strong>Id. Registro</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas">
      <input name="nutregid" type="text" id="nutregid" value="${nutregid}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Tipo Id. Persona</strong></td>
    <td width="158"><span class="sinBgDescTablas">
      <select name="codtipoidentidadper" id="codtipoidentidadper">
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
    <td width="25">&nbsp;</td>
    <td width="157"><strong class="bgDescTablas">Nro. Id. Persona</strong></td>
    <td width="157"><span class="sinBgDescTablas">
      <input name="nutregideper" type="text" id="nutregideper" value="${nutregideper}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Tipo Id. Madre L&iacute;der</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="codtipoidentidadma" id="codtipoidentidadma">
         <option id="codtipoidentidadma" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidadma}'>
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
    <td><span class="bgDescTablas"><strong>Nro. Id. Madre L&iacute;der</strong></span></td>
    <td><span class="sinBgDescTablas">
      <input name="nutregidemad" type="text" id="nutregidemad" value="${nutregidemad}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Tipo  Actividad</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="codtipoactividad" id="codtipoactividad">
               <option id="codtipoactividad" value=""></option>
          <sql:query var="r" sql="select codtipoactividad, descripcion from tipoactividad" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoactividad == codtipoactividad}'>
                <option value="${fila.codtipoactividad}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoactividad}">${fila.descripcion}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Fecha Actividad</strong></span></td>
    <td><span class="sinBgDescTablas">
      <input name="nutregfecact" type="text" id="nutregfecact" value="${nutregfecact}" size="15" readonly="readonly" />
      <input name="button" type="button" id="botonnutregfecact" value="..." />
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Fecha Registro</strong></span></td>
    <td><span class="sinBgDescTablas">
      <input name="nutregfecreg" type="text" id="nutregfecreg" value="${nutregfecreg}" size="15" readonly="readonly" />
      <input name="button2" type="button" id="botonnutregfecreg" value="..." />
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Archivo Documento Certificado</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="nutregarchiv" type="text" id="nutregarchiv" size="15"  value="${nutregarchiv}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${nutregarchiv != null && nutregarchiv != ""}'><br />
        <a href="../temp/${nutregarchiv}" target="_blank">Descargar ${nutregarchiv}</a> </c:if>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><div align="center">
      <p><strong><span class="bgDescTablas" style="height: 85px;"><strong>Observaciones</strong></span></strong></p>
      <p><span class="bgDescTablas" style="height: 85px;"><span class="sinBgDescTablas" style="height: 85px;">
        <textarea cols="75" rows="3" name="nutregobserv" id="nutregobserv" onkeypress="javascript:return permite(event, 'com')">${nutregobserv}</textarea>
        </span></span></p>
    </div></td>
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
        <jsp:include page="../footer.jsp" />    </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    configurar();
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=nutregarchiv";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
        llaves = 'nutregid='+document.getElementById('nutregid').value;
        validarLlave('nutricionregistro',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=nutricionregistro&";
        url = url + "campos=nutregid,codtipoidentidadper,nutregideper,codtipoidentidadma,nutregidemad,nutregfecact,nutregfecreg,codtipoactividad&";
        url = url + "campoLlave=nutregid";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>   