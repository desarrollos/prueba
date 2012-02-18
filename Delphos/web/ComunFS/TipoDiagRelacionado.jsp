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
            var cajas = new Array('codtipodiagnrel','descripcion','observacion','edadminima','edadmaxima','numerouvr','valorensmdlv','valordiagnostico');
            var combos = new Array('codunidmedidaedadmin','codunidmedidaedadmax');
            
            //validar
            var arrayNonulos               	= new Array('codtipodiagnrel');
            var arrayNumerosEnteros        	= new Array('edadminima','edadmaxima','numerouvr');
            var arrayCombos               	= new Array('codunidmedidaedadmin','codunidmedidaedadmax');
            var arrayCadenasANCod          	= new Array('codtipodiagnrel');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion','observacion');
            var arrayNumerosDoubles        	= new Array('valorensmdlv','valordiagnostico');
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM tipodiagrelacionado WHERE codtipodiagnrel='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipodiagnrel" value="${fila.codtipodiagnrel}"/>
			  <c:set var="descripcion" value="${fila.descripcion}"/>  
			  <c:set var="codunidmedidaedadmin" value="${fila.codunidmedidaedadmin}"/>  
			  <c:set var="edadminima" value="${fila.edadminima}"/> 
			  <c:set var="codunidmedidaedadmax" value="${fila.codunidmedidaedadmax}"/> 
			  <c:set var="edadmaxima" value="${fila.edadmaxima}"/> 
			  <c:set var="aplicamujer" value="${fila.aplicamujer}"/> 
			  <c:set var="aplicahombre" value="${fila.aplicahombre}"/> 
			  <c:set var="aplicauvr" value="${fila.aplicauvr}"/> 
			  <c:set var="numerouvr" value="${fila.numerouvr}"/> 
			  <c:set var="valorensmdlv" value="${fila.valorensmdlv}"/> 
			  <c:set var="valordiagnostico" value="${fila.valordiagnostico}"/> 
			  <c:set var="observacion" value="${fila.observacion}"/>   
            </jsp2:forEach>
                
                <table width="806" border="0" class="tablaContenido">
		<form action="TipoDiagRelacionado.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Tipo Diagn&oacute;stico Relacionado </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="26" class="bgDescTablas">&nbsp;</td>
                    <td width="133" class="bgDescTablas"><strong>C&oacute;digo Diagn&oacute;stico Relacionado </strong>
                      <label></label>                      <label></label></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <input name="codtipodiagnrel" type="text" id="codtipodiagnrel" value="${codtipodiagnrel}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Unidad Medida Minima </strong></td>
                    <td width="172" class="bgDescTablas">
					<select name="codunidmedidaedadmin" id="codunidmedidaedadmin" style="width: 150px" tabindex="2">
                      <option id="codunidmedidaedadmin" value=""></option>
                      <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codunidmedidaedad == codunidmedidaedadmin}'>
                            <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td width="11" class="bgDescTablas">&nbsp;</td>
                    <td width="122" class="bgDescTablas"><strong>Edad Minima </strong></td>
                    <td width="178" class="bgDescTablas"><label>
                      <input name="edadminima" type="text" id="edadminima" value="${edadminima}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="3"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Unidad Medida Maxima </strong></td>
                    <td class="bgDescTablas">
					<select name="codunidmedidaedadmax" id="codunidmedidaedadmax" style="width: 150px" tabindex="4">
                      <option id="codunidmedidaedadmax" value=""></option>
                      <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codunidmedidaedad == codunidmedidaedadmax}'>
                            <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Maxima </strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="edadmaxima" type="text" id="edadmaxima" value="${edadmaxima}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Hombre </strong></td>
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
                        </c:choose>                    </td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Mujer </strong></td>
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
                        </c:choose>                    </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica UVR </strong></td>
                    <td class="bgDescTablas">
                          <c:choose>
                            <c:when test = '${aplicauvr == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicauvr" value="S" id="aplicauvr_0" checked="true" tabindex="8"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicauvr" value="N" id="aplicauvr_1" tabindex="8"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicauvr" value="S" id="aplicauvr_0" tabindex="8"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicauvr" value="N" id="aplicauvr_1" checked="true" tabindex="8"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>                   	</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Numero UVR </strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="numerouvr" type="text" id="numerouvr" value="${numerouvr}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="9"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor en SMDLV </strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="valorensmdlv" type="text" id="valorensmdlv" value="${valorensmdlv}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="10"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Dign&oacute;stico </strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="valordiagnostico" type="text" id="valordiagnostico" value="${valordiagnostico}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="11"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <label>
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onkeypress="javascript:return permite(event, 'com')" tabindex="12"/>
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                      <p align="center">
                        <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="13">${observacion}</textarea>
                      </p>                      </td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/>-->
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
        llaves = 'codtipodiagnrel='+document.getElementById('codtipodiagnrel').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('tipodiagrelacionado',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=tipodiagrelacionado&";
        url = url + "campos=codtipodiagnrel,descripcion,codunidmedidaedadmin,edadminima,codunidmedidaedadmax,edadmaxima,numerouvr,valorensmdlv&";
        url = url + "campoLlave=codtipodiagnrel";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>