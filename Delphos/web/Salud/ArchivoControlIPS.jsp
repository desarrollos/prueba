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
            var cajas = new Array('idregistros','cantidadregistros');
            var combos = new Array('idencabezados','codtiporips','codestregrips');
                      
            //validar
            var arrayNonulos               = new Array('idregistros');
            var arrayNumerosEnteros        = new Array('idregistros','cantidadregistros');
            var arrayCombos                = new Array('idencabezados','codtiporips','codestregrips');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
            
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
            <sql:query var="r" sql="SELECT * FROM archivocontrolips WHERE idencabezado=${param.idencabezado} AND idregistro=${param.idregistro}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idencabezadof" value="${fila.idencabezado}"/>
              <c:set var="idregistrof" value="${fila.idregistro}"/>
              <c:set var="codtiporips" value="${fila.codtiporips}"/>
              <c:set var="cantidadregistros" value="${fila.cantidadregistros}"/>
              <c:set var="codestregrips" value="${fila.codestregrips}"/>                            
            </jsp2:forEach>
                
                <table width="720" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="ArchivoControlIPS.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Archivo  Control IPS</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="19" class="bgDescTablas">&nbsp;</td>
                    <td width="116" class="bgDescTablas"><strong>Encabezado</strong></td>
                    <td colspan="4" class="sinBgDescTablas">
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
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro. Registro </strong></td>
                    <td width="181" class="sinBgDescTablas"><label>
                      <input name="idregistros" type="text" id="idregistros" value="${idregistrof}" size="20" maxlength="10" />
                    </label></td>
                    <td width="20">&nbsp;</td>
                    <td width="101" class="bgDescTablas"><span class="sinBgDescTablas"><strong>Tipo RIPS </strong></span></td>
                    <td width="205" class="sinBgDescTablas"><label>
                      <select name="codtiporips" id="codtiporips" style="width: 150px">
                        <option id="codtiporips" value=""></option>
                        <sql:query var="r" sql="select codtiporips, descripcion from tiporips" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codtiporips == codtiporips}'>
                              <option value="${fila.codtiporips}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codtiporips}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Estado Registro RIPS </strong></td>
                  <td class="sinBgDescTablas"><label>
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
                  </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Cantidad Registros </strong></p></td>
                    <td class="sinBgDescTablas"><input name="cantidadregistros" type="text" id="cantidadregistros" value="${cantidadregistros}" size="20" maxlength="10" /></td>
                  </tr>
                  <tr>
                    <td height="27" colspan="6">&nbsp;</td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
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
        llaves = 'idencabezado='+document.getElementById('idencabezados').value+',';
		llaves += 'idregistro='+document.getElementById('idregistros').value;
        validarLlave('archivocontrolips',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=archivocontrolips&";
        url = url + "campos=idencabezado,idregistro,codtiporips,cantidadregistros,codestregrips&";
        url = url + "campoLlave=idencabezado,idregistro";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>
