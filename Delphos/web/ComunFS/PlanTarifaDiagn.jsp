<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
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
            var cajas = new Array('porcplan','valordiagnostico');
            var combos = new Array('codtipoplantarifas','coddiagnosticos');
		
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('coddiagnosticos','codtipoplantarifas');			
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= new Array('valordiagnostico');
            
            var arrayPorcentajes        	= new Array('porcplan');
            var arrayDirecciones        	= null;
            var arrayCorreos                    = null;

	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[1]);">
<!-- ImageReady Slices (panel.psd) -->

<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
</tr>
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <c:if test='${param.codtipoplantarifa != null && param.codmanualdiagnostico != null && param.coddiagnostico != null && param.anyoliquidacion != null && param.mesinivigencia != null && param.anyoliquidacion != "" && param.mesinivigencia != ""}'>
            <sql:query var="r" sql="SELECT * FROM plantarifadiagn WHERE codtipoplantarifa='${param.codtipoplantarifa}' AND codmanualdiagnostico='${param.codmanualdiagnostico}' AND anyoliquidacion=${param.anyoliquidacion} AND mesinivigencia=${param.mesinivigencia}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoplantarifaf" value="${fila.codtipoplantarifa}"/> 
              <c:set var="codmanualdiagnosticof" value="${fila.codmanualdiagnostico}"/> 
              <c:set var="coddiagnosticof" value="${fila.coddiagnostico}"/> 
              <c:set var="anyoliquidacionf" value="${fila.anyoliquidacion}"/> 
              <c:set var="mesinivigenciaf" value="${fila.mesinivigencia}"/> 
              <c:set var="porcplan" value="${fila.porcplan}"/>  
              <c:set var="valordiagnostico" value="${fila.valordiagnostico}"/>
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="PlanTarifaDiagn.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Plan Tarifa Diagn&oacute;stico </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="119" class="bgDescTablas"><strong>Manual Diagn&oacute;stico </strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="coddiagnosticos" id="coddiagnosticos" style="width: 150px" tabindex="1">
                          <option id="coddiagnosticos" value=""></option>
                              <sql:query var="r" sql="select codmanualdiagnostico, coddiagnostico, anyoliquidacion, mesinivigencia from manualliqudiagn" dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.coddiagnostico == coddiagnosticof && fila.codmanualdiagnostico == codmanualdiagnosticof && fila.anyoliquidacion == anyoliquidacionf && fila.mesinivigencia == mesinivigenciaf}'>
                                        <option value="${fila.codmanualdiagnostico} ${fila.coddiagnostico} ${fila.anyoliquidacion} ${fila.mesinivigencia}" selected="selected">${fila.codmanualdiagnostico}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${fila.codmanualdiagnostico} ${fila.coddiagnostico} ${fila.anyoliquidacion} ${fila.mesinivigencia}">${fila.codmanualdiagnostico}</option>
                                    </c:otherwise>
                               </c:choose>
                             </jsp2:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Plan Tarifa </strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codtipoplantarifas" id="codtipoplantarifas" style="width: 150px" tabindex="2">
                        <option id="codtipoplantarifas" value=""></option>
                        <sql:query var="r" sql="select codtipoplantarifa, descripcion from tipoplantarifa" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codtipoplantarifa == codtipoplantarifaf}'>
                              <option value="${fila.codtipoplantarifa}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codtipoplantarifa}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Porcentaje Plan </strong></td>
                    <td width="174" class="bgDescTablas"><label>
                      <input name="porcplan" type="text" id="porcplan" value="${porcplan}" size="20" maxlength="8" onkeypress="javascript:return permite(event, 'numd')"tabindex="3"/>
                    </label></td>
                    <td width="23" class="bgDescTablas">&nbsp;</td>
                    <td width="94" class="bgDescTablas"><strong>Valor Diagn&oacute;stico</strong></td>
                    <td width="236" class="bgDescTablas"><input name="valordiagnostico" type="text" id="valordiagnostico" value="${valordiagnostico}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="4"/></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoplantarifa" id="codtipoplantarifa" value="" >
                  <input type="hidden" name="codmanualdiagnostico" id="codmanualdiagnostico" value="" >
                  <input type="hidden" name="coddiagnostico" id="coddiagnostico" value="" >
                  <input type="hidden" name="anyoliquidacion" id="anyoliquidacion" value="" >
                  <input type="hidden" name="mesinivigencia" id="mesinivigencia" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="8">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="5"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="6"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="7"/>-->
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
        <jsp:include page="../footer.jsp" />
	</td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    //funciones control
    function accion(x)
    {        
        if(validar2(arrayNonulos, arrayNumerosEnteros, arrayCombos, arrayCadenasANCod, arrayCadenasA, arrayComentarios, arrayNumerosDoubles, arrayPorcentajes, arrayDirecciones, arrayCorreos))
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
        var cad = document.getElementById('coddiagnosticos').value;
        
        var cad2 = cad.split(" ");
        
        llaves = 'codtipoplantarifa='+document.getElementById('codtipoplantarifas').value+',';
        llaves+= 'codmanualdiagnostico='+cad2[0]+',';
        llaves+= 'coddiagnostico='+cad2[1]+',';
        llaves+= 'anyoliquidacion='+cad2[2]+',';
        llaves+= 'mesinivigencia='+cad2[3];
              
        validarLlave('plantarifadiagn',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=plantarifadiagn&";
        url = url + "campos=codtipoplantarifa,codmanualdiagnostico,coddiagnostico,anyoliquidacion,mesinivigencia,porcplan,valordiagnostico&";
        url = url + "campoLlave=codtipoplantarifa,codmanualdiagnostico,coddiagnostico,anyoliquidacion,mesinivigencia";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>