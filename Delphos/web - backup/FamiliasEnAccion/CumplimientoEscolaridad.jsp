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
           
            //totalidad de elementos en el form
            var cajas = new Array('esccumobserv');
            var combos = new Array('escidentifics','reqtipcodigos','codestcumplimiento');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('escidentifics','reqtipcodigos');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('esccumobserv');
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
            <c:if test='${param.codtipoidentidadins != null && param.codempresa != null && param.codtipoidentidad != null && param.escidentific != null && param.escvigencia != null && param.espefechinic != null && param.espefechfina != null && param.codtiporequisito != null && param.coditipben != null && param.codactividadsalud != null && param.escvigencia != "" && param.codactividadsalud != "" && param.espefechinic != "" && param.espefechfina != ""}'>
            <sql:query var="r" sql="SELECT * FROM escolaridadcumplimiento WHERE codtipoidentidadins='${param.codtipoidentidadins}' AND codempresa='${param.codempresa}' AND codtipoidentidad='${param.codtipoidentidad}' AND escidentific='${param.escidentific}' AND escvigencia=${param.escvigencia} AND espefechinic='${param.espefechinic}' AND espefechfina='${param.espefechfina}' AND codtiporequisito='${param.codtiporequisito}' AND coditipben='${param.coditipben}' AND codactividadsalud=${param.codactividadsalud}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadinsf" value="${fila.codtipoidentidadins}"/>
              <c:set var="codempresaf" value="${fila.codempresa}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="escidentificf" value="${fila.escidentific}"/>
              <c:set var="escvigenciaf" value="${fila.escvigencia}"/>
              <c:set var="espefechinicf" value="${fila.espefechinic}"/>
              <c:set var="espefechfinaf" value="${fila.espefechfina}"/>
              <c:set var="codtiporequisitof" value="${fila.codtiporequisito}"/> 
              <c:set var="coditipbenf" value="${fila.coditipben}"/>
              <c:set var="codactividadsaludf" value="${fila.codactividadsalud}"/>
              <c:set var="codestcumplimiento" value="${fila.codestcumplimiento}"/>
              <c:set var="esccumobserv" value="${fila.esccumobserv}"/> 
            </jsp2:forEach>
    
<form name="formulario" method="post" action="CumplimientoEscolaridad.jsp">

<table width="811" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Cumplimiento Escolaridad</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="115"><strong class="bgDescTablas">Estudiante</strong></td>
    <td colspan="4"><select name="escidentifics" id="escidentifics" style="width: 150px">
             <option id="escidentifics" value=""></option>
          <sql:query var="r" sql="select codtipoidentidadins, codempresa, codtipoidentidad, escidentific, escvigencia, espefechinic, espefechfina from escregperiodico" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidadins == codtipoidentidadinsf && fila.codempresa == codempresaf && fila.codtipoidentidad == codtipoidentidadf && fila.escidentific == escidentificf && fila.escvigencia == escvigenciaf && fila.espefechinic == espefechinicf && fila.espefechfina == espefechfinaf}'>
                <option value="${fila.codtipoidentidadins} ${fila.codempresa} ${fila.codtipoidentidad} ${fila.escidentific} ${fila.escvigencia} ${fila.espefechinic} ${fila.espefechfina}" selected="selected">${fila.escidentific}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoidentidadins} ${fila.codempresa} ${fila.codtipoidentidad} ${fila.escidentific} ${fila.escvigencia} ${fila.espefechinic} ${fila.espefechfina}">${fila.escidentific}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
         </select></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 13%"><strong>Requisito</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 17%">
      <select name="reqtipcodigos" id="reqtipcodigos" style="width: 150px">
           <option id="reqtipcodigos" value=""></option>
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
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center" class="tablaContenido"> 
        <textarea cols="75" rows="3" name="esccumobserv" id="esccumobserv" onkeypress="javascript:return permite(event, 'com')">${esccumobserv}</textarea>
        </p></td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidadins" id="codtipoidentidadins" value="">
                  <input type="hidden" name="codempresa" id="codempresa" value="">
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="">
                  <input type="hidden" name="escidentific" id="escidentific" value="">
                  <input type="hidden" name="escvigencia" id="escvigencia" value="">
                  <input type="hidden" name="espefechinic" id="espefechinic" value="">
                  <input type="hidden" name="espefechfina" id="espefechfina" value="">
                  <input type="hidden" name="codtiporequisito" id="codtiporequisito" value="">
                  <input type="hidden" name="coditipben" id="coditipben" value="">
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="">
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17">
		  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
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
        var cad = document.getElementById('escidentifics').value;
        var cad2 = cad.split(" ");
		
	var cad1 = document.getElementById('reqtipcodigos').value;
        var cad3 = cad.split(" ");
        
        llaves = 'codtipoidentidadins='+cad2[0]+',';
	llaves+= 'codempresa='+cad2[1]+',';
        llaves+= 'codtipoidentidad='+cad2[2]+',';
        llaves+= 'escidentific='+cad2[3]+',';
	llaves+= 'escvigencia='+cad2[4]+',';
	llaves+= 'espefechinic='+cad2[5]+',';
	llaves+= 'espefechfina='+cad2[6]+',';
	llaves+= 'codempresa='+cad3[0]+',';
        llaves+= 'codtipoidentidad='+cad3[1]+',';
        llaves+= 'escidentific='+cad3[2];
        validarLlave('escolaridadcumplimiento',llaves);
		
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=escolaridadcumplimiento&";
        url = url + "campos=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,espefechinic,espefechfina,codtiporequisito&";
        url = url + "campoLlave=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,espefechinic,espefechfina,codtiporequisito,coditipben,codactividadsalud";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>