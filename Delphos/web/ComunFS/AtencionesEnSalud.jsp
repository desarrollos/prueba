<!--
	Familias en accion
-->
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
           
            function configurar()
        	{
            Calendar.setup({inputField : "salatefecate",ifFormat : "%d/%m/%Y",button : "botonsalatefecate"});
			}
			
			//totalidad de elementos en el form
            var cajas = new Array('salateidregi','salateidenti','salatecantid','salatefecate','salatefactur');
            var combos = new Array('codentidadsaludips','codentidadsaludeapb','codtipoidentidad','codactividadsalud','codfinalidadconsulta','coddiagnosticopr','coddiagnosticor1','coddiagnosticor2','coddiagnosticor3','coddiagnosticosa','coddiagnosticonu');
			
            var arrayNonulos               	= new Array('salateidregi','salatecantid','salatefecate');
            var arrayNumerosEnteros        	= new Array('salateidregi','salatecantid');
            var arrayCombos               	= new Array('codentidadsaludips','codentidadsaludeapb','codtipoidentidad','codactividadsalud','codfinalidadconsulta','coddiagnosticopr','coddiagnosticor1','coddiagnosticor2','coddiagnosticor3','coddiagnosticosa','coddiagnosticonu');
            var arrayCadenasANCod          	= new Array('salateidenti','salatefactur');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= null;
</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
    <c:if test='${param.llave != null && param.llave != ""}'>
            <sql:query var="r" sql="SELECT * FROM saludatencion WHERE salateidregi=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="salateidregi" value="${fila.salateidregi}"/>
              <c:set var="codregimenips" value="${fila.codregimenips}"/>
              <c:set var="codentidadsaludips" value="${fila.codentidadsaludips}"/>
              <c:set var="codregimeneapb" value="${fila.codregimeneapb}"/>
              <c:set var="codentidadsaludeapb" value="${fila.codentidadsaludeapb}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="salateidenti" value="${fila.salateidenti}"/>
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/> 
              <c:set var="salatecantid" value="${fila.salatecantid}"/>
              <fmt:formatDate value="${fila.salatefecate}" pattern="dd/MM/yyyy" var="salatefecate"/>
              <c:set var="salatefactur" value="${fila.salatefactur}"/>
              <c:set var="codfinalidadconsulta" value="${fila.codfinalidadconsulta}"/>
              <c:set var="coddiagnosticopr" value="${fila.coddiagnosticopr}"/>
              <c:set var="coddiagnosticor1" value="${fila.coddiagnosticor1}"/>
              <c:set var="coddiagnosticor2" value="${fila.coddiagnosticor2}"/>
              <c:set var="coddiagnosticor3" value="${fila.coddiagnosticor3}"/>
              <c:set var="coddiagnosticosa" value="${fila.coddiagnosticosa}"/>
              <c:set var="coddiagnosticonu" value="${fila.coddiagnosticonu}"/> 
            </jsp2:forEach> 

            
          <form name="formulario" method="post" action="AtencionesEnSalud.jsp">
          <span id="mensajeControlador">${msj}</span>
          <table width="826" border="0" class="tablaContenido">
			
              <tr>
                <td colspan="6"><div align="center"><span class="titulo1">Atenciones en Salud</span></div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="154"><strong class="bgDescTablas">Id Registro</strong></td>
                <td colspan="4"><strong>
                  <label><span class="sinBgDescTablas" style="width: 7%">
                  <input name="salateidregi" type="text" id="salateidregi" value="${salateidregi}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
                  </span></label>
                </strong></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">IPS</strong></td>
                <td width="162"><select name="codentidadsaludips" id="codentidadsaludips" style="width: 150px">
                  <option id="codentidadsaludips" value=""></option>
                  <sql:query var="r" sql="select codentidadsalud, codregimenes, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codentidadsalud == codentidadsaludips && fila.codregimenes == codregimenips}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="19">&nbsp;</td>
                <td width="122"><strong class="bgDescTablas">EAPB</strong></td>
                <td width="189">
                    <select name="codentidadsaludeapb" id="codentidadsaludeapb" style="width: 150px">
                  <option id="codentidadsaludeapb" value=""></option>
                  <sql:query var="r" sql="select codentidadsalud, codregimenes, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codentidadsalud == codentidadsaludeapb && fila.codregimenes == codregimeneapb}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tipo Id.</strong></td>
                <td><span class="sinBgDescTablas" style="width: 17%">
                  <select name="codtipoidentidad" id="codtipoidentidad" style="width: 150px">
                    <option id="codtipoidentidad" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidad}'>
                          <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 15%"><strong>Nro. Identificaci&oacute;n</strong></span></td>
                <td class="sinBgDescTablas"><span class="sinBgDescTablas" style="width: 35%">
                  <input name="salateidenti" type="text" id="salateidenti" value="${salateidenti}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Actividad</strong></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codactividadsalud" id="codactividadsalud" style="width: 150px">
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
                </span></td>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Cantidad</strong></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 10%">
                  <input name="salatecantid" type="text" id="salatecantid" value="${salatecantid}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 15%"><strong>Fecha Atenci&oacute;n</strong></span></td>
                <td colspan="4" class="bgDescTablas"><span class="sinBgDescTablas" style="width: 16%">
                  <input name="salatefecate" type="text" id="salatefecate" value="${salatefecate}" size="15" readonly="readonly" />
                  <span class="sinBgDescTablas" style="width: 16%"><span class="sinBgDescTablas" style="width: 16%">
                  <input name="botonsalatefecate" type="button" id="botonsalatefecate" value="..." />
                  </span></span></span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 15%"><strong>Nro. Factura</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="salatefactur" type="text" id="salatefactur" value="${salatefactur}" size="20" maxlength="20" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 20%"><strong>Finalidad Consulta</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 25%">
                  <select name="codfinalidadconsulta" id="codfinalidadconsulta" style="width: 150px">
                    <option id="codfinalidadconsulta" value=""></option>
                    <sql:query var="r" sql="select codfinalidadconsulta, descripcion from finalidadconsulta" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codfinalidadconsulta == codfinalidadconsulta}'>
                          <option value="${fila.codfinalidadconsulta}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codfinalidadconsulta}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 13%"><strong>Dx Principal</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas">
                  <select name="coddiagnosticopr" id="coddiagnosticopr" style="width: 150px">
                    <option id="coddiagnosticopr" value=""></option>
                    <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddiagnostico == coddiagnosticopr}'>
                          <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 12%"><strong>Dx Relacionado 1</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 17%">
                  <select name="coddiagnosticor1" id="coddiagnosticor1" style="width: 150px">
                    <option id="coddiagnosticor1" value=""></option>
                    <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddiagnostico == coddiagnosticor1}'>
                          <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 12%"><strong>Dx Relacionado 2</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 17%">
                  <select name="coddiagnosticor2" id="coddiagnosticor2" style="width: 150px">
                    <option id="coddiagnosticor2" value=""></option>
                    <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddiagnostico == coddiagnosticor2}'>
                          <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 13%"><strong>Dx Relacionado 3</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 17%">
                  <select name="coddiagnosticor3" id="coddiagnosticor3" style="width: 150px">
                    <option id="coddiagnosticor3" value=""></option>
                    <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddiagnostico == coddiagnosticor3}'>
                          <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 13%"><strong>Dx Salida</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 17%">
                  <select name="coddiagnosticosa" id="coddiagnosticosa" style="width: 150px">
                    <option id="coddiagnosticosa" value=""></option>
                    <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddiagnostico == coddiagnosticosa}'>
                          <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><span class="bgDescTablas" style="width: 12%"><strong>Dx Muerte</strong></span></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 17%">
                  <select name="coddiagnosticonu" id="coddiagnosticonu" style="width: 150px">
                    <option id="coddiagnosticonu" value=""></option>
                    <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddiagnostico == coddiagnosticonu}'>
                          <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17"> -->
		  <label>&nbsp;</label>
		  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
          </table>
        </form>
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
        llaves = 'salateidregi='+document.getElementById('salateidregi').value;
        validarLlave('saludatencion',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=saludatencion&";
        url = url + "campos=salateidregi,codregimenips,codentidadsaludips,codregimeneapb,codentidadsaludeapb,codtipoidentidad,salateidenti,codactividadsalud&";
        url = url + "campoLlave=salateidregi";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>