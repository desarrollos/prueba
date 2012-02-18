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
            function configurar()
            {
		Calendar.setup({inputField : "fechas",ifFormat : "%d/%m/%Y",button : "botonFecha"});
            }
            
            //totalidad de elementos en el form
            var cajas = new Array('fechas','datoanterior','datoactualizado','observacion');
            var combos = new Array('idusuarios','codtiponovedads','codcampoarchivos');
			
            var arrayNonulos               	= new Array('fechas');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('idusuarios','codtiponovedads','codcampoarchivos');			
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('datoanterior','datoactualizado','observacion');
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
<%-- Datos sesion --%>

<%-- Datos sesion --%>
<tr>
    <td style="background: url('../images/back.png')" width="235" valign="top">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
					<jsp:include page="../menu.jsp" />
                </td>
            </tr>
        </table>
    </td>
    <td width="670" valign="top">
                <center>
            <c:if test='${param.idusuario != null && param.idusuario != "" && param.codtiponovedad != null && param.fecha != null && param.fecha != "" && param.codcampoarchivo != null && param.codcampoarchivo != "" }'>
            <sql:query var="r" sql="SELECT * FROM novedadcampo WHERE idusuario=${param.idusuario} AND codtiponovedad='${param.codtiponovedad}' AND fecha='${param.fecha}' AND codcampoarchivo=${param.codcampoarchivo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idusuariof" value="${fila.idusuario}"/>
              <c:set var="codtiponovedadf" value="${fila.codtiponovedad}"/>
              <c:set var="codcampoarchivof" value="${fila.codcampoarchivo}"/>
              <fmt:formatDate value="${fila.fecha}" pattern="dd/MM/yyyy" var="fechaf"/>
              <c:set var="datoanterior" value="${fila.datoanterior}"/>              
              <c:set var="datoactualizado" value="${fila.datoactualizado}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
            </jsp2:forEach>

                
                <table width="784" border="0" class="tablaContenido">
		<form action="NovedadCampo.jsp" method="post" name="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Novedad Dato</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="120" class="bgDescTablas"><strong>Id. Usuario</strong></td>
                    <td width="174" class="sinBgDescTablas"><label>
                    <select name="idusuarios" id="idusuarios" style="width: 150px" tabindex="1">
                      <option id="idusuarios" value=""></option>
                      <sql:query var="r" sql="select idusuario from poblacion" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.idusuario == idusuariof}'>
                            <option value="${fila.idusuario}" selected="selected">${fila.idusuario}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.idusuario}">${fila.idusuario}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="3">&nbsp;</td>
                    <td width="115" class="bgDescTablas"><strong>Tipo Novedad</strong></td>
                    <td width="226" class="sinBgDescTablas"><label>
                        <select name="codtiponovedads" id="codtiponovedads" style="width: 150px" tabindex="2">
                           <option id="codtiponovedads" value=""></option>
                          <sql:query var="r" sql="select codtiponovedad, descripcion from tiponovedad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                            <c:choose>
                              <c:when test='${fila.codtiponovedad == codtiponovedadf}'>
                                <option value="${fila.codtiponovedad}" selected="selected">${fila.descripcion}</option>
                              </c:when>
                              <c:otherwise>
                                <option value="${fila.codtiponovedad}">${fila.descripcion}</option>
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
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Campo Archivo</strong></td>
                    <td><label>
                    <select name="codcampoarchivos" id="codcampoarchivos" style="width: 150px" tabindex="3">
                    <option id="codcampoarchivos" value=""></option>
                      <sql:query var="r" sql="select codcampoarchivo, descripcion from listacamposarchivo" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codcampoarchivo == codcampoarchivof}'>
                            <option value="${fila.codcampoarchivo}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codcampoarchivo}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Fecha</strong></td>
                    <td><input name="fechas" type="text" id="fechas" value="${fechaf}" size="15" readonly="true" />
                      <input name="botonFecha" type="button" id="botonFecha" value="..." tabindex="4"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Dato Anterior</strong></p>
                    <p align="center">
                      <label>
                      <textarea name="datoanterior" id="datoanterior" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="5">${datoanterior}</textarea>
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Dato Actualizado</strong></p>
                      <p align="center">
                        <label>
                        <textarea name="datoactualizado" id="datoactualizado" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="6">${datoactualizado}</textarea>
                        </label>
                      </p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center">
                        <label>
                        <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="7">${observacion}</textarea>
                        </label>
                      </p></td>
                  </tr>
                  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="idusuario" id="idusuario" value="" >
                  <input type="hidden" name="codtiponovedad" id="codtiponovedad" value="" >
                  <input type="hidden" name="codcampoarchivo" id="codcampoarchivo" value="" >
                  <input type="hidden" name="fecha" id="fecha" value="" >
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
                <p>&nbsp;</p>
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
    configurar();
    
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
        llaves = 'idusuario='+document.getElementById('idusuarios').value+',';
        llaves+= 'codtiponovedad='+document.getElementById('codtiponovedads').value+',';
	llaves+= 'fecha='+document.getElementById('fechas').value+',';
        llaves+= 'codcampoarchivo='+document.getElementById('codcampoarchivos').value;
        
        validarLlave('novedadcampo',llaves);
    } 
    
	
	function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=novedadcampo&";
        url = url + "campos=idusuario,codtiponovedad,fecha,codcampoarchivo,datoanterior,datoactualizado&";
        url = url + "campoLlave=idusuario,codtiponovedad,fecha,codcampoarchivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>