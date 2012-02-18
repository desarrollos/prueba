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
		Calendar.setup({inputField : "nutrfechatennutrfechaten",ifFormat : "%d/%m/%Y",button : "botonnutrfechaten"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('nutridregist','nutrfechatennutrfechaten','nutridentifi','nutrcantidad','nutrarchivo','nutrobservac');
            var combos = new Array('codtipoidentidad','codfinalidadconsulta','coddiagnosticopr','coddiagnosticor1','coddiagnosticor2','coddiagnosticor3','coddiagnosticosa');
			
            var arrayNonulos               	= new Array('nutridregist','nutrfechatennutrfechaten','nutrcantidad');
            var arrayNumerosEnteros        	= new Array('nutridregist','nutrcantidad');
            var arrayCombos               	= new Array('codtipoidentidad','codfinalidadconsulta','coddiagnosticopr','coddiagnosticor1','coddiagnosticor2','coddiagnosticor3','coddiagnosticosa');
            var arrayCadenasANCod          	= new Array('nutridentifi');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('nutrarchivo','nutrobservac');
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
            <sql:query var="r" sql="SELECT * FROM nutricionvaloracion WHERE nutridregist=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="nutridregist" value="${fila.nutridregist}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="nutridentifi" value="${fila.nutridentifi}"/>
              <c:set var="nutrcantidad" value="${fila.nutrcantidad}"/>
              <fmt:formatDate value="${fila.nutrfechatennutrfechaten}" pattern="dd/MM/yyyy" var="nutrfechatennutrfechaten"/>
              <c:set var="codfinalidadconsulta" value="${fila.codfinalidadconsulta}"/>
              <c:set var="coddiagnosticopr" value="${fila.coddiagnosticopr}"/>
              <c:set var="coddiagnosticor1" value="${fila.coddiagnosticor1}"/> 
              <c:set var="coddiagnosticor2" value="${fila.coddiagnosticor2}"/>
              <c:set var="coddiagnosticor3" value="${fila.coddiagnosticor3}"/>
              <c:set var="coddiagnosticosa" value="${fila.coddiagnosticosa}"/>
              <c:set var="nutrarchivo" value="${fila.nutrarchivo}"/>
              <c:set var="nutrobservac" value="${fila.nutrobservac}"/>
              
               <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(nutricionvaloracion.archivofi, '${ruta}${nutrarchivo}') from nutricionvaloracion WHERE nutridregist=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
    
<form name="formulario" method="post" action="ValoracionNutricional.jsp">
<table width="821" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Valoracion Nutricional</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="149"><span class="bgDescTablas"><strong>Id Registro</strong></span></td>
    <td width="164"><span class="sinBgDescTablas">
      <input name="nutridregist" type="text" id="nutridregist" value="${nutridregist}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
    <td width="15">&nbsp;</td>
    <td width="162"><span class="bgDescTablas"><strong>Fecha Atenci&oacute;n</strong></span></td>
    <td width="156"><span class="sinBgDescTablas">
      <input name="nutrfechatennutrfechaten" type="text" id="nutrfechatennutrfechaten" value="${nutrfechatennutrfechaten}" size="15" readonly="readonly" />
      <input name="button" type="button" id="botonnutrfechaten" value="..." />
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Tipo Id.</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="codtipoidentidad" id="codtipoidentidad" style="width: 150px">
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
    <td><span class="bgDescTablas"><strong>Nro. Identificaci&oacute;n</strong></span></td>
    <td><span class="sinBgDescTablas">
      <input name="nutridentifi" type="text" id="nutridentifi" value="${nutridentifi}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Cantidad</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas">
      <input name="nutrcantidad" type="text" id="nutrcantidad" value="${nutrcantidad}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Finalidad Consulta</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="codfinalidadconsulta" id="codfinalidadconsulta" style="width: 150px">
               <option id="codfinalidadconsulta" value=""></option>
              <sql:query var="r" sql="select codfinalidadconsulta, descripcion from finalidadconsulta" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
               <c:choose>
                    <c:when test='${fila.codfinalidadconsulta == codfinalidadconsulta}'>
                    <option value="${fila.codfinalidadconsulta}" selected="selected">${fila.descripcion}</option>
                    </c:when>
                <c:otherwise>
                    <option value="${fila.codfinalidadconsulta}">${fila.descripcion}</option>
                </c:otherwise>
               </c:choose>
             </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Dx Principal</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="coddiagnosticopr" id="coddiagnosticopr" style="width: 150px">
        <option id="coddiagnosticopr" value=""></option>
        <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.coddiagnostico == coddiagnosticopr}'>
              <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
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
    <td><span class="bgDescTablas"><strong>Dx Relacionado 1</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="coddiagnosticor1" id="coddiagnosticor1" style="width: 150px">
        <option id="coddiagnosticor1" value=""></option>
        <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.coddiagnostico == coddiagnosticor1}'>
              <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Dx Relacionado 2</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="coddiagnosticor2" id="coddiagnosticor2" style="width: 150px">
        <option id="coddiagnosticor2" value=""></option>
        <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.coddiagnostico == coddiagnosticor2}'>
              <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
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
    <td><span class="bgDescTablas"><strong>Dx Relacionado 3</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="coddiagnosticor3" id="coddiagnosticor3" style="width: 150px">
        <option id="coddiagnosticor3" value=""></option>
        <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.coddiagnostico == coddiagnosticor3}'>
              <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Dx Salida</strong></span></td>
    <td><span class="sinBgDescTablas">
      <select name="coddiagnosticosa" id="coddiagnosticosa" style="width: 150px">
        <option id="coddiagnosticosa" value=""></option>
        <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.coddiagnostico == coddiagnosticosa}'>
              <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
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
    <td><span class="bgDescTablas"><strong>Archivo Documento</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
      <input name="nutrarchivo" type="text" id="nutrarchivo" size="15"  value="${nutrarchivo}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${nutrarchivo != null && nutrarchivo != ""}'><br />
        <a href="../temp/${nutrarchivo}" target="_blank">Descargar ${nutrarchivo}</a> </c:if>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center"><strong><span class="bgDescTablas" style="height: 85px;"><strong>Observaciones</strong></span></strong></p>
      <p align="center"><span class="sinBgDescTablas" style="height: 85px;">
        <textarea cols="75" rows="3" name="nutrobservac" id="nutrobservac" onkeypress="javascript:return permite(event, 'com')">${nutrobservac}</textarea>
      </span></p></td>
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
        url = url + "campo=nutrarchivo";
        
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
        llaves = 'nutridregist='+document.getElementById('nutridregist').value;
        validarLlave('nutricionvaloracion',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=nutricionvaloracion&";
        url = url + "campos=nutridregist,codtipoidentidad,nutridentifi,nutrcantidad,nutrfechatennutrfechaten,codfinalidadconsulta,coddiagnosticopr,coddiagnosticosa&";
        url = url + "campoLlave=nutridregist";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>