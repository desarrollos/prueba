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
		Calendar.setup({inputField : "novefechsoli",ifFormat : "%d/%m/%Y",button : "botonnovefechsoli"});
		Calendar.setup({inputField : "novefechnove",ifFormat : "%d/%m/%Y",button : "botonnovefechnove"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('noveconsecut','noveidentifi','novefechsoli','novefechnove','novearchivo','noveobservac');
            var combos = new Array('codunifami','codtipoidentidad','novcaucodigo','tippercodigo');
			
            var arrayNonulos               	= new Array('noveconsecut','novefechsoli','novefechnove');
            var arrayNumerosEnteros        	= new Array('noveconsecut');
            var arrayCombos               	= new Array('codunifami','codtipoidentidad','novcaucodigo','tippercodigo');
            var arrayCadenasANCod          	= new Array('noveidentifi');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('novearchivo','noveobservac');
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
            <sql:query var="r" sql="SELECT * FROM novedad WHERE noveconsecut=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="noveconsecut" value="${fila.noveconsecut}"/>
              <c:set var="codunifami" value="${fila.codunifami}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="noveidentifi" value="${fila.noveidentifi}"/>
              <c:set var="codtiponovedad" value="${fila.codtiponovedad}"/>
              <c:set var="novcaucodigo" value="${fila.novcaucodigo}"/>
              <fmt:formatDate value="${fila.novefechsoli}" pattern="dd/MM/yyyy" var="novefechsoli"/>
              <fmt:formatDate value="${fila.novefechnove}" pattern="dd/MM/yyyy" var="novefechnove"/>
              
              <c:set var="tippercodigo" value="${fila.tippercodigo}"/>
              <c:set var="novearchivo" value="${fila.novearchivo}"/>
              <c:set var="noveobservac" value="${fila.noveobservac}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(novedad.archivofi, '${ruta}${novearchivo}') from novedad WHERE noveconsecut=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
    
<form name="formulario" method="post" action="RegistroNovedad.jsp">
<span id="mensajeControlador">${msj}</span>
<table width="839" border="0" class="tablaContenido">

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Registro Novedad</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="154"><span class="bgDescTablas" style="width: 15%"><strong>Consecutivo Novedad</strong></span></td>
    <td width="163"><span class="sinBgDescTablas" style="width: 10%">
      <input name="noveconsecut" type="text" id="noveconsecut" value="${noveconsecut}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
    <td width="10">&nbsp;</td>
    <td width="111"><span class="bgDescTablas" style="width: 15%"><strong>C&oacute;digo &Uacute;nico Familia</strong></span></td>
    <td width="191"><label>
    <select name="codunifami" id="codunifami" style="width: 150px">
      <option id="codunifami" value=""></option>
      <sql:query var="r" sql="select codunifami from inscripcion" dataSource="jdbc/delphos" scope="page"/>
      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <c:choose>
          <c:when test='${fila.codunifami == codunifami}'>
            <option value="${fila.codunifami}" selected="selected">${fila.codunifami}</option>
          </c:when>
          <c:otherwise>
            <option value="${fila.codunifami}">${fila.codunifami}</option>
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
    <td><span class="bgDescTablas" style="width: 15%"><strong>Tipo Id.</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
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
    <td><span class="bgDescTablas" style="width: 20%"><strong> Nro. Identificaci&oacute;n</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 25%">
      <input name="noveidentifi" type="text" id="noveidentifi" value="${noveidentifi}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 10%"><strong>Causal</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 18%">
      <select name="novcaucodigo" id="novcaucodigo" style="width: 150px">
           <option id="novcaucodigo" value=""></option>
          <sql:query var="r" sql="select codtiponovedad, novcaucodigo, novcaudescri from novedadcausal" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtiponovedad == codtiponovedad && fila.novcaucodigo == novcaucodigo}'>
                <option value="${fila.codtiponovedad} ${fila.novcaucodigo}" selected="selected">${fila.novcaudescri}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtiponovedad} ${fila.novcaucodigo}">${fila.novcaudescri}</option>
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
    <td><span class="bgDescTablas" style="width: 10%"><strong>Fecha Solicitud</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 18%">
      <input name="novefechsoli" type="text" id="novefechsoli" value="${novefechsoli}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 18%">
      <input name="button" type="button" id="botonnovefechsoli" value="..." />
      </span></span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 10%"><strong>Fecha Novedad</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 18%">
      <input name="novefechnove" type="text" id="novefechnove" value="${novefechnove}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 18%">
      <input name="button2" type="button" id="botonnovefechnove" value="..." />
      </span></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Persona</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="tippercodigo" id="tippercodigo" style="width: 150px">
           <option id="tippercodigo" value=""></option>
          <sql:query var="r" sql="select tippercodigo, tipperdescri from tipopersona" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.tippercodigo == tippercodigo}'>
                <option value="${fila.tippercodigo}" selected="selected">${fila.tipperdescri}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.tippercodigo}">${fila.tipperdescri}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 10%"><strong>Documento</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="novearchivo" type="text" id="novearchivo" size="15"  value="${novearchivo}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${novearchivo != null && novearchivo != ""}'><br />
        <a href="../temp/${novearchivo}" target="_blank">Descargar ${novearchivo}</a> </c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Aprobaci&oacute;n Novedad</strong></p>
      <p align="center" class="tablaContenido">
        <textarea cols="75" rows="3" name="noveobservac" id="noveobservac" onkeypress="javascript:return permite(event, 'com')">${noveobservac}</textarea>
        </p></td>
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
    <td">
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
        url = url + "campo=novearchivo";
        
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
        llaves = 'noveconsecut='+document.getElementById('noveconsecut').value;
        validarLlave('novedad',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=novedad&";
        url = url + "campos=noveconsecut,codunifami,codtipoidentidad,noveidentifi,codtiponovedad,novcaucodigo,novefechsoli,novefechnove&";
        url = url + "campoLlave=noveconsecut";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>