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
		Calendar.setup({inputField : "fechas",ifFormat : "%d/%m/%Y",button : "botonfecha"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('fechas','datoanterior','datoactualizado','observacion');
            var combos = new Array('idusuarios','codcampoarchivos','codtiponovedads');
			
            var arrayNonulos               	= new Array('fechas');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('idusuarios','codcampoarchivos','codtiponovedads');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('datoanterior','datoactualizado','observacion');
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
    <c:if test='${param.idusuario != null && param.idusuario != "" && param.codtiponovedad != null && param.codcampoarchivo != null && param.codcampoarchivo != "" && param.fecha != null && param.fecha != ""}'>
            <sql:query var="r" sql="SELECT * FROM novedadcampo WHERE idusuario=${param.idusuario} AND codtiponovedad='${param.codtiponovedad}' AND codcampoarchivo=${param.codcampoarchivo} AND fecha='${param.fecha}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idusuarios" value="${fila.idusuario}"/>
              <c:set var="codtiponovedads" value="${fila.codtiponovedad}"/>
              <c:set var="codcampoarchivof" value="${fila.codcampoarchivo}"/>
              <fmt:formatDate value="${fila.fecha}" pattern="dd/MM/yyyy" var="fechaf"/>
              <c:set var="datoanterior" value="${fila.datoanterior}"/>
              <c:set var="datoactualizado" value="${fila.datoactualizado}"/>
              <c:set var="observacion" value="${fila.observacion}"/>             
            </jsp2:forEach>
    
<form name="formulario" method="post" action="NovedadPorCampo.jsp">

<table width="814" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Novedad por Campo</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="111"><span class="bgDescTablas" style="width: 20%"><strong>Id Usuario</strong></span></td>
    <td width="183"><label>
      <select name="idusuarios" id="idusuarios" style="width: 150px">
            <option id="idusuarios" value=""></option>
          <sql:query var="r" sql="select idusuario from poblacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test="${fila.idusuario == idusuarios}">
                <option value="${fila.idusuario}" selected="selected">${fila.idusuario}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.idusuario}">${fila.idusuario}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </label></td>
    <td width="23">&nbsp;</td>
    <td width="119"><span class="bgDescTablas" style="width: 20%"><strong>C&oacute;digo Campo</strong></span></td>
    <td width="191"><span class="sinBgDescTablas" style="width: 20%">
      <select name="codcampoarchivos" id="codcampoarchivos" style="width: 150px">
           <option id="codcampoarchivos" value=""></option>
          <sql:query var="r" sql="select codcampoarchivo, descripcion from listacamposarchivo" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test="${fila.codcampoarchivo == codcampoarchivof}">
                <option value="${fila.codcampoarchivo}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codcampoarchivo}">${fila.descripcion}</option>
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
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Novedad</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtiponovedads" id="codtiponovedads" style="width: 150px">
          <option id="codtiponovedads" value=""></option>
          <sql:query var="r" sql="select codtiponovedad, descripcion from tiponovedad" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test="${fila.codtiponovedad == codtiponovedads}">
                <option value="${fila.codtiponovedad}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtiponovedad}">${fila.descripcion}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Fecha Novedad</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="fechas" type="text" id="fechas" value="${fechaf}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button" type="button" id="botonfecha" value="..." />
      </span></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Dato Anterior</strong></span></td>
    <td><label>
      <textarea name="datoanterior" rows="5" id="datoanterior" onkeypress="javascript:return permite(event, 'com')">${datoanterior}</textarea>
    </label></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Dato Actualizado</strong></span></td>
    <td><label>
      <textarea name="datoactualizado" rows="5" class="sinBgDescTablas" id="datoactualizado" onkeypress="javascript:return permite(event, 'com')">${datoactualizado}</textarea>
    </label></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center" class="tablaContenido">
        <textarea cols="75" rows="3" name="observacion" id="observacion" class="sinBgDescTablas" onkeypress="javascript:return permite(event, 'com')">${observacion}</textarea>
        </p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="idusuario" id="idusuario" value="" >
                  <input type="hidden" name="codtiponovedad" id="codtiponovedad" value="" >
                  <input type="hidden" name="codcampoarchivo" id="codcampoarchivo" value="" >
                  <input type="hidden" name="fecha" id="fecha" value="" >
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
        llaves = 'idusuario='+document.getElementById('idusuarios').value+',';
        llaves+= 'codtiponovedad='+document.getElementById('codtiponovedads').value+',';
        llaves+= 'codcampoarchivo='+document.getElementById('codcampoarchivos').value+',';
        llaves+= 'fecha='+document.getElementById('fechas').value;
        validarLlave('novedadcampo',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=novedadcampo&";
        url = url + "campos=idusuario,codtiponovedad,codcampoarchivo,fecha,datoanterior,datoactualizado&";
        url = url + "campoLlave=idusuario,codtiponovedad,codcampoarchivo,fecha";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>