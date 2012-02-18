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
            var cajas = new Array('subtipcodigo','subtipdescri','subtipedaini','subtipedafin');
            var combos = new Array('subtipgraini','subtipgrafin','subcatcodigo');
            
            //validar
            var arrayNonulos               	= new Array('subtipcodigo');
            var arrayNumerosEnteros        	= new Array('subtipedaini','subtipedafin');
            var arrayCombos               	= new Array('subtipgraini','subtipgrafin','subcatcodigo');
            var arrayCadenasANCod          	= new Array('subtipcodigo');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('subtipdescri');
            var arrayNumerosDoubles             = null;

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
            <sql:query var="r" sql="SELECT * FROM tiposubsidio WHERE subtipcodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="subtipcodigo" value="${fila.subtipcodigo}"/>
              <c:set var="subtipdescri" value="${fila.subtipdescri}"/> 
              <c:set var="subtipedaini" value="${fila.subtipedaini}"/> 
              <c:set var="subtipedafin" value="${fila.subtipedafin}"/> 
              <c:set var="subtipgraini" value="${fila.subtipgraini}"/> 
              <c:set var="subtipgrafin" value="${fila.subtipgrafin}"/> 
              <c:set var="subcatcodigo" value="${fila.subcatcodigo}"/>           
            </jsp2:forEach>
                
                <table width="642" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="TipoSubsidio.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Tipo Subsidio</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="135" class="bgDescTablas"><strong>C&oacute;digo Tipo Subsidio</strong></td>
                  <td width="136" class="bgDescTablas"><label>
                      <input name="subtipcodigo" type="text" id="subtipcodigo" value="${subtipcodigo}" size="20" maxlength="3" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                    </label></td>
                    <td width="18" class="bgDescTablas">&nbsp;</td>
                    <td width="131" class="bgDescTablas"><strong>Categoria Subsidio</strong></td>
                    <td width="192" class="bgDescTablas"><label>
                      <select name="subcatcodigo" id="subcatcodigo" style="width: 150px" tabindex="2">
                         <option id="subcatcodigo" value=""></option>
                          <sql:query var="r" sql="select subcatcodigo, subcatdescri from subsidiocategoria" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.subcatcodigo == subcatcodigo}'>
                                <option value="${fila.subcatcodigo}" selected="selected">${fila.subcatdescri}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.subcatcodigo}">${fila.subcatdescri}</option>
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
                    <td class="bgDescTablas"><strong>Edad Inicial</strong></td>
                  <td class="bgDescTablas"><label>
                      <input name="subtipedaini" type="text" id="subtipedaini" value="${subtipedaini}" size="20" onkeypress="javascript:return permite(event, 'nume')" tabindex="3"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Final</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="subtipedafin" type="text" id="subtipedafin" value="${subtipedafin}" onkeypress="javascript:return permite(event, 'nume')" tabindex="4"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Grado Escolaridad Inicial</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="subtipgraini" id="subtipgraini" style="width: 150px" tabindex="5">
                         <option id="subtipgraini" value=""></option>
                          <sql:query var="r" sql="select escgracodigo, escgradescri from escolaridadgrado" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.escgracodigo == subtipgraini}'>
                                <option value="${fila.escgracodigo}" selected="selected">${fila.escgradescri}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.escgracodigo}">${fila.escgradescri}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Grado Escolaridad Final</strong></td>
                    <td class="bgDescTablas">
                    <select name="subtipgrafin" id="subtipgrafin" style="width: 150px" tabindex="6">
                      <option id="subtipgrafin" value=""></option>
                      <sql:query var="r" sql="select escgracodigo, escgradescri from escolaridadgrado" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.escgracodigo == subtipgrafin}'>
                            <option value="${fila.escgracodigo}" selected="selected">${fila.escgradescri}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.escgracodigo}">${fila.escgradescri}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <label>
                      <input name="subtipdescri" type="text" id="subtipdescri" value="${subtipdescri}" size="75" maxlength="30" onkeypress="javascript:return permite(event, 'com')" tabindex="7"/>
                      </label>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        llaves = 'subtipcodigo='+document.getElementById('subtipcodigo').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('tiposubsidio',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=tiposubsidio&";
        url = url + "campos=subtipcodigo,subtipdescri,subtipedaini,subtipedafin,subtipgraini,subtipgrafin,subcatcodigo&";
        url = url + "campoLlave=subtipcodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>