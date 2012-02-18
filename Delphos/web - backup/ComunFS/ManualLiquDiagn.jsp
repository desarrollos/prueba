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
            var cajas = new Array('anyoliquidacions','valordiagnostico');
            var combos = new Array('codmanualdiagnosticos','coddiagnosticos','mesinivigencias','mesfinvigencia');
			
            var arrayNonulos               	= new Array('anyoliquidacions');
            var arrayNumerosEnteros        	= new Array('anyoliquidacions');
            var arrayCombos               	= new Array('codmanualdiagnosticos','coddiagnosticos','mesinivigencias','mesfinvigencia');			
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= new Array('valordiagnostico');

	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[0]);">
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
            <c:if test='${param.codmanualdiagnostico != null && param.coddiagnostico != null && param.anyoliquidacion != null && param.mesinivigencia != null && param.mesinivigencia != "" && param.anyoliquidacion != ""}'>
            <sql:query var="r" sql="SELECT * FROM manualliqudiagn WHERE codmanualdiagnostico='${param.codmanualdiagnostico}' AND coddiagnostico='${param.coddiagnostico}' AND anyoliquidacion=${param.anyoliquidacion} AND mesinivigencia=${param.mesinivigencia}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codmanualdiagnosticof" value="${fila.codmanualdiagnostico}"/> 
              <c:set var="coddiagnosticof" value="${fila.coddiagnostico}"/> 
              <c:set var="anyoliquidacionf" value="${fila.anyoliquidacion}"/>  
              <c:set var="mesinivigenciaf" value="${fila.mesinivigencia}"/>  
              <c:set var="mesfinvigencia" value="${fila.mesfinvigencia}"/>  
              <c:set var="aplicauvr" value="${fila.aplicauvr}"/>  
              <c:set var="valordiagnostico" value="${fila.valordiagnostico}"/>    
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="ManualLiquDiagn.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Detalles Diagn&oacute;sticos Por Metodolog&iacute;a </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="21" class="bgDescTablas">&nbsp;</td>
                    <td width="121" class="bgDescTablas"><strong>Manual Diagn&oacute;stico </strong></td>
                    <td width="161" class="bgDescTablas"><label>
                      <select name="codmanualdiagnosticos" id="codmanualdiagnosticos" style="width: 150px" tabindex="1">
                          <option id="codmanualdiagnosticos" value=""></option>
                              <sql:query var="r" sql="select codmanualdiagnostico, descripcion from manualdiagnostico" dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codmanualdiagnostico == codmanualdiagnosticof}'>
                                        <option value="${fila.codmanualdiagnostico}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${fila.codmanualdiagnostico}">${fila.descripcion}</option>
                                    </c:otherwise>
                               </c:choose>
                             </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="17" class="bgDescTablas">&nbsp;</td>
                    <td width="109" class="bgDescTablas"><strong>Diagn&oacute;stico</strong></td>
                    <td width="213" class="bgDescTablas"><label>
                      <select name="coddiagnosticos" id="coddiagnosticos" style="width: 150px" tabindex="2">
                          <option id="coddiagnosticos" value=""></option>
                          <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                        <c:when test='${fila.coddiagnostico == coddiagnosticof}'>
                                        <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                                        </c:when>
                                <c:otherwise>
                                        <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Mes Vigencia Inicial </strong></td>
                    <td class="bgDescTablas"><label>
                    <select name="mesinivigencias" id="mesinivigencias" style="width: 150px" tabindex="3">
                      <option id="mesinivigencias" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesinivigenciaf}">
                                            <option value="0${mesinivigenciaf}" selected>0${mesinivigenciaf}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesinivigenciaf}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                    </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Mes Vigencia Final </strong></td>
                    <td class="bgDescTablas"><label>
                    <select name="mesfinvigencia" id="mesfinvigencia" style="width: 150px" tabindex="4">
                      <option id="mesfinvigencia" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesfinvigencia}">
                                            <option value="0${mesfinvigencia}" selected>0${mesfinvigencia}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesfinvigencia}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>A&ntilde;o Liquidaci&oacute;n </strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="anyoliquidacions" type="text" id="anyoliquidacions" value="${anyoliquidacionf}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica UVR </strong></td>
                    <td class="bgDescTablas">
                          <c:choose>
                            <c:when test = '${aplicauvr == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicauvr" value="S" id="aplicauvr_0" checked="true" tabindex="6"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicauvr" value="N" id="aplicauvr_1" tabindex="6"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicauvr" value="S" id="aplicauvr_0" tabindex="6"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicauvr" value="N" id="aplicauvr_1" checked="true" tabindex="6"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>                        </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Diagn&oacute;stico</strong></td>
                    <td colspan="4" class="bgDescTablas">
                        <input name="valordiagnostico" type="text" id="valordiagnostico" value="${valordiagnostico}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="7"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codmanualdiagnostico" id="codmanualdiagnostico" value="" >
                  <input type="hidden" name="coddiagnostico" id="coddiagnostico" value="" >
                  <input type="hidden" name="anyoliquidacion" id="anyoliquidacion" value="" >
                  <input type="hidden" name="mesinivigencia" id="mesinivigencia" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="11">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="8"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="9"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="10"/>-->
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
        llaves = 'codmanualdiagnostico='+document.getElementById('codmanualdiagnosticos').value+',';
        llaves+= 'coddiagnostico='+document.getElementById('coddiagnosticos').value+',';
        llaves+= 'anyoliquidacion='+document.getElementById('anyoliquidacions').value+',';
        llaves+= 'mesinivigencia='+document.getElementById('mesinivigencias').value;
        validarLlave('manualliqudiagn',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=manualliqudiagn&";
        url = url + "campos=codmanualdiagnostico,coddiagnostico,anyoliquidacion,mesinivigencia,mesfinvigencia,aplicauvr,valordiagnostico&";
        url = url + "campoLlave=codmanualdiagnostico,coddiagnostico,anyoliquidacion,mesinivigencia";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>