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
            var cajas = new Array('edads');
            var combos = new Array('codprogramapromprevs','codactividadsaluds','codunidmedidaedads','codesquemaactividad');
		
            //validar
            var arrayNonulos               	= new Array('edads');
            var arrayNumerosEnteros        	= new Array('edads');
            var arrayCombos               	= new Array('codprogramapromprevs','codactividadsaluds','codunidmedidaedads','codesquemaactividad');			
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= null;

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
            <c:if test='${param.codprogramapromprev != null && param.codactividadsalud != null && param.codunidmedidaedad != null && param.edad != null && param.codactividadsalud != "" && param.edad != ""}'>
            <sql:query var="r" sql="SELECT * FROM programaciclo WHERE codprogramapromprev='${param.codprogramapromprev}' AND codactividadsalud=${param.codactividadsalud} AND codunidmedidaedad='${param.codunidmedidaedad}' AND edad=${param.edad}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codprogramapromprevf" value="${fila.codprogramapromprev}"/>
              <c:set var="codactividadsaludf" value="${fila.codactividadsalud}"/>
              <c:set var="codunidmedidaedadf" value="${fila.codunidmedidaedad}"/>  
              <c:set var="edadf" value="${fila.edad}"/>  
              <c:set var="codesquemaactividad" value="${fila.codesquemaactividad}"/> 
              <c:set var="aplicamujer" value="${fila.aplicamujer}"/> 
              <c:set var="aplicahombre" value="${fila.aplicahombre}"/>          
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form action="ProgramaCiclo.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Ciclo Programa</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="119" class="bgDescTablas"><strong>Programa</strong></td>
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
                    <td class="bgDescTablas"><strong>Actividad Salud</strong></td>
                    <td width="207" class="bgDescTablas"><label>
                      <select name="codactividadsaluds" id="codactividadsaluds" style="width: 150px" tabindex="2">
                          <option id="codactividadsaluds" value=""></option>
                        <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codactividadsalud == codactividadsaludf}'>
                               <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                             </c:when>
                            <c:otherwise>
                              <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="5" class="bgDescTablas">&nbsp;</td>
                    <td width="127" class="bgDescTablas"><strong>Esquema</strong></td>
                    <td width="188" class="bgDescTablas"><label>
                      <select name="codesquemaactividad" id="codesquemaactividad" style="width: 150px" tabindex="3">
                        <option id="codesquemaactividad" value=""></option>
                        <sql:query var="r" sql="select codesquemaactividad, descripcion from esquemaactividad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codesquemaactividad == codesquemaactividad}'>
                               <option value="${fila.codesquemaactividad}" selected="selected">${fila.descripcion}</option>
                             </c:when>
                            <c:otherwise>
                              <option value="${fila.codesquemaactividad}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Unidad Medida Edad</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codunidmedidaedads" id="codunidmedidaedads" style="width: 150px" tabindex="4">
                        <option id="codunidmedidaedads" value=""></option>
                        <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codunidmedidaedad == codunidmedidaedadf}'>
                              <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="edads" type="text" id="edads" value="${edadf}" size="20" maxlength="3" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Hombre</strong></td>
                    <td class="bgDescTablas">
                          <c:choose>
                            <c:when test = '${aplicahombre == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0" checked="true" tabindex="6"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" tabindex="6"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0" tabindex="6"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" checked="true" tabindex="6"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>                        </td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Mujer</strong></td>
                    <td class="bgDescTablas">
                          <c:choose>
                            <c:when test = '${aplicamujer == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0" checked="true" tabindex="7"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" tabindex="7"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0" tabindex="7"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" checked="true" tabindex="7"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>					</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codprogramapromprev" id="codprogramapromprev" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="codunidmedidaedad" id="codunidmedidaedad" value="" >
                  <input type="hidden" name="edad" id="edad" value="" >
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
        llaves = 'codprogramapromprev='+document.getElementById('codprogramapromprevs').value+',';
        llaves+= 'codactividadsalud='+document.getElementById('codactividadsaluds').value+',';
        llaves+= 'codunidmedidaedad='+document.getElementById('codunidmedidaedads').value+',';
        llaves+= 'edad='+document.getElementById('edads').value;
        validarLlave('programaciclo',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=programaciclo&";
        url = url + "campos=codprogramapromprev,codactividadsalud,codunidmedidaedad,edad,codesquemaactividad,aplicamujer,aplicahombre&";
        url = url + "campoLlave=codprogramapromprev,codactividadsalud,codunidmedidaedad,edad";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>