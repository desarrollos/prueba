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
            var cajas = new Array('observacion');
            var combos = new Array('codactividadsalud','codtipopersonal');
            
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipopersonal','codactividadsalud');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion');
            var arrayNumerosDoubles             = null;
            
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
            <c:if test='${param.codtipopersonal != null && param.codactividadsalud != null}'>
            <sql:query var="r" sql="SELECT * FROM actividadtipopersonal WHERE codtipopersonal='${param.codtipopersonal}' AND codactividadsalud='${param.codactividadsalud}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipopersonal" value="${fila.codtipopersonal}"/>
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/>
              <c:set var="observacion" value="${fila.observacion}"/>           
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form action="ActividadTipoPersonal.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Actividad Tipo Personal</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27" class="bgDescTablas">&nbsp;</td>
                    <td width="112" class="bgDescTablas"><strong>Tipo Personal</strong></td>
                  <td width="175" class="bgDescTablas"><label>
                      <select name="codtipopersonal" id="codtipopersonal" style="width: 150px" tabindex="1">
                          <option id="codtipopersonal" value=""></option>
                        <sql:query var="r" sql="select codtipopersonal, descripcion from tipopersonal" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codtipopersonal == codtipopersonal}'>
                               <option value="${fila.codtipopersonal}" selected="selected">${fila.descripcion}</option>
                             </c:when>
                            <c:otherwise>
                              <option value="${fila.codtipopersonal}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="26" class="bgDescTablas">&nbsp;</td>
                    <td width="112" class="bgDescTablas"><strong>Actividad Salud</strong></td>
                    <td width="190" class="bgDescTablas"><label>
                    <select name="codactividadsalud" id="codactividadsalud" style="width: 150px" tabindex="2">
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
                    </label></td>
              </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                    <p align="center"><strong>
                      <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="3">${observacion}</textarea>
                      <label></label>
                    </strong></p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipopersonal" id="codtipopersonal" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="7"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="4"/>
                  <input type="button" id="editar" name="editar" onclick="accion(2);" value="Actualizar" tabindex="5"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="6"/> -->
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
        llaves = 'codtipopersonal='+document.getElementById('codtipopersonal').value+',';
		llaves += 'codactividadsalud='+document.getElementById('codactividadsalud').value;
        validarLlave('actividadtipopersonal',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadtipopersonal&";
        url = url + "campos=codtipopersonal,codactividadsalud,observacion&";
        url = url + "campoLlave=codtipopersonal,codactividadsalud";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>