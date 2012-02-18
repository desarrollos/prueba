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
            var cajas = new Array('observacion');
            var combos = new Array('codclagrutits','identitfams');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codclagrutits','identitfams');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion');
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
            <c:if test="${param.codclagrutit != null && param.codunifami != null && param.codtipoidentidad != null && param.identitfam != null}">
            <sql:query var="r" sql="SELECT * FROM grupotitular WHERE codclagrutit='${param.codclagrutit}' AND codunifami='${param.codunifami}' AND codtipoidentidad='${param.codtipoidentidad}' AND identitfam='${param.identitfam}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codclagrutitf" value="${fila.codclagrutit}"/>
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="identitfamf" value="${fila.identitfam}"/>
              <c:set var="observacion" value="${fila.observacion}"/>       
            </jsp2:forEach>
    
<form name="formulario" method="post" action="GrupoTitular.jsp">
<span id="mensajeControlador">${msj}</span>
<table width="850" border="0" class="tablaContenido">
  <tr>
    <td colspan="6"><div align="center" class="titulo1">Grupos Titulares </div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="178"><strong class="bgDescTablas">Clase Grupo Titular</strong></td>
    <td colspan="4"><label>
      <select name="codclagrutits" id="codclagrutits" style="width: 150px">
          <option id="codclagrutits" value=""></option>
          <sql:query var="r" sql="select codclagrutit, descclagrutit from clasegrupotitular" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codclagrutit == codclagrutitf}'>
                <option value="${fila.codclagrutit}" selected="selected">${fila.descclagrutit}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codclagrutit}">${fila.descclagrutit}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </label>
      <label></label></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 13%"><strong>Nro. Identificacion Titular</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
      <select name="identitfams" size="1" id="identitfams" style="width: 150px">
           <option id="identitfams" value=""></option>
          <sql:query var="r" sql="select codunifami, codtipoidentidad, identitfam from titularfamilia" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codunifami == codunifamif && fila.codtipoidentidad == codtipoidentidadf && fila.identitfam == identitfamf}'>
                <option value="${fila.codunifami} ${fila.codtipoidentidad} ${fila.identitfam}" selected="selected">${fila.codtipoidentidad}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codunifami} ${fila.codtipoidentidad} ${fila.identitfam}">${fila.codtipoidentidad}</option>
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
    <td class="bgDescTablas"><strong>Nombres</strong></td>
    <td width="171" class="sinBgDescTablas"><label>
      <input type="text" name="nomtfam" id="nomtfam" readonly="true" onkeypress="javascript:return permite(event, 'carac')"/>
    </label></td>
    <td width="12">&nbsp;</td>
    <td width="134" class="bgDescTablas"><strong>Apellidos</strong></td>
    <td width="151" class="sinBgDescTablas"><label>
      <input type="text" name="apetfam" id="apetfam" readonly="true" onkeypress="javascript:return permite(event, 'carac')"/>
    </label></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Direccion</strong></td>
    <td class="sinBgDescTablas"><label>
      <input type="text" name="dirtfam" id="dirtfam" readonly="true"/>
    </label></td>
    <td>&nbsp;</td>
    <td class="bgDescTablas"><strong>Telefono</strong></td>
    <td class="sinBgDescTablas"><label>
      <input type="text" name="teltfam" id="teltfam" readonly="true" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </label></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center"><strong><span class="bgDescTablas"><strong>Observaciones</strong></span></strong></p>
      <p align="center">
        <textarea cols="75" rows="3" name="observacion" id="observacion" onkeypress="javascript:return permite(event, 'com')">${observacion}</textarea>
      </p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codclagrutit" id="codclagrutit" value="" >
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="identitfam" id="identitfam" value="" >
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
        var cad = document.getElementById('identitfams').value;
        var cad2 = cad.split(" ");
				
		llaves = 'codclagrutit='+document.getElementById('codclagrutits').value+',';
		llaves = 'codunifami='+cad2[0]+',';
		llaves+= 'codtipoidentidad='+cad2[1]+',';
		llaves+= 'identitfam='+cad2[2];
        validarLlave('grupotitular',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=grupotitular&";
        url = url + "campos=codclagrutit,codunifami,codtipoidentidad,identitfam,observacion&";
        url = url + "campoLlave=codclagrutit,codunifami,codtipoidentidad,identitfam";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>