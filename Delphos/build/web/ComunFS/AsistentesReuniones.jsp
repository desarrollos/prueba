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
            var cajas = new Array('externidenti','exterobserv');
            var combos = new Array('encuencodigo','codtipoidentidad','tipasicodigo');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('encuencodigo','codtipoidentidad','tipasicodigo');
            var arrayCadenasANCod          	= new Array('externidenti','exterobserv');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
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
            <c:if test="${param.encuencodigo != null && param.codtipoidentidad != null && param.externidenti != null}">
            <sql:query var="r" sql="SELECT * FROM encuenasistenteexterno WHERE encuencodigo='${param.encuencodigo}' AND codtipoidentidad='${param.codtipoidentidad}' AND externidenti='${param.externidenti}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="encuencodigo" value="${fila.encuencodigo}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="externidenti" value="${fila.externidenti}"/>
              <c:set var="asiextnombre" value="${fila.asiextnombre}"/>
              <c:set var="asiextapellido" value="${fila.asiextapellido}"/>              
              <c:set var="tipasicodigo" value="${fila.tipasicodigo}"/>
              <c:set var="exterobserv" value="${fila.exterobserv}"/>
            </jsp2:forEach>

            
          <form name="formulario" method="post" action="AsistentesReuniones.jsp">
          <table width="826" border="0" class="tablaContenido">
			
              <tr>
                <td colspan="6"><div align="center"><span class="titulo1">Asistentes Reuniones</span></div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="154"><span class="bgDescTablas"><strong>C&oacute;digo</strong></span></td>
                <td colspan="4"><strong>
                  <select name="encuencodigo" id="encuencodigo" style="width: 150px">
                    <option id="encuencodigo" value=""></option>
                    <sql:query var="r" sql="select encuencodigo from encuentroreunion" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.encuencodigo == encuencodigo}'>
                          <option value="${fila.encuencodigo}" selected="selected">${fila.encuencodigo}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.encuencodigo}">${fila.encuencodigo}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </strong></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Tipo Id.</strong></span></td>
                <td width="162"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoidentidad" id="codtipoidentidadex" style="width: 150px">
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
                <td width="19">&nbsp;</td>
                <td width="113"><span class="bgDescTablas" style="width: 10%"><strong>Nro. Identificaci&oacute;n</strong></span></td>
                <td width="198"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="externidenti" type="text" id="externidenti" value="${externidenti}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Nombres</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input type="text" name="asiextnombre" id="asiextnombre" readonly="true" onkeypress="javascript:return permite(event, 'carac')"/>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 10%"><strong>Apellidos</strong></span></td>
                <td class="sinBgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <input type="text" name="asiextapellido" id="asiextapellido" readonly="true" onkeypress="javascript:return permite(event, 'carac')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tipo Asistente</strong></td>
                <td colspan="4" class="sinBgDescTablas"><label>
                  <select name="tipasicodigo" id="tipasicodigo" style="width: 150px">
                    <option id="tipasicodigo" value=""></option>
                    <sql:query var="r" sql="select tipasicodigo, tipasidescri from tipoasistente" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.tipasicodigo == tipasicodigo}'>
                          <option value="${fila.tipasicodigo}" selected="selected">${fila.tipasidescri}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.tipasicodigo}">${fila.tipasidescri}</option>
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
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaci&oacute;n</strong></p>
                <p align="center">
                  <label>
                  <textarea name="exterobserv" cols="75" rows="3" id="exterobserv" onkeypress="javascript:return permite(event, 'com')">${exterobserv}</textarea>
                  </label>
                </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="encuencodigo" id="encuencodigo" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="externidenti" id="externidenti" value="" >
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
</tr>>
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
        llaves = 'encuencodigo='+document.getElementById('encuencodigo').value+',';
        llaves+= 'codtipoidentidad='+document.getElementById('codtipoidentidad').value+',';
        llaves+= 'externidenti='+document.getElementById('externidenti').value;
        validarLlave('encuenasistenteexterno',llaves);
    }
        
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=encuenasistenteexterno&";
        url = url + "campos=encuencodigo,codtipoidentidad,externidenti,asiextnombre,asiextapellido,tipasicodigo&";
        url = url + "campoLlave=encuencodigo,codtipoidentidad,externidenti";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>