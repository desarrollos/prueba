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
           
            //totalidad de elementos en el form
            var cajas = new Array('idenperdoc','archidocum','descripcion');
            var combos = new Array('codunifami','codtipodctoasociado','codtipoidentidad');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codunifami','codtipodctoasociado','codtipoidentidad');
            var arrayCadenasANCod          	= new Array('idenperdoc');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('archidocum','descripcion');
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
            <c:if test="${param.codunifami != null && param.codtipodctoasociado != null}">
            <sql:query var="r" sql="SELECT * FROM documentoinscripcion WHERE codunifami='${param.codunifami}' AND codtipodctoasociado='${param.codtipodctoasociado}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="codtipodctoasociadof" value="${fila.codtipodctoasociado}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="idenperdoc" value="${fila.idenperdoc}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="archidocum" value="${fila.archidocum}"/>    
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(documentoinscripcion.archivofi, '${ruta}${archidocum}') from documentoinscripcion WHERE codunifami='${param.codunifami}' AND codtipodctoasociado='${param.codtipodctoasociado}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                
            </jsp2:forEach>
    
<form name="formulario" method="post" action="DocumentosInscripcion.jsp">
<span id="mensajeControlador">${msj}</span>
<table width="830" border="0" class="tablaContenido">

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Documentos Inscripcion</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="26">&nbsp;</td>
    <td width="144"><span class="bgDescTablas" style="width: 20%"><strong>C&oacute;digo &Uacute;nico Familia</strong></span></td>
    <td width="155"><label>
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
    <td width="16">&nbsp;</td>
    <td width="113"><span class="bgDescTablas" style="width: 20%"><strong>Tipo Documento Asociado </strong></span></td>
    <td width="188"><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipodctoasociados" id="codtipodctoasociados" style="width: 150px">
           <option id="codtipodctoasociados" value=""></option>
          <sql:query var="r" sql="select codtipodctoasociado, descripcion from tipodctoasociado" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipodctoasociado == codtipodctoasociadof}'>
                <option value="${fila.codtipodctoasociado}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipodctoasociado}">${fila.descripcion}</option>
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
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidad" id="codtipoidentidad" style="width: 150px">
          <option id="tipoidentificacion_codtipoidentidad" value=""></option>
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
      <input name="idenperdoc" type="text" id="idenperdoc" value="${idenperdoc}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Archivo Documento</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
      <input name="archidocum" type="text" id="archidocum" size="15"  value="${archidocum}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${archidocum != null && archidocum != ""}'><br />
        <a href="../temp/${archidocum}" target="_blank">Descargar ${archidocum}</a> </c:if>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
      <p align="center"><strong>
        <textarea cols="75" rows="3" name="descripcion" id="descripcion" onkeypress="javascript:return permite(event, 'com')">${descripcion}</textarea>
        </strong></p></td>
  </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="codtipodctoasociado" id="codtipodctoasociado" value="" >
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
        url = url + "campo=archidocum";
        
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
        llaves+= 'codtipodctoasociado='+document.getElementById('codtipodctoasociados').value;
        validarLlave('documentoinscripcion',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=documentoinscripcion&";
        url = url + "campos=codunifami,codtipodctoasociado,codtipoidentidad,idenperdoc,descripcion,archidocum&";
        url = url + "campoLlave=codunifami,codtipodctoasociado";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>