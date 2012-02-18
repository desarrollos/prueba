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
            var cajas = new Array('cantidadmin','cantidadmax','cantidadprom','descripcion');
            var combos = new Array('codtipodiagnrel','codactividadsalud','codinsumo');
            
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= new Array('cantidadmin','cantidadmax','cantidadprom');
            var arrayCombos               	= new Array('codtipodiagnrel','codactividadsalud','codinsumo');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
            var arrayNumerosDoubles        	= null;
                        
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
            <sql:query var="r" sql="SELECT * FROM diagnactividadrel WHERE codtipodiagnrel='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipodiagnrel" value="${fila.codtipodiagnrel}"/> 
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/> 
			  <c:set var="codinsumo" value="${fila.codinsumo}"/>  
			  <c:set var="descripcion" value="${fila.descripcion}"/>  
			  <c:set var="cantidadmin" value="${fila.cantidadmin}"/>  
			  <c:set var="cantidadmax" value="${fila.cantidadmax}"/>  
			  <c:set var="cantidadprom" value="${fila.cantidadprom}"/>   
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="DiagnActividadRel.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Diagn&oacute;sticos Relacionados </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="26" class="bgDescTablas">&nbsp;</td>
                    <td width="121" class="bgDescTablas"><strong> Tipo Diagn&oacute;stico Relacionado </strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codtipodiagnrel" id="codtipodiagnrel" style="width: 150px" tabindex="1">
                        <option id="codtipodiagnrel" value=""></option>
                        <sql:query var="r" sql="select codtipodiagnrel, descripcion from tipodiagrelacionado" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codtipodiagnrel == codtipodiagnrel}'>
                              <option value="${fila.codtipodiagnrel}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codtipodiagnrel}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Actividad Salud </strong></td>
                    <td width="157" class="bgDescTablas"><label>
                      <select name="codactividadsalud" id="codactividadsalud" style="width: 150px" tabindex="2">
                      <option id="codactividadsalud" value=""></option>
                        <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codactividadsalud == codactividadsalud}'>
                              <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>					  
                      </select>
                    </label></td>
                    <td width="20" class="bgDescTablas">&nbsp;</td>
                    <td width="97" class="bgDescTablas"><strong>Insumo </strong></td>
                    <td width="221" class="bgDescTablas"><label>
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
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Maxima </strong></td>
                    <td class="bgDescTablas"><label>
                    <input name="cantidadmax" type="text" id="cantidadmax" value="${cantidadmax}" size="20" maxlength="5" onkeypress="javascript:return permite(event, 'nume')" tabindex="4"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Minima </strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="cantidadmin" type="text" id="cantidadmin" value="${cantidadmin}" size="20" maxlength="5" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Promedio </strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                    <input name="cantidadprom" type="text" id="cantidadprom" value="${cantidadprom}" size="20" maxlength="5" onkeypress="javascript:return permite(event, 'nume')" tabindex="6"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                      <p align="center">
                        <textarea name="descripcion" id="descripcion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="7">${descripcion}</textarea>
                      </p>                      </td>
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
        llaves = 'codtipodiagnrel='+document.getElementById('codtipodiagnrel').value+',';
		llaves+= 'codactividadsalud='+document.getElementById('codactividadsalud').value+',';
		llaves+= 'codinsumo='+document.getElementById('codinsumo').value;
        validarLlave('diagnactividadrel',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=diagnactividadrel&";
        url = url + "campos=codtipodiagnrel,codactividadsalud,codinsumo,descripcion,cantidadmin,cantidadmax,cantidadprom&";
        url = url + "campoLlave=codtipodiagnrel";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>