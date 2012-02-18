<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
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
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>

        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('conconcodigo','concondescripci','conconinicial','conconactual','conconincremento');
            var combos = new Array('estconcodigo');
            
            //validar
            var arrayNonulos               	= new Array('conconcodigo');
            var arrayNumerosEnteros        	= new Array('conconinicial','conconactual','conconincremento');
            var arrayCombos               	= new Array('estconcodigo');
            var arrayCadenasANCod          	= new Array('conconcodigo');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('concondescripci');
            var arrayNumerosDoubles         = null;
            	
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
    <td width="234" height="529" valign="top" style="background: url('../images/back.png')">
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM controlconsecutivo WHERE conconcodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="conconcodigo" value="${fila.conconcodigo}"/>
              <c:set var="concondescripci" value="${fila.concondescripci}"/>
              <c:set var="conconinicial" value="${fila.conconinicial}"/>
              <c:set var="conconactual" value="${fila.conconactual}"/>
              <c:set var="conconincremento" value="${fila.conconincremento}"/>
              <c:set var="estconcodigo" value="${fila.estconcodigo}"/>
           
            </jsp2:forEach>
            <table width="811" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="ControlConsecutivo.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Control Consecutivo</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30" class="bgDescTablas">&nbsp;</td>
                <td width="139" class="bgDescTablas"><strong>C&oacute;digo Control Consecutivo</strong></td>
                <td colspan="4"><label>
                  <input name="conconcodigo" type="text" id="conconcodigo" value="${conconcodigo}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="1">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Valor Inicial Consecutivo</strong></span></td>
                <td width="190"><label>
                  <input name="conconinicial" type="text" id="conconinicial" value="${conconinicial}" size="20" maxlength="9" onKeyPress="javascript:return permite(event, 'nume')" tabindex="2">
                </label></td>
                <td width="11">&nbsp;</td>
                <td width="132"><span class="bgDescTablas"><strong>Valor Actual Consecutivo</strong></span></td>
                <td width="174"><span class="sinBgDescTablas">
                </span>
                  <label>
                  <input name="conconactual" type="text" id="conconactual" value="${conconactual}" size="20" maxlength="9" onKeyPress="javascript:return permite(event, 'nume')" tabindex="3">
                  </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Incremento Consecutivo</strong></td>
                <td><label>
                  <input name="conconincremento" type="text" id="conconincremento" value="${conconincremento}" size="20" maxlength="5" onKeyPress="javascript:return permite(event, 'nume')" tabindex="4">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Estado Consecutivo</strong></td>
                <td><label>
                  <select name="estconcodigo" id="estconcodigo" style="width: 150px" tabindex="5">
                  <option id="estconcodigo" value=""></option>
                  <sql:query var="r" sql="select estconcodigo, estcondescrpci from estadoconsecutivo" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.estconcodigo == estconcodigo}'>
                        <option value="${fila.estconcodigo}" selected="selected">${fila.estcondescrpci}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.estconcodigo}">${fila.estcondescrpci}</option>
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
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Descripci&oacute;n</strong></p>
                <p align="center"><strong>
                  <label>
                  <input name="concondescripci" type="text" id="concondescripci" value="${concondescripci}" size="75" maxlength="80" onKeyPress="javascript:return permite(event, 'com')" tabindex="6">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="10"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="7"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="8"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="9"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
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
        llaves = 'conconcodigo='+document.getElementById('conconcodigo').value;
        validarLlave('controlconsecutivo',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=controlconsecutivo&";
        url = url + "campos=conconcodigo,concondescripci,conconinicial,conconactual,conconincremento,estconcodigo&";
        url = url + "campoLlave=conconcodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>