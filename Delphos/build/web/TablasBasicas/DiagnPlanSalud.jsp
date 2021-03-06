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
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script><script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
<script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('edadinicials','edadfinal','observacion');
            var combos = new Array('codplansaluds','coddiagnosticos','codunidmedidaedadinis','codunidmedidaedadfin');
            
            //validar
            var arrayNonulos               	= new Array('edadinicials');
            var arrayNumerosEnteros        	= new Array('edadinicials','edadfinal');
            var arrayCombos               	= new Array('codplansaluds','coddiagnosticos','codunidmedidaedadinis','codunidmedidaedadfin');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion');
            var arrayNumerosDoubles        	= null;

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
            <c:if test='${param.codplansalud != null && param.coddiagnostico != null && param.codunidmedidaedadini != null && param.edadinicial != null && param.codplansalud != "" && param.edadinicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM diagnplansalud WHERE codplansalud=${param.codplansalud} AND coddiagnostico='${param.coddiagnostico}' AND codunidmedidaedadini='${param.codunidmedidaedadini}' AND edadinicial=${param.edadinicial}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                <c:set var="coddiagnosticof" value="${fila.coddiagnostico}"/>
                <c:set var="codplansaludf" value="${fila.codplansalud}"/>  
                <c:set var="codunidmedidaedadinif" value="${fila.codunidmedidaedadini}"/> 
                <c:set var="edadinicialf" value="${fila.edadinicial}"/>  
                <c:set var="codunidmedidaedadfin" value="${fila.codunidmedidaedadfin}"/>  
                <c:set var="edadfinal" value="${fila.edadfinal}"/>  
                <c:set var="observacion" value="${fila.observacion}"/>  
            </jsp2:forEach>
                
                <table width="776" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="DiagnPlanSalud.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Diagn&oacute;stico Plan Salud </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Diagn&oacute;stico</strong> </td>
                    <td colspan="4" class="bgDescTablas">
                        <select name="coddiagnosticos" id="coddiagnosticos" style="width: 150px" tabindex="1">
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
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Plan Salud </strong></td>
                    <td colspan="4" class="bgDescTablas">
                        <select name="codplansaluds" id="codplansaluds" style="width: 150px" tabindex="2">
                      <option id="codplansaluds" value=""></option>
                      <sql:query var="r" sql="select codplansalud, descripcion from plansalud" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codplansalud == codplansaludf}'>
                            <option value="${fila.codplansalud}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codplansalud}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="104" class="bgDescTablas"><strong>Unidad Medida Inicial </strong></td>
                    <td width="186" class="bgDescTablas"><label>
                      <select name="codunidmedidaedadinis" id="codunidmedidaedadinis" style="width: 150px" tabindex="3">
                        <option id="codunidmedidaedadinis" value=""></option>
                        <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codunidmedidaedad == codunidmedidaedadinif}'>
                              <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td width="20" class="bgDescTablas">&nbsp;</td>
                    <td width="100" class="bgDescTablas"><strong>Edad Inicial </strong></td>
                    <td width="236" class="bgDescTablas"><label>
                      <input name="edadinicials" type="text" id="edadinicials" value="${edadinicialf}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="4"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Unidad Medida Final </strong></td>
                    <td class="bgDescTablas">
			<select name="codunidmedidaedadfin" id="codunidmedidaedadfin" style="width: 150px" tabindex="5">
                      <option id="codunidmedidaedadfin" value=""></option>
                      <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codunidmedidaedad == codunidmedidaedadfin}'>
                            <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Final </strong></td>
                    <td class="bgDescTablas"><input name="edadfinal" type="text" id="edadfinal" value="${edadfinal}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="6"/></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                      <p align="center">
                        <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="7">${observacion}</textarea>
                      </p>                      </td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codplansalud" id="codplansalud" value="" >
                  <input type="hidden" name="coddiagnostico" id="coddiagnostico" value="" >
                  <input type="hidden" name="codunidmedidaedadini" id="codunidmedidaedadini" value="" >
                  <input type="hidden" name="edadinicial" id="edadinicial" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="11"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="8"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="9"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="10"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
		    </form>
          </table>
                <label></label>
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
        llaves = 'codplansalud='+document.getElementById('codplansaluds').value+',';
        llaves+= 'coddiagnostico='+document.getElementById('coddiagnosticos').value+',';
        llaves+= 'codunidmedidaedadini='+document.getElementById('codunidmedidaedadinis').value+',';
        llaves+= 'edadinicial='+document.getElementById('edadinicials').value;
        validarLlave('diagnplansalud',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=diagnplansalud&";
        url = url + "campos=coddiagnostico,codplansalud,codunidmedidaedadini,edadinicial,codunidmedidaedadfin,edadfinal,observacion&";
        url = url + "campoLlave=coddiagnostico,codplansalud,codunidmedidaedadini,edadinicial";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>