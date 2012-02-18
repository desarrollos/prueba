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
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script><script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = null;
            var combos = new Array('grusegcodigo','lisopccodigo','niseopcodigo');
			
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('grusegcodigo','lisopccodigo','niseopcodigo');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM opciongruposeg WHERE grusegcodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="grusegcodigo" value="${fila.grusegcodigo}"/>
              <c:set var="lisopccodigo" value="${fila.lisopccodigo}"/>
              <c:set var="niseopcodigo" value="${fila.niseopcodigo}"/>
            </jsp2:forEach>
                
                <table width="799" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="OpcionGrupoSeguridad.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Opciones Grupos de Seguridad</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="31">&nbsp;</td>
                    <td width="264" class="bgDescTablas"><strong>Grupo de Seguridad</strong></td>
                    <td width="359" colspan="4" align="left" class="bgDescTablas">
                      <select name="grusegcodigo" id="grusegcodigo" style="width: 150px" tabindex="1">
                          <option id="grusegcodigo" value=""></option>
                          <sql:query var="r" sql="select grusegcodigo, grusegdescripcion from gruposeguridad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.grusegcodigo == grusegcodigo}'>
                                <option value="${fila.grusegcodigo}" selected="selected">${fila.grusegdescripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.grusegcodigo}">${fila.grusegdescripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="31">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Lista Opci&oacute;n</strong></td>
                    <td class="bgDescTablas" colspan="4" align="left">
                      <select name="lisopccodigo" id="lisopccodigo" style="width: 150px" tabindex="2">
                          <option id="lisopccodigo" value=""></option>
                          <sql:query var="r" sql="select lisopccodigo, lisopcprograma from listaopcion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.lisopccodigo == lisopccodigo}'>
                                <option value="${fila.lisopccodigo}" selected="selected">${fila.lisopcprograma}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.lisopccodigo}">${fila.lisopcprograma}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="31">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nivel Seguridad</strong></td>
                    <td class="bgDescTablas" colspan="4" align="left">
                      <select name="niseopcodigo" id="niseopcodigo" style="width: 150px" tabindex="3">
                          <option id="niseopcodigo" value=""></option>
                          <sql:query var="r" sql="select niseopcodigo, niseopdescripcion from nivelsegopcion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.niseopcodigo == niseopcodigo}'>
                                <option value="${fila.niseopcodigo}" selected="selected">${fila.niseopdescripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.niseopcodigo}">${fila.niseopdescripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="7">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="4"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="5"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="6"/>-->
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
        llaves = 'grusegcodigo='+document.getElementById('grusegcodigo').value;
        validarLlave('opciongruposeg',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=opciongruposeg&";
        url = url + "campos=grusegcodigo,lisopccodigo,niseopcodigo&";
        url = url + "campoLlave=grusegcodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>