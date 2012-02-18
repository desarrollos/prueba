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
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script><script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
<script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('edad','observacion');
            var combos = new Array('codprogramapromprev','codactividadsalud','coddiagnostico','codunidmedidaedad');
            
            //validar
            var arrayNonulos               	= new Array('edad');
            var arrayNumerosEnteros        	= new Array('edad');
            var arrayCombos               	= new Array('codprogramapromprev','codactividadsalud','coddiagnostico','codunidmedidaedad');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion');
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
            <c:if test="${param.codprogramapromprev != null && param.codactividadsalud != null && param.coddiagnostico != null && param.codunidmedidaedad != null && param.edad != null}">
            <sql:query var="r" sql="SELECT * FROM diagncicloprograma WHERE codprogramapromprev='${param.codprogramapromprev}' AND codactividadsalud='${param.codactividadsalud}' AND coddiagnostico='${param.coddiagnostico}' AND codunidmedidaedad='${param.codunidmedidaedad}' AND edad='${param.edad}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codprogramapromprev" value="${fila.codprogramapromprev}"/> 
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/> 
			  <c:set var="coddiagnostico" value="${fila.coddiagnostico}"/>  
			  <c:set var="codunidmedidaedad" value="${fila.codunidmedidaedad}"/>  
			  <c:set var="edad" value="${fila.edad}"/>  
			  <c:set var="aplicahombre" value="${fila.aplicahombre}"/>  
			  <c:set var="aplicamujer" value="${fila.aplicamujer}"/>  
			  <c:set var="observacion" value="${fila.observacion}"/>  
            </jsp2:forEach>
                
                <table width="766" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="DiagnCicloPrograma.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Relaci&oacute;n Entre Diagn&oacute;sticos, Programas y Ciclos </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong> Programa </strong></td>
                    <td class="bgDescTablas"><select name="codprogramapromprev" id="codprogramapromprev" style="width: 150px" tabindex="1">
                      <option id="codprogramapromprev" value=""></option>
                      <sql:query var="r" sql="select codprogramapromprev, descripcion from programapromprev" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codprogramapromprev == codprogramapromprev}'>
                            <option value="${fila.codprogramapromprev}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codprogramapromprev}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Actividad Salud </strong></td>
                    <td class="bgDescTablas"><select name="codactividadsalud" id="codactividadsalud" style="width: 150px" tabindex="2">
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
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="94" class="bgDescTablas"><strong>Diagn&oacute;stico</strong></td>
                    <td width="196" class="bgDescTablas"><label>
                      <select name="coddiagnostico" id="coddiagnostico" style="width: 150px" tabindex="3">
                        <option id="coddiagnostico" value=""></option>
                        <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.coddiagnostico == coddiagnostico}'>
                              <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td width="20" class="bgDescTablas">&nbsp;</td>
                    <td width="100" class="bgDescTablas"><strong>Unidad Medida </strong></td>
                    <td width="236" class="bgDescTablas"><label>
                      <select name="codunidmedidaedad" id="codunidmedidaedad" style="width: 150px" tabindex="4">
                        <option id="codunidmedidaedad" value=""></option>
                        <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codunidmedidaedad == codunidmedidaedad}'>
                              <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Edad</strong></td>
                    <td class="bgDescTablas"><label>
                    <input name="edad" type="text" id="edad" value="${edad}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Hombre </strong></td>
                    <td class="bgDescTablas"><label>
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
                        </c:choose>
                      </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Mujer </strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
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
                      </c:choose>
                      </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                      <p align="center">
                        <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="8">${observacion}</textarea>
                        </p>                      
                    </td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codprogramapromprev" id="codprogramapromprev" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="coddiagnostico" id="coddiagnostico" value="" >
                  <input type="hidden" name="codunidmedidaedad" id="codunidmedidaedad" value="" >
                  <input type="hidden" name="edad" id="edad" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="12"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="9"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="10"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="11"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
		    </form>
          </table>
        </center>
        
    </td>
</tr>>
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
        llaves = 'codprogramapromprev='+document.getElementById('codprogramapromprev').value+',';
		llaves+= 'codactividadsalud='+document.getElementById('codactividadsalud').value+',';
		llaves+= 'coddiagnostico='+document.getElementById('coddiagnostico').value+',';
		llaves+= 'codunidmedidaedad='+document.getElementById('codunidmedidaedad').value+',';
		llaves+= 'edad='+document.getElementById('edad').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('diagncicloprograma',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=diagncicloprograma&";
        url = url + "campos=codprogramapromprev,codactividadsalud,coddiagnostico,codunidmedidaedad,edad,aplicahombre,aplicamujer,observacion&";
        url = url + "campoLlave=codprogramapromprev,codactividadsalud,coddiagnostico,codunidmedidaedad,edad";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>