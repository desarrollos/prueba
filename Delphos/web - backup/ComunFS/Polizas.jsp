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
            Calendar.setup({inputField : "fechainicial",ifFormat : "%d/%m/%Y",button : "botonFechainicial"});
            Calendar.setup({inputField : "fechafinal",ifFormat : "%d/%m/%Y",button : "botonFechafinal"});
            Calendar.setup({inputField : "fechaexpedic",ifFormat : "%d/%m/%Y",button : "botonFechaexpedic"});
        }
			
			//totalidad de elementos en el form
            var cajas = new Array('numeropoliza','fechainicial','fechafinal','valor','fechaexpedic','archivo');
            var combos = new Array('codcontratos','codtipopoliza','codempresaaseg','codempresatomador');
                      
            //validar
            var arrayNonulos               = new Array('numeropoliza');
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('codcontratos','codtipopoliza','codempresaaseg','codempresatomador');
            var arrayCadenasANCod          = new Array('numeropoliza');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('archivo');
            var arrayNumerosDoubles        = new Array('valor');
            
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM polizacontrato WHERE numeropoliza='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="numeropoliza" value="${fila.numeropoliza}"/>
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codtipopoliza" value="${fila.codtipopoliza}"/>             
              <c:set var="codtipoidentaseg" value="${fila.codtipoidentaseg}"/>
              <c:set var="codempresaaseg" value="${fila.codempresaaseg}"/>
              <c:set var="codtipoidenttomad" value="${fila.codtipoidenttomad}"/>
              <c:set var="codempresatomador" value="${fila.codempresatomador}"/>
              <fmt:formatDate value="${fila.fechainicial}" pattern="dd/MM/yyyy" var="fechainicial"/> 
              <fmt:formatDate value="${fila.fechafinal}" pattern="dd/MM/yyyy" var="fechafinal"/> 
              <c:set var="valor" value="${fila.valor}"/>
              <fmt:formatDate value="${fila.fechaexpedic}" pattern="dd/MM/yyyy" var="fechaexpedic"/> 
              <c:set var="archivo" value="${fila.archivo}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(polizacontrato.archivofi, '${ruta}${archivo}') from polizacontrato where numeropoliza='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
                
                <table width="623" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="Polizas.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">P&oacute;lizas</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="105" class="bgDescTablas"><strong class="bgDescTablas">Contrato</strong></td>
                  <td colspan="4" class="sinBgDescTablas"><label>
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
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro. P&oacute;liza</strong></td>
                    <td width="173" class="sinBgDescTablas"><label>
                      <input name="numeropoliza" type="text" id="numeropoliza" value="${numeropoliza}" size="20" maxlength="20" />
                    </label></td>
                    <td width="29">&nbsp;</td>
                    <td width="94" class="bgDescTablas"><p><strong>Tipo P&oacute;liza</strong></p></td>
                    <td width="211" class="sinBgDescTablas">
                    <p>
                      <select name="codtipopoliza" id="codtipopoliza" style="width: 150px">
                        <option id="codtipopoliza" value=""></option>
                              <sql:query var="r" sql="select codtipopoliza, descripcion from tipopoliza" dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codtipopoliza == codtipopoliza}'>
                                    <option value="${fila.codtipopoliza}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codtipopoliza}">${fila.descripcion}</option>
                                </c:otherwise>
                               </c:choose>
                             </jsp2:forEach>
                      </select>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>Empresa Aseguradora</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codempresaaseg" id="codempresaaseg" style="width: 150px">
                        <option id="codempresaaseg" value=""></option>
                          <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoidentidad == codtipoidentaseg && fila.codempresa == codempresaaseg}'>
                                <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                       </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Empresa Tomadora</strong></td>
                    <td class="sinBgDescTablas"><label><strong>
                      <select name="codempresatomador" id="codempresatomador" style="width: 150px">
                        <option id="codempresatomador" value=""></option>
                        <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codtipoidentidad == codtipoidenttomad && fila.codempresa == codempresatomador}'>
                              <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </strong></label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Inicial</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="fechainicial" type="text" id="fechainicial" value="${fechainicial}" size="15" readonly="true" />
                    <input name="button" type="button" id="botonFechainicial" value="..." />
</label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Final</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="fechafinal" type="text" id="fechafinal" value="${fechafinal}" size="15" readonly="true" />
                    <input name="button2" type="button" id="botonFechafinal" value="..." />
</label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="valor" type="text" id="valor" value="${valor}" size="20" maxlength="17" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Expedicion</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="fechaexpedic" type="text" id="fechaexpedic" value="${fechaexpedic}" size="15" readonly="true" />
                    <input name="button22" type="button" id="botonFechaexpedic" value="..." />
</label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Archivo</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${archivo != null && archivo != ""}'><br>
                        <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
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
        url = url + "campo=archivo";
        
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
        llaves = 'numeropoliza='+document.getElementById('numeropoliza').value;
        validarLlave('polizacontrato',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=polizacontrato&";
        url = url + "campos=numeropoliza,codregimenes,codentidadsalud,codcontrato,codtipopoliza,codtipoidentaseg,codempresaaseg,codempresatomador,fechainicial,fechafinal,fechaexpedic&";
        url = url + "campoLlave=numeropoliza";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>