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
            var cajas = new Array('codrubropresupuestal','descripcion','codalterno','observacion');
            var combos = new Array('codtiporecursoppto','codcuecontpptoapro','codcuecontpptoejec','codcuecontdisponib','codcuecontcomprom','codcuecontobligac','codcuecontgiro','codtipofuentefinancia');
		
            //validar
            var arrayNonulos               	= new Array ('codrubropresupuestal');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('codtiporecursoppto','codcuecontpptoapro','codcuecontpptoejec','codcuecontdisponib','codcuecontcomprom', 'codcuecontobligac','codcuecontgiro','codtipofuentefinancia');			
            var arrayCadenasANCod          	= new Array ('codrubropresupuestal','codalterno');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('descripcion','observacion');
            var arrayNumerosDoubles        	= null;

	</script></head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
            <sql:query var="r" sql="SELECT * FROM rubropresupuestal WHERE codrubropresupuestal='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codrubropresupuestal" value="${fila.codrubropresupuestal}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="codalterno" value="${fila.codalterno}"/>   
              <c:set var="codtiporecursoppto" value="${fila.codtiporecursoppto}"/>
              <c:set var="codcuecontpptoapro" value="${fila.codcuecontpptoapro}"/>
              <c:set var="codcuecontpptoejec" value="${fila.codcuecontpptoejec}"/>
              <c:set var="codcuecontdisponib" value="${fila.codcuecontdisponib}"/>
              <c:set var="codcuecontcomprom" value="${fila.codcuecontcomprom}"/>
              <c:set var="codcuecontobligac" value="${fila.codcuecontobligac}"/>
              <c:set var="codcuecontgiro" value="${fila.codcuecontgiro}"/>
              <c:set var="inversion" value="${fila.inversion}"/>
              <c:set var="observacion" value="${fila.observacion}"/>     
              <c:set var="codtipofuentefinancia" value="${fila.codtipofuentefinancia}"/>       
</jsp2:forEach>
                
                <table width="849" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="RubroPresupuestal.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Rubros Presupuestales</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>C&oacute;digo Rubro Presupuestal</strong></td>
                    <td width="153" class="bgDescTablas"><label>
                      <input name="codrubropresupuestal" type="text" id="codrubropresupuestal" value="${codrubropresupuestal}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                    </label></td>
                    <td width="23" class="bgDescTablas">&nbsp;</td>
                    <td width="129" class="bgDescTablas"><strong>C&oacute;digo Alterno</strong></td>
                    <td width="164" class="bgDescTablas"><label>
                      <input name="codalterno" type="text" id="codalterno" value="${codalterno}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Recurso Presupuestal</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codtiporecursoppto" id="codtiporecursoppto" style="width: 150px" tabindex="3">
                          <option id="codtiporecursoppto" value=""></option>
                          <sql:query var="r" sql="select codtiporecursoppto, descripcion from tiporecursoppto" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtiporecursoppto == codtiporecursoppto}'>
                                <option value="${fila.codtiporecursoppto}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtiporecursoppto}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cuenta Contable Presupuesto Aprovado</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codcuecontpptoapro" id="codcuecontpptoapro" style="width: 150px" tabindex="4">
                           <option id="codcuecontpptoapro" value=""></option>
                          <sql:query var="r" sql="select codcuentacontable, descripcion from cuentacontable" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codcuentacontable == codcuecontpptoapro}'>
                                <option value="${fila.codcuentacontable}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codcuentacontable}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Cuenta Contable Presupuesto Ejecutado</strong></td>
                    <td class="bgDescTablas">
                    <select name="codcuecontpptoejec" id="codcuecontpptoejec" style="width: 150px" tabindex="5">
                      <option id="codcuecontpptoejec" value=""></option>
                      <sql:query var="r" sql="select codcuentacontable, descripcion from cuentacontable" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codcuentacontable == codcuecontpptoejec}'>
                            <option value="${fila.codcuentacontable}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codcuentacontable}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cuenta Contable Disponibilidad</strong></td>
                    <td class="bgDescTablas">
                    <select name="codcuecontdisponib" id="codcuecontdisponib" style="width: 150px" tabindex="6">
                      <option id="codcuecontdisponib" value=""></option>
                      <sql:query var="r" sql="select codcuentacontable, descripcion from cuentacontable" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codcuentacontable == codcuecontdisponib}'>
                            <option value="${fila.codcuentacontable}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codcuentacontable}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Cuenta Contable Compromiso</strong></td>
                    <td class="bgDescTablas">
                    <select name="codcuecontcomprom" id="codcuecontcomprom" style="width: 150px" tabindex="7">
                      <option id="codcuecontcomprom" value=""></option>
                      <sql:query var="r" sql="select codcuentacontable, descripcion from cuentacontable" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codcuentacontable == codcuecontcomprom}'>
                            <option value="${fila.codcuentacontable}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codcuentacontable}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cuenta Contable Obligaci&oacute;n</strong></td>
                    <td class="bgDescTablas">
                    <select name="codcuecontobligac" id="codcuecontobligac" style="width: 150px" tabindex="8">
                      <option id="codcuecontobligac" value=""></option>
                      <sql:query var="r" sql="select codcuentacontable, descripcion from cuentacontable" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codcuentacontable == codcuecontobligac}'>
                            <option value="${fila.codcuentacontable}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codcuentacontable}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Cuenta Contable Giro</strong></td>
                    <td class="bgDescTablas">
                    <select name="codcuecontgiro" id="codcuecontgiro" style="width: 150px" tabindex="9">
                      <option id="codcuecontgiro" value=""></option>
                      <sql:query var="r" sql="select codcuentacontable, descripcion from cuentacontable" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codcuentacontable == codcuecontgiro}'>
                            <option value="${fila.codcuentacontable}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codcuentacontable}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>&iquest; Es Rubro de Inversion ?</strong></td>
                    <td class="bgDescTablas">
                          <c:choose>
                            <c:when test = '${inversion == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="inversion" value="S" id="inversion_0" checked="true" tabindex="10"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="inversion" value="N" id="inversion_1" tabindex="10"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="inversion" value="S" id="inversion_0" tabindex="10"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="inversion" value="N" id="inversion_1" checked="true" tabindex="10"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>                        </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="177" class="bgDescTablas"><strong>Fuente Financiaci&oacute;n</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codtipofuentefinancia" id="codtipofuentefinancia" style="width: 150px" tabindex="11">
                        <option id="codtipofuentefinancia" value=""></option>
                        <sql:query var="r" sql="select codtipofuentefinancia, descripcion from tipofuentefinancia" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codtipofuentefinancia == codtipofuentefinancia}'>
                              <option value="${fila.codtipofuentefinancia}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codtipofuentefinancia}">${fila.descripcion}</option>
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
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                      <p align="center">
                        <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onkeypress="javascript:return permite(event, 'com')" tabindex="12"/>
                      </p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                    <p align="center">
                      <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="13">${observacion}</textarea>
                    </p></td>
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
        llaves = 'codrubropresupuestal='+document.getElementById('codrubropresupuestal').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('rubropresupuestal',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=rubropresupuestal&";
        url = url + "campos=codrubropresupuestal,descripcion,codalterno,codtiporecursoppto,codcuecontpptoapro,codcuecontpptoejec,codcuecontdisponib,observacion&";
        url = url + "campoLlave=codrubropresupuestal";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>