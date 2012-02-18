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
            var cajas = new Array('codsalacirugias','codalterno','descripcion');
            var combos = new Array('codentidadsaluds','codcentroatencions','codestadosala','codgrupocamasalas');
            
            //validar
            var arrayNonulos               	= new Array ('codsalacirugias');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('codentidadsaluds','codcentroatencions','codestadosala','codgrupocamasalas');
            var arrayCadenasANCod          	= new Array ('codsalacirugias','codalterno');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('descripcion');
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.codsalacirugia != null}">
            <sql:query var="r" sql="SELECT * FROM salacirugia WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codsalacirugia='${param.codsalacirugia}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codsalacirugiaf" value="${fila.codsalacirugia}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/> 
              <c:set var="codalterno" value="${fila.codalterno}"/>
              <c:set var="codcentroatencionf" value="${fila.codcentroatencion}"/>
              <c:set var="codunidadfuncionalf" value="${fila.codunidadfuncional}"/>              
              <c:set var="codareaserviciof" value="${fila.codareaservicio}"/>  
              <c:set var="codestadosala" value="${fila.codestadosala}"/>  
              <c:set var="codgrupocamasalaf" value="${fila.codgrupocamasala}"/>
              <c:set var="codsubgrupocamasalaf" value="${fila.codsubgrupocamasala}"/>
            </jsp2:forEach>
                
                <table width="794" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="SalaCirugia.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Salas Cirug&iacute;a</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="122" class="bgDescTablas"><strong>Entidad Salud</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codentidadsaluds" id="codentidadsaluds" style="width: 150px" tabindex="1">
                        <option id="codentidadsaluds" value=""></option>
                          <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf}'>
                                <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
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
                    <td class="bgDescTablas"><strong>C&oacute;digo Sala Cirug&iacute;a</strong></td>
                    <td width="194" class="bgDescTablas">
                        <input name="codsalacirugias" type="text" id="codsalacirugias" value="${codsalacirugiaf}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="2"/>
                    </td>
                    <td width="18" class="bgDescTablas">&nbsp;</td>
                    <td width="144" class="bgDescTablas"><strong>C&oacute;digo Alterno</strong></td>
                    <td width="168" class="bgDescTablas"><label>
                      <input name="codalterno" type="text" id="codalterno" value="${codalterno}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="3"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Area Servicio</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codcentroatencions" id="codcentroatencions" style="width: 150px" tabindex="4">
                        <option id="codcentroatencions" value=""></option>
                        <sql:query var="r" sql="select codcentroatencion, codunidadfuncional, codareaservicio, descripcion from areaservicio" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codcentroatencion == codcentroatencionf && fila.codunidadfuncional == codunidadfuncionalf && fila.codareaservicio == codareaserviciof}'>
                              <option value="${fila.codcentroatencion} ${fila.codunidadfuncional} ${fila.codareaservicio}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codcentroatencion} ${fila.codunidadfuncional} ${fila.codareaservicio}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Estado Sala</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codestadosala" id="codestadosala" style="width: 150px" tabindex="5">
                        <option id="codestadosala" value=""></option>
                          <sql:query var="r" sql="select codestadosala, descripcion from estadosala" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codestadosala == codestadosala}'>
                                <option value="${fila.codestadosala}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codestadosala}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Subgrupo Cama Sala</strong></td>
                    <td colspan="4" class="bgDescTablas">
                    <select name="codgrupocamasalas" id="codgrupocamasalas" style="width: 150px" tabindex="6">
                      <option id="codgrupocamasalas" value=""></option>
                      <sql:query var="r" sql="select codgrupocamasala, codsubgrupocamasala, descripcion from subgrupocamasala" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codgrupocamasala == codgrupocamasalaf && fila.codsubgrupocamasala == codsubgrupocamasalaf}'>
                            <option value="${fila.codgrupocamasala} ${fila.codsubgrupocamasala}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codgrupocamasala} ${fila.codsubgrupocamasala}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" onkeypress="javascript:return permite(event, 'com')" tabindex="7"/>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codsalacirugia" id="codsalacirugia" value="" >
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
        var cad = document.getElementById('codentidadsaluds').value;        
        var cad2 = cad.split(" ");
        
        llaves = 'codregimenes='+cad2[0]+',';
        llaves+= 'codentidadsalud='+cad2[1]+',';
        llaves+= 'codsalacirugia='+document.getElementById('codsalacirugias').value;
        validarLlave('salacirugia',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=salacirugia&";
        url = url + "campos=codregimenes,codentidadsalud,codsalacirugia,codalterno,descripcion,codareaservicio,codestadosala,codsubgrupocamasala&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codsalacirugia";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>