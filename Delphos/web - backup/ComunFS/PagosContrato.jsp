<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
<title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

        <script type="text/javascript" src="../js/jsCalendar/calendar.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/lang/calendar-es.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/calendar-setup.js"></script>
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
            Calendar.setup({inputField : "fechapago",ifFormat : "%d/%m/%Y",button : "botonFechapago"});
            Calendar.setup({inputField : "fechainicial",ifFormat : "%d/%m/%Y",button : "botonFechainicial"});
            Calendar.setup({inputField : "fechafinal",ifFormat : "%d/%m/%Y",button : "botonFechafinal"});
        }
			
			//totalidad de elementos en el form
            var cajas = new Array('nroordens','descripcion','fechapago','fechainicial','fechafinal','valorpago','saldocontrato','nrousuarios','facturaeapb','archivoegreso','archivopago','observacion');
            var combos = new Array('codcontratos','codcuentacontable','codempresa','codregimen');
                      
            //validar
            var arrayNonulos               = new Array('nroordens');
            var arrayNumerosEnteros        = new Array('nrousuarios');
            var arrayCombos                = new Array('codcontratos','codcuentacontable','codempresa','codregimen');
            var arrayCadenasANCod          = new Array('nroordens','facturaeapb');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('descripcion','archivoegreso','archivopago','observacion');
            var arrayNumerosDoubles        = new Array('valorpago','saldocontrato');
            
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
<%-- Datos sesion --%>

<%-- Datos sesion --%>
<tr>
    <td width="234" height="529" valign="top" style="background: url('../images/back.png')">
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.nroorden != null}">
            <sql:query var="r" sql="SELECT * FROM pagosecretariacto WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND nroorden='${param.nroorden}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="nroordenf" value="${fila.nroorden}"/>
              <c:set var="codregimen" value="${fila.codregimen}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <fmt:formatDate value="${fila.fechapago}" pattern="dd/MM/yyyy" var="fechapago"/>   
              <c:set var="codcuentacontable" value="${fila.codcuentacontable}"/>
              <c:set var="codtipoidentempr" value="${fila.codtipoidentempr}"/>
              <c:set var="codempresa" value="${fila.codempresa}"/>
              <fmt:formatDate value="${fila.fechainicial}" pattern="dd/MM/yyyy" var="fechainicial"/>
              <fmt:formatDate value="${fila.fechafinal}" pattern="dd/MM/yyyy" var="fechafinal"/>
              <c:set var="codtipocubrimupc" value="${fila.codtipocubrimupc}"/>
              <c:set var="anyoinicial" value="${fila.anyoinicial}"/>
              <c:set var="mesinicial" value="${fila.mesinicial}"/>
              <c:set var="valorpago" value="${fila.valorpago}"/>
              <c:set var="nrousuarios" value="${fila.nrousuarios}"/>
              <c:set var="saldocontrato" value="${fila.saldocontrato}"/>
              <c:set var="facturaeapb" value="${fila.facturaeapb}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="archivoegreso" value="${fila.archivoegreso}"/>
              <c:set var="archivopago" value="${fila.archivopago}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(pagosecretariacto.archivofi, '${ruta}${archivoegreso}') from pagosecretariacto where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND nroorden='${param.nroorden}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta1 = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta1 = ruta1.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta1);
              %>
              <sql:query var="r" sql="select lo_export(pagosecretariacto.archivofi2, '${ruta}${archivopago}') from pagosecretariacto where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND nroorden='${param.nroorden}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
</jsp2:forEach>

                
                <table width="741" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="PagosContrato.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Pagos Contrato </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="110" class="bgDescTablas"><strong>Contrato</strong></td>
                    <td width="173" class="sinBgDescTablas"><label>
                      <select name="codcontratos" id="codcontratos" style="width: 150px">
                        <option id="codcontratos" value=""></option>
                        <sql:query var="r" sql="select codcontrato, codregimenes, codentidadsalud from contrato" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf && fila.codcontrato == codcontratof}'>
                              <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}" selected="selected">${fila.codcontrato}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}">${fila.codcontrato}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td width="19">&nbsp;</td>
                    <td width="114" class="bgDescTablas"><strong class="bgDescTablas">Nro. Orden</strong></td>
                    <td width="202" class="sinBgDescTablas"><strong>
                      <input name="nroordens" type="text" id="nroordens" value="${nroordenf}" size="20" maxlength="12" />
                    </strong></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <label>
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" />
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Pago</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="fechapago" type="text" id="fechapago" value="${fechapago}" size="15" readonly="true" />
                      <input name="button" type="button" id="botonFechapago" value="..." />
</label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Cuenta Contable</strong></p></td>
                    <td class="sinBgDescTablas">
                    <p>
                      <label>
                      <select name="codcuentacontable" id="codcuentacontable" style="width: 150px">
                        <option id="codcuentacontable" value=""></option>
                          <sql:query var="r" sql="select codcuentacontable from cuentacontable" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codcuentacontable == codcuentacontable}'>
                                <option value="${fila.codcuentacontable}" selected="selected">${fila.codcuentacontable}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codcuentacontable}">${fila.codcuentacontable}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                      </select>
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="24" class="bgDescTablas"><strong>Empresa</strong></td>
                  <td colspan="4" class="sinBgDescTablas"><label>
                      <select name="codempresa" id="codempresa" style="width: 150px">
                        <option id="codempresa" value=""></option>
                          <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoidentidad == codtipoidentempr && fila.codempresa == codempresa}'>
                                <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
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
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Inicial</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="fechainicial" type="text" id="fechainicial" value="${fechainicial}" size="15" readonly="true" />
                      <input name="botonFecha" type="button" id="botonFechainicial" value="..." />
</label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Final</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="fechafinal" type="text" id="fechafinal" value="${fechafinal}" size="15" readonly="true" />
                      <input name="botonFecha2" type="button" id="botonFechafinal" value="..." />
</label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>C&oacute;digo Regimen</strong></td>
                    <td colspan="4"><label>
                      <select name="codregimen" id="codregimen" style="width: 150px">
                        <option id="codregimen" value=""></option>
                          <sql:query var="r" sql="select codregimen, codtipocubrimupc, anyoinicial, mesinicial from upcs" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                           <c:when test='${fila.codregimen == codregimen && fila.codtipocubrimupc == codtipocubrimupc && fila.anyoinicial == anyoinicial && fila.mesinicial == mesinicial}'>
                                <option value="${fila.codregimen} ${fila.codtipocubrimupc} ${fila.anyoinicial} ${fila.mesinicial}" selected="selected">${fila.codregimen}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${fila.codregimen} ${fila.codtipocubrimupc} ${fila.anyoinicial} ${fila.mesinicial}">${fila.codregimen}</option>
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
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Pago</strong></td>
                    <td><label>
                      <input name="valorpago" type="text" id="valorpago" value="${valorpago}" size="20" maxlength="17" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Saldo Contrato</strong></td>
                    <td><label>
                      <input name="saldocontrato" type="text" id="saldocontrato" value="${saldocontrato}" size="20" maxlength="17" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Nro. Usuarios</strong></td>
                    <td><label>
                      <input name="nrousuarios" type="text" id="nrousuarios" value="${nrousuarios}" size="20" maxlength="9" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Nro. Factura</strong></span></td>
                    <td><input name="facturaeapb" type="text" id="facturaeapb" value="${facturaeapb}" size="20" maxlength="14" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Archivo Comprobante Egreso</strong></td>
                    <td><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archivoegreso" type="text" id="archivoegreso" size="15"  value="${archivoegreso}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${archivoegreso != null && archivoegreso != ""}'><br>
                        <a href="../temp/${archivoegreso}" target="_blank">Descargar ${archivoegreso}</a> </c:if>
                    </span></label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Archivo Certificado Pago</strong></td>
                    <td><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archivopago" type="text" id="archivopago" size="15"  value="${archivopago}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo1();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${archivopago != null && archivopago != ""}'><br>
                        <a href="../temp/${archivopago}" target="_blank">Descargar ${archivopago}</a> </c:if>
                    </span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                    <p align="center">
                      <label>
                      <textarea name="observacion" id="observacion" cols="75" rows="3">${observacion}</textarea>
                      </label>
                    </p></td>
                  </tr>
           <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="nroorden" id="nroorden" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->
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
        <jsp:include page="../footer.jsp" />
	</td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>    
    //funciones control
    configurar();
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivoegreso";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
	function abrirCargaArchivo1()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivopago";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
        var cad = document.getElementById('codcontratos').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		
		llaves+= 'nroorden='+document.getElementById('nroordens').value;
        validarLlave('pagosecretariacto',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=pagosecretariacto&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,nroorden,codregimen,fechapago,codcuentacontable,codtipoidentempr,fechainicial,fechafinal&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,nroorden";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>