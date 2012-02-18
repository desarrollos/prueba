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
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('edadinicials','edadfinal','observacion');
            var combos = new Array('codsuministros','codunidmedidaedadinis','codunidmedidaedadfin');
                        
            //validar
            var arrayNonulos               	= new Array('edadinicials');
            var arrayNumerosEnteros        	= new Array('edadinicials','edadfinal');
            var arrayCombos               	= new Array('codsuministros','codunidmedidaedadinis','codunidmedidaedadfin');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion');
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
            <c:if test='${param.codsuministro != null && param.codunidmedidaedadini != null && param.edadinicial != null && param.edadinicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM suministroedad WHERE codsuministro='${param.codsuministro}' AND codunidmedidaedadini='${param.codunidmedidaedadini}' AND edadinicial='${param.edadinicial}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codsuministrof" value="${fila.codsuministro}"/> 
              <c:set var="codunidmedidaedadinif" value="${fila.codunidmedidaedadini}"/> 
              <c:set var="edadinicialf" value="${fila.edadinicial}"/> 
              <c:set var="codunidmedidaedadfin" value="${fila.codunidmedidaedadfin}"/> 
              <c:set var="edadfinal" value="${fila.edadfinal}"/> 
              <c:set var="observacion" value="${fila.observacion}"/>   

            </jsp2:forEach>
                
                <table width="778" border="0" class="tablaContenido">
		<form action="SuministroEdad.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Suministro Por Edad</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="106" class="bgDescTablas"><strong>
                    <label></label>                      
                    <label></label>
                    <strong>Suministro</strong></strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codsuministros" id="codsuministros" style="width: 150px" tabindex="1">
                        <option id="codsuministros" value=""></option>
                        <sql:query var="r" sql="select codsuministro, descripcion from suministros" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codsuministro == codsuministrof}'>
                              <option value="${fila.codsuministro}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codsuministro}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Unidad Medida Inicial</strong>
                      <label></label></td>
                    <td width="217" class="bgDescTablas">
                    <select name="codunidmedidaedadinis" id="codunidmedidaedadinis" style="width: 150px" tabindex="2">
                  <option id="codunidmedidaedadinis" value=""></option>
                          <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codunidmedidaedad == codunidmedidaedadinif}'>
                                <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select></td>
                    <td width="9" class="bgDescTablas">&nbsp;</td>
                    <td width="103" class="bgDescTablas"><strong>Edad Inicial</strong></td>
                    <td width="211" class="bgDescTablas"><label>
                      <input name="edadinicials" type="text" id="edadinicials" value="${edadinicialf}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="3"/>
                    </label></td>
              </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Unidad Medida Final</strong></td>
                    <td><span class="bgDescTablas">
                    <select name="codunidmedidaedadfin" id="codunidmedidaedadfin" style="width: 150px" tabindex="4">
                      <option id="codunidmedidaedadfin" value=""></option>
                          <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codunidmedidaedad == codunidmedidaedadfin}'>
                                <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                      </select>
                    </span></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Edad Final</strong></td>
                    <td><label>
                      <input name="edadfinal" type="text" id="edadfinal" value="${edadfinal}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                    <p align="center"><strong>
                      <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="6">${observacion}</textarea>
                    </strong></p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codsuministro" id="codsuministro" value="" >
                  <input type="hidden" name="codunidmedidaedadini" id="codunidmedidaedadini" value="" >
                  <input type="hidden" name="edadinicial" id="edadinicial" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="10">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="7"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="8"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="9"/>-->
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
        llaves = 'codsuministro='+document.getElementById('codsuministros').value+',';
		llaves+= 'codunidmedidaedadini='+document.getElementById('codunidmedidaedadinis').value+',';
		llaves+= 'edadinicial='+document.getElementById('edadinicials').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('suministroedad',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=suministroedad&";
        url = url + "campos=codsuministro,codunidmedidaedadini,edadinicial,codunidmedidaedadfin,edadfinal,observacion&";
        url = url + "campoLlave=codsuministro,codunidmedidaedadini,edadinicial";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>