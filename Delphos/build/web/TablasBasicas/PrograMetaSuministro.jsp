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
            var cajas = new Array('cantidad','cantidadmin','porccumplpotenc');
            var combos = new Array('codprogramapromprevs','codsuministros');
		
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= new Array('cantidad','cantidadmin');
            var arrayCombos               	= new Array('codprogramapromprevs','codsuministros');		
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= null;
			
            var arrayPorcentajes        	= new Array('porccumplpotenc');
            var arrayDirecciones        	= null;
            var arrayCorreos                    = null;

	</script></head>
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
            <c:if test="${param.codprogramapromprev != null && param.codsuministro != null}">
            <sql:query var="r" sql="SELECT * FROM programetasuministro WHERE codprogramapromprev='${param.codprogramapromprev}' AND codsuministro='${param.codsuministro}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codprogramapromprevf" value="${fila.codprogramapromprev}"/>
              <c:set var="codsuministrof" value="${fila.codsuministro}"/>
              <c:set var="cantidad" value="${fila.cantidad}"/>  
              <c:set var="cantidadmin" value="${fila.cantidadmin}"/>  
              <c:set var="porccumplpotenc" value="${fila.porccumplpotenc}"/>          
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form action="PrograMetaSuministro.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Programa Meta Suministro</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="23" class="bgDescTablas">&nbsp;</td>
                    <td width="105" class="bgDescTablas"><strong>Programa</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                    <select name="codprogramapromprevs" id="codprogramapromprevs" style="width: 150px" tabindex="1">
                      <option id="codprogramapromprevs" value=""></option>
                      <sql:query var="r" sql="select codprogramapromprev, descripcion from programapromprev" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codprogramapromprev == codprogramapromprevf}'>
                            <option value="${fila.codprogramapromprev}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codprogramapromprev}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Suministro</strong></td>
                    <td width="204" class="bgDescTablas"><label>
                      <select name="codsuministros" id="codsuministros" style="width: 150px" tabindex="2">
                        <option id="codsuministros" value=""></option>
                        <sql:query var="r" sql="select codsuministro, descripcion from suministros" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codsuministro == codsuministrof}'>
                               <option value="${fila.codsuministro}" selected="selected">${fila.descripcion}</option>
                             </c:when>
                            <c:otherwise>
                              <option value="${fila.codsuministro}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="11" class="bgDescTablas">&nbsp;</td>
                    <td width="126" class="bgDescTablas"><strong>Cantidad</strong></td>
                    <td width="173" class="bgDescTablas"><label>
                      <input name="cantidad" type="text" id="cantidad" value="${cantidad}" size="20" maxlength="8" onkeypress="javascript:return permite(event, 'nume')"tabindex="3"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Minima</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="cantidadmin" type="text" id="cantidadmin" value="${cantidadmin}" size="20" maxlength="8" onkeypress="javascript:return permite(event, 'nume')" tabindex="4"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Porcentaje Cumplimiento</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="porccumplpotenc" type="text" id="porccumplpotenc" value="${porccumplpotenc}" size="20" maxlength="8" onkeypress="javascript:return permite(event, 'numd')" tabindex="5"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codprogramapromprev" id="codprogramapromprev" value="" >
                  <input type="hidden" name="codsuministro" id="codsuministro" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="9">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="6"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="7"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="8"/>-->
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
        llaves = 'codprogramapromprev='+document.getElementById('codprogramapromprevs').value+',';
	llaves+= 'codsuministro='+document.getElementById('codsuministros').value;
        validarLlave('programetasuministro',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=programetasuministro&";
        url = url + "campos=codprogramapromprev,codsuministro,cantidad,cantidadmin,porccumplpotenc&";
        url = url + "campoLlave=codprogramapromprev,codsuministro";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>