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
            var cajas = new Array('numerocamas','codalterno','descripcion','observacion');
            var combos = new Array('codentidadsaluds','codtipohabitacion','codtipocama','codestadocama','codgrupocamasalas','codcentroatencions','codactividadsalud');
            
            //validar
            var arrayNonulos               	= new Array ('numerocamas');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codentidadsaluds','codtipohabitacion','codtipocama','codestadocama','codgrupocamasalas','codcentroatencions','codactividadsalud');
            var arrayCadenasANCod          	= new Array ('numerocamas','codalterno');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('descripcion','observacion');
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.numerocama != null}">
            <sql:query var="r" sql="SELECT * FROM cama WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND numerocama='${param.numerocama}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="numerocamaf" value="${fila.numerocama}"/>
              <c:set var="codalterno" value="${fila.codalterno}"/>    
              <c:set var="descripcion" value="${fila.descripcion}"/>  
              <c:set var="codtipohabitacion" value="${fila.codtipohabitacion}"/>  
              <c:set var="codtipocama" value="${fila.codtipocama}"/>  
              <c:set var="codestadocama" value="${fila.codestadocama}"/>
              <c:set var="codgrupocamasalaf" value="${fila.codgrupocamasala}"/>
              <c:set var="codsubgrupocamasalaf" value="${fila.codsubgrupocamasala}"/>  
              <c:set var="observacion" value="${fila.observacion}"/>  
              <c:set var="codcentroatencionf" value="${fila.codcentroatencion}"/>
              <c:set var="codunidadfuncionalf" value="${fila.codunidadfuncional}"/>
              <c:set var="codareaserviciof" value="${fila.codareaservicio}"/>
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/>        
            </jsp2:forEach>
                
                <table width="794" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="Cama.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Camas</div></td>
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
                                <c:when test='${fila.codregimenes == codregimenesf &&  fila.codentidadsalud == codentidadsaludf}'>
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
                    <td class="bgDescTablas"><strong>Numero Cama</strong></td>
                    <td width="194" class="bgDescTablas">
                        <input name="numerocamas" type="text" id="numerocamas" value="${numerocamaf}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="2"/>
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
                    <td class="bgDescTablas"><strong>Tipo Habitaci&oacute;n</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codtipohabitacion" id="codtipohabitacion" style="width: 150px" tabindex="4">
                        <option id="codtipohabitacion" value=""></option>
                          <sql:query var="r" sql="select codtipohabitacion, descripcion from tipohabitacion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipohabitacion == codtipohabitacion}'>
                                <option value="${fila.codtipohabitacion}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipohabitacion}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Cama</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codtipocama" id="codtipocama" style="width: 150px" tabindex="5">
                        <option id="codtipocama" value=""></option>
                          <sql:query var="r" sql="select codtipocama, descripcion from tipocama" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipocama == codtipocama}'>
                                <option value="${fila.codtipocama}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipocama}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Estado Cama</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codestadocama" id="codestadocama" style="width: 150px" tabindex="6">
                        <option id="codestadocama" value=""></option>
                          <sql:query var="r" sql="select codestadocama, descripcion from estadocama" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codestadocama == codestadocama}'>
                                <option value="${fila.codestadocama}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codestadocama}">${fila.descripcion}</option>
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
                    <select name="codgrupocamasalas" id="codgrupocamasalas" style="width: 150px" tabindex="7">
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
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Area Servicio</strong></td>
                    <td colspan="4" class="bgDescTablas">
                    <select name="codcentroatencions" id="codcentroatencions" style="width: 150px" tabindex="8">
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
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Actividad Salud</strong></td>
                    <td colspan="4" class="bgDescTablas">
                    <select name="codactividadsalud" id="codactividadsalud" style="width: 150px" tabindex="9">
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
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" onkeypress="javascript:return permite(event, 'com')" tabindex="10"/>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas">
                        <label>
                        <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="11">${observacion}</textarea>
                        </label>
                      </p>                      </td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="numerocama" id="numerocama" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="15"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="12"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="13"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="14"/> -->
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
        var cad = document.getElementById('codentidadsaluds').value;        
        var cad2 = cad.split(" ");
        
        llaves = 'codregimenes='+cad2[0]+',';
        llaves+= 'codentidadsalud='+cad2[1]+',';
        llaves+= 'numerocama='+document.getElementById('numerocamas').value;
        validarLlave('cama',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=cama&";
        url = url + "campos=codregimenes,codentidadsalud,numerocama,codalterno,descripcion,codtipohabitacion,codtipocama,codestadocama,observacion&";
        url = url + "campoLlave=codregimenes,codentidadsalud,numerocama";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>