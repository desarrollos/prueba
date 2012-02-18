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
            var cajas = new Array('codsubgrupos','descripcion','observacion');
            var combos = new Array('codgrupoactividads');
            
            //validar
            var arrayNonulos               	= new Array('codsubgrupos');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codgrupoactividads');
            var arrayCadenasANCod          	= new Array('codsubgrupos');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion','observacion');
            var arrayNumerosDoubles             = null;
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
            <c:if test='${param.codgrupoactividad != null && param.codsubgrupo != null && param.codgrupoactividad != ""}'>
            <sql:query var="r" sql="SELECT * FROM subgrupoactividad WHERE codgrupoactividad=${param.codgrupoactividad} AND codsubgrupo='${param.codsubgrupo}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codgrupoactividadf" value="${fila.codgrupoactividad}"/>
              <c:set var="codsubgrupof" value="${fila.codsubgrupo}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="observacion" value="${fila.observacion}"/>          
            </jsp2:forEach>
                
                <table width="800" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="SubgrupoActividad.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Subgrupo Actividad Salud</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="128" class="bgDescTablas"><strong>C&oacute;digo Grupo Actividad</strong>
                    <label></label></td>
                    <td width="193" class="bgDescTablas"><label>
                      <select name="codgrupoactividads" id="codgrupoactividads" style="width: 150px" tabindex="1">
                      <option id="codgrupoactividads" value=""></option>
                          <sql:query var="r" sql="select codgrupoactividad, descripcion from grupoactividad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codgrupoactividad == codgrupoactividadf}'>
                                <option value="${fila.codgrupoactividad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codgrupoactividad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="21" class="bgDescTablas">&nbsp;</td>
                    <td width="116" class="bgDescTablas"><strong>C&oacute;digo Subgrupo</strong></td>
                    <td width="188" class="bgDescTablas"><label>
                      <input name="codsubgrupos" type="text" id="codsubgrupos" value="${codsubgrupof}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <textarea name="descripcion" id="descripcion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="3">${descripcion}</textarea>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas">
                        <label>
                        <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="4">${observacion}</textarea>
                        </label>
                      </p>                      </td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codgrupoactividad" id="codgrupoactividad" value="" >
                  <input type="hidden" name="codsubgrupo" id="codsubgrupo" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="8">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="5"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="6"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="7"/>-->
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
        llaves = 'codgrupoactividad='+document.getElementById('codgrupoactividads').value+',';
		llaves+= 'codsubgrupo='+document.getElementById('codsubgrupos').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('subgrupoactividad',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=subgrupoactividad&";
        url = url + "campos=codgrupoactividad,codsubgrupo,descripcion,observacion&";
        url = url + "campoLlave=codgrupoactividad,codsubgrupo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>