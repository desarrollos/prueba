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
            var cajas = null;
            var combos = null;
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = null;
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM tipopagocompartido WHERE codtipopagocompartido='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipopagocompartido" value="${fila.codtipopagocompartido}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>         
            </jsp2:forEach>
                
                <table width="642" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="Autorizacion.jsp">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Autorizaci&oacute;n</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="127" class="bgDescTablas"><strong>Tipo Identificaci&oacute;n</strong>
                      <label></label></td>
                    <td class="bgDescTablas"><label>
                    <select name="codtipoidentidad" id="codtipoidentidad">
                         <option id="codtipoidentidad" value=""></option>
                          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoidentidad == codtipoidentidad}'>
                                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="18" class="bgDescTablas">&nbsp;</td>
                    <td width="113" class="bgDescTablas"><strong>No. Identificaci&oacute;n</strong></td>
                    <td width="220" class="bgDescTablas"><label>
                      <input name="numeroidentificacion" type="text" id="numeroidentificacion" size="20" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">
                      <div align="center">
                        <input type="submit" name="consultarpriorizado" id="consultarpriorizado" value="Consultar Priorizado" />
                      </div>                    </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><div align="center" class="titulo1">Datos del Usuario</div></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nombre</strong></td>
                    <td class="bgDescTablas"><input name="primernombre" type="text" id="primernombre" size="20" /></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>EPS</strong></td>
                    <td class="bgDescTablas"><input name="epspriorizado" type="text" id="epspriorizado" size="20" /></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Nacimiento</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="fechanacimiento" type="text" id="fechanacimiento" size="20" />
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nivel Sisben</strong></td>
                    <td class="bgDescTablas"><label><strong>
                      <input name="nivelsisbenpriorizado" type="text" id="nivelsisbenpriorizado" size="20" />
                    </strong></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Ficha Sisben
                      
                    </strong></td>
                    <td class="bgDescTablas"><strong>
                      <input name="fichasisbenpriorizado" type="text" id="fichasisbenpriorizado" size="20" />
                    </strong></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><div align="center" class="titulo1">Datos a Actualizar</div></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Direccion</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="textfield" type="text" id="textfield" size="20" />
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Barrio</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codbarrio" id="codbarrio">
                           <option id="codbarrio" value=""></option>
                          <sql:query var="r" sql="select codbarrio, nombre from barrio" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codbarrio == codbarrio}'>
                                <option value="${fila.codbarrio}" selected="selected">${fila.nombre}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codbarrio}">${fila.nombre}</option>
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
                    <td class="bgDescTablas"><strong>Telefono Movil</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="textfield2" type="text" id="textfield2" size="20" />
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Telefono Fijo</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="textfield3" type="text" id="textfield3" size="20" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>EPS</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="select2" id="select2">
                      </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>No. Contrato</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="numero" id="numero">
                           <option id="numero" value=""></option>
                          <sql:query var="r" sql="select numero from contrato" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.numero == numero}'>
                                <option value="${fila.numero}" selected="selected">${fila.numero}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.numero}">${fila.numero}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"></td>
                  </tr>
              <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                 <!-- <input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
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
        llaves = 'codactividadeconomica='+document.getElementById('codactividadeconomica').value;
        validarLlave('actividadeconomica',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=tipopagocompartido&";
        url = url + "campos=codtipopagocompartido,descripcion&";
        url = url + "campoLlave=codtipopagocompartidoz";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>