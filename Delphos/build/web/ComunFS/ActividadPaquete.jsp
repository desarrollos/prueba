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
            var cajas = new Array('cantidadminima','cantidadmaxima','cantidadmaxima','descripcion');
            var combos = new Array('codactividadsaludppal','codactividadsaluddpdte','codinsumo');
            	
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= new Array('cantidadminima', 'cantidadmaxima','cantidadpromedio');
            var arrayCombos               	= new Array('codactividadsaludppal','codactividadsaluddpdte','codinsumo');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
            var arrayNumerosDoubles             = null;
            
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM actividadpaquete WHERE codinsumo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codactividadsaludppal" value="${fila.codactividadsaludppal}"/>
              <c:set var="codactividadsaluddpdte" value="${fila.codactividadsaluddpdte}"/>
              <c:set var="codinsumo" value="${fila.codinsumo}"/>  
              <c:set var="descripcion" value="${fila.descripcion}"/>  
              <c:set var="cantidadminima" value="${fila.cantidadminima}"/>  
              <c:set var="cantidadmaxima" value="${fila.cantidadmaxima}"/>  
              <c:set var="cantidadpromedio" value="${fila.cantidadpromedio}"/>         
            </jsp2:forEach>
                
                <table width="857" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="ActividadPaquete.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Actividad Paquete</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27" class="bgDescTablas">&nbsp;</td>
                    <td width="137" class="bgDescTablas"><strong>Actividad Salud Principal</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codactividadsaludppal" id="codactividadsaludppal" style="width: 150px" tabindex="1">
                           <option id="codactividadsaludppal" value=""></option>
                          <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codactividadsalud == codactividadsaludppal}'>
                                <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Actividad Salud Pendiente</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                    <select name="codactividadsaluddpdte" id="codactividadsaluddpdte" style="width: 150px" tabindex="2">
                      <option id="codactividadsaluddpdte" value=""></option>
                      <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codactividadsalud == codactividadsaluddpdte}'>
                            <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select>
                    </label>
                      <label></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Insumo</strong></td>
                    <td colspan="4" class="bgDescTablas">
                    <select name="codinsumo" id="codinsumo" style="width: 150px" tabindex="3">
                      <option id="codinsumo" value=""></option>
                      <sql:query var="r" sql="select codinsumo, descripcion from insumo" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codinsumo == codinsumo}'>
                            <option value="${fila.codinsumo}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codinsumo}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><div align="center" class="titulo1">Actividad Dependiente</div></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Minima</strong></td>
                    <td width="169" class="bgDescTablas"><label>
                      <input name="cantidadminima" type="text" id="cantidadminima" value="${cantidadminima}" size="20" maxlength="5" onkeypress="javascript:return permite(event, 'nume')" tabindex="4"/>
                    </label></td>
                    <td width="22" class="bgDescTablas">&nbsp;</td>
                    <td width="127" class="bgDescTablas"><strong>Cantidad Maxima</strong></td>
                    <td width="160" class="bgDescTablas"><label>
                      <input name="cantidadmaxima" type="text" id="cantidadmaxima" value="${cantidadmaxima}" size="20" maxlength="5" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Promedio</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <input name="cantidadpromedio" type="text" id="cantidadpromedio" value="${cantidadpromedio}" size="20" maxlength="5" onkeypress="javascript:return permite(event, 'nume')" tabindex="6"/>
                    </label>                      <label></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center"><strong>
                      <textarea name="descripcion" id="descripcion" cols="75" rows="3" tabindex="7">${descripcion}</textarea>
                      <label></label>
                    </strong></p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="11"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="8"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="9"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="10"/> -->
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
        llaves = 'codactividadsaludppal='+document.getElementById('codactividadsaludppal').value+',';
        llaves+= 'codactividadsaluddpdte='+document.getElementById('codactividadsaluddpdte').value+',';
		llaves+= 'codinsumo='+document.getElementById('codinsumo').value;
        validarLlave('actividadpaquete',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadpaquete&";
        url = url + "campos=codactividadsaludppal,codactividadsaluddpdte,codinsumo,descripcion,cantidadminima,cantidadmaxima,cantidadpromedio&";
        url = url + "campoLlave=codinsumo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>