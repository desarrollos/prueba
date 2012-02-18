<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>
<head>
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
        <script type="text/javascript" src="../js/pestanas/jquery-1.2.2.pack.js"></script>
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            //totalidad de elementos en el form
            var cajas = new Array('idregistros','numerofactura','cantidad','valorunitario','valortotal');
            var combos = new Array('idencabezados','codentidadsaludpres','codconceptoservicio','codestregrips');
                      
            //validar
            var arrayNonulos               = new Array('idregistros');
            var arrayNumerosEnteros        = new Array('idregistros','cantidad');
            var arrayCombos                = new Array('idencabezados','codentidadsaludpres','codconceptoservicio','codestregrips');
            var arrayCadenasANCod          = new Array('numerofactura');
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = new Array('valorunitario','valortotal');
            
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
            <c:if test='${param.idencabezado != null && param.idencabezado != "" && param.idregistro != null && param.idregistro != ""}'>
            <sql:query var="r" sql="SELECT * FROM archivodescips WHERE idencabezado=${param.idencabezado} AND idregistro=${param.idregistro}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idencabezadof" value="${fila.idencabezado}"/>
              <c:set var="idregistrof" value="${fila.idregistro}"/>
              <c:set var="codregimenpres" value="${fila.codregimenpres}"/>
              <c:set var="codentidadsaludpres" value="${fila.codentidadsaludpres}"/>
              <c:set var="numerofactura" value="${fila.numerofactura}"/>            
              <c:set var="codconceptoservicio" value="${fila.codconceptoservicio}"/>
              <c:set var="cantidad" value="${fila.cantidad}"/>
              <c:set var="valorunitario" value="${fila.valorunitario}"/>
              <c:set var="valortotal" value="${fila.valortotal}"/>
              <c:set var="codestregrips" value="${fila.codestregrips}"/>
            </jsp2:forEach>
                
                <table width="642" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="ArchivoDescripcionIPS.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Archivo Descripcion IPS </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="24" class="bgDescTablas">&nbsp;</td>
                    <td width="144" class="bgDescTablas"><strong>Encabezado</strong></td>
                    <td width="169" class="sinBgDescTablas">
                    <select name="idencabezados" id="idencabezados" style="width: 150px">
                      <option id="idencabezados" value=""></option>
                      <sql:query var="r" sql="select idencabezado from encabezadoarchivo" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.idencabezado == idencabezadof}'>
                            <option value="${fila.idencabezado}" selected="selected">${fila.idencabezado}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.idencabezado}">${fila.idencabezado}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td width="26">&nbsp;</td>
                    <td width="101" class="bgDescTablas"><strong>Nro. Registro </strong></td>
                    <td width="178" class="sinBgDescTablas"><input name="idregistros" type="text" id="idregistros" value="${idregistrof}" size="20" maxlength="10" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Entidad Salud Prestador </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codentidadsaludpres" id="codentidadsaludpres" style="width: 150px">
                        <option id="codentidadsaludpres" value=""></option>
                        <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codregimenes == codregimenpres && fila.codentidadsalud == codentidadsaludpres}'>
                              <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro. Factura </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="numerofactura" type="text" id="numerofactura" value="${numerofactura}" size="20" maxlength="20" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Concepto Servicio </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codconceptoservicio" id="codconceptoservicio" style="width: 150px">
                        <option id="codconceptoservicio" value=""></option>
                        <sql:query var="r" sql="select codconceptoservicio, descripcion from conceptoservicio" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codconceptoservicio == codconceptoservicio}'>
                              <option value="${fila.codconceptoservicio}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codconceptoservicio}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Cantidad</strong></p></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="cantidad" type="text" id="cantidad" value="${cantidad}" size="20" maxlength="10" />
                    </label></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="21" class="bgDescTablas"><strong>Valor Unitario </strong></td>
                    <td height="21"><label>
                      <input name="valorunitario" type="text" id="valorunitario" value="${valorunitario}" size="20" maxlength="15" />
                    </label></td>
                    <td height="21">&nbsp;</td>
                    <td height="21" class="bgDescTablas"><strong>Valor Total </strong></td>
                    <td height="21"><label>
                      <input name="valortotal" type="text" id="valortotal" value="${valortotal}" size="20" maxlength="15" />
                    </label></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="21" class="bgDescTablas"><strong>Estado Registro RIPS </strong></td>
                    <td height="21" colspan="4"><span class="sinBgDescTablas">
                    <select name="codestregrips" id="codestregrips" style="width: 150px">
                      <option id="codestregrips" value=""></option>
                      <sql:query var="r" sql="select codestregrips, descripcion from estadoregrips" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codestregrips == codestregrips}'>
                              <option value="${fila.codestregrips}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codestregrips}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </span></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
            <tr>
                <td colspan="7"><div align="center">
                  <input type="hidden" name="idencabezado" id="idencabezado" value="" >
                  <input type="hidden" name="idregistro" id="idregistro" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
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
        llaves = 'idencabezado='+document.getElementById('idencabezados').value+',';
		llaves = 'idregistro='+document.getElementById('idregistros').value;
        validarLlave('archivodescips',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=archivodescips&";
        url = url + "campos=idencabezado,idregistro,codregimenpres,codentidadsaludpres,numerofactura,codconceptoservicio,cantidad,valorunitario&";
        url = url + "campoLlave=idencabezado,idregistro";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>

