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
        function configurar()
        {
            Calendar.setup({inputField : "fecha",ifFormat : "%d/%m/%Y",button : "botonFecha"});
        }
		   
		    //totalidad de elementos en el form
            var cajas = new Array('nroliquidacion','nroalterno','saldocontrato','fecha','nota','observacionsaldo');
            var combos = new Array('numeroacta');
                      
            //validar
            var arrayNonulos               = new Array('nroliquidacion');
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('numeroacta');
            var arrayCadenasANCod          = new Array('nroliquidacion','nroalterno');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('nota','observacionsaldo');
            var arrayNumerosDoubles        = new Array('saldocontrato');
            
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
            <sql:query var="r" sql="SELECT * FROM liquidacioncto WHERE nroliquidacion='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="nroliquidacion" value="${fila.nroliquidacion}"/>
              <c:set var="codtipoactacontrato" value="${fila.codtipoactacontrato}"/>
              <c:set var="codregimenes" value="${fila.codregimenes}"/>
              <c:set var="codentidadsalud" value="${fila.codentidadsalud}"/>
              <c:set var="codcontrato" value="${fila.codcontrato}"/>              
              <c:set var="numeroacta" value="${fila.numeroacta}"/>
              <fmt:formatDate value="${fila.fecha}" pattern="dd/MM/yyyy" var="fecha"/>  
              <c:set var="nota" value="${fila.nota}"/>
              <c:set var="nroalterno" value="${fila.nroalterno}"/>
              <c:set var="saldocontrato" value="${fila.saldocontrato}"/>
              <c:set var="observacionsaldo" value="${fila.observacionsaldo}"/>
            </jsp2:forEach>
                
                <table width="741" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="Liquidacion.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Liquidacion</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="115" class="bgDescTablas"><strong class="bgDescTablas">Acta Contrato</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><select name="numeroacta" id="numeroacta" style="width: 150px">
                      <option id="numeroacta" value=""></option>
                      <sql:query var="r" sql="select codtipoactacontrato, codcontrato, codregimenes, codentidadsalud, numeroacta from actacontrato" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codtipoactacontrato == codtipoactacontrato && fila.codregimenes == codregimenes && fila.codentidadsalud == codentidadsalud && fila.codcontrato == codcontrato && fila.numeroacta == numeroacta}'>
                            <option value="${fila.codtipoactacontrato} ${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.numeroacta}" selected="selected">${fila.numeroacta}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codtipoactacontrato} ${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.numeroacta}">${fila.numeroacta}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro. Liquidaci&oacute;n</strong></td>
                    <td width="167" class="sinBgDescTablas"><label>
                      <input name="nroliquidacion" type="text" id="nroliquidacion" value="${nroliquidacion}" size="20" maxlength="20" />
                    </label></td>
                    <td width="35">&nbsp;</td>
                    <td width="115" class="bgDescTablas"><strong>Nro. Alterno </strong></td>
                    <td width="180" class="sinBgDescTablas"><label>
                      <input name="nroalterno" type="text" id="nroalterno" value="${nroalterno}" size="20" maxlength="20" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Saldo Contrato</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="saldocontrato" type="text" id="saldocontrato" value="${saldocontrato}" size="20" maxlength="15" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Fecha</strong></p></td>
                    <td class="sinBgDescTablas">
                    <p>
                      <input name="fecha" type="text" id="fecha" value="${fecha}" size="15" readonly="true" />
                      <input name="button" type="button" id="botonFecha" value="..." />
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Notas de Liquidaci&oacute;n</strong></p>
                    <p align="center"><strong>
                      <label>
                      <textarea name="nota" cols="75" rows="3" id="nota">${nota}</textarea>
                      </label>
                    </strong></p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas"> 
                        <textarea name="observacionsaldo" cols="75" rows="3" id="observacionsaldo">${observacionsaldo}</textarea>
                      </p></td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
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
    //funciones control
    configurar();
	
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
        llaves = 'nroliquidacion='+document.getElementById('nroliquidacion').value;
        validarLlave('liquidacioncto',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=liquidacioncto&";
        url = url + "campos=nroliquidacion,codtipoactacontrato,codregimenes,codentidadsalud,codcontrato,numeroacta,fecha,nroalterno&";
        url = url + "campoLlave=nroliquidacion";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>