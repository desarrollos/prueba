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
            var cajas = new Array('ususiscodigo','ususisusuario','ususiscodigoalt','ususisnombre','ususisapellido','ususisindenfica','ususiscontrasena','ususisfechacrea','ususisfechamodi','ususisdias');
            var combos = new Array('codtipoidentidad','grusegcodigo','codestusuasistema');
			
            var arrayNonulos               = new Array('ususiscodigo');
            var arrayNumerosEnteros        = new Array('ususisdias')
            var arrayCombos                = new Array('codtipoidentidad','grusegcodigo','codestusuasistema');
            var arrayCadenasANCod          = new Array('ususiscodigo','ususisusuario','ususiscodigoalt','ususisnombre','ususisapellido','ususisindenfica','ususiscontrasena');
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
	</script>
</head>
<body bgcolor="#FFFFFF">
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
            <sql:query var="r" sql="SELECT * FROM usuariosistema WHERE ususiscodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="ususiscodigo" value="${fila.ususiscodigo}"/>
              <c:set var="ususisusuario" value="${fila.ususisusuario}"/>
              <c:set var="ususiscodigoalt" value="${fila.ususiscodigoalt}"/>
              <c:set var="ususisnombre" value="${fila.ususisnombre}"/>
              <c:set var="ususisapellido" value="${fila.ususisapellido}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="ususisindenfica" value="${fila.ususisindenfica}"/>
              <c:set var="grusegcodigo" value="${fila.grusegcodigo}"/>
              <c:set var="ususiscontrasena" value="${fila.ususiscontrasena}"/>
              <c:set var="ususiscambio" value="${fila.ususiscambio}"/>
              <fmt:formatDate value="${fila.ususisfechacrea}" pattern="dd/MM/yyyy HH:mm:ss" var="ususisfechacrea"/>
              <fmt:formatDate value="${fila.ususisfechamodi}" pattern="dd/MM/yyyy HH:mm:ss" var="ususisfechamodi"/>
              <c:set var="ususisdias" value="${fila.ususisdias}"/>
              <c:set var="codestusuasistema" value="${fila.codestusuasistema}"/>
              <c:set var="ususismultisesion" value="${fila.ususismultisesion}"/>
              <c:set var="ususisinterno" value="${fila.ususisinterno}"/>
            </jsp2:forEach>
                
                <table width="799" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="UsuariosSistema.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="7"><div align="center" class="titulo1">Usuarios del Sistema</div></td>
                  </tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Codigo Usuario</strong></td>
                      <td class="bgDescTablas"><input name="ususiscodigo" type="text" id="ususiscodigo" value="${ususiscodigo}" size="20" maxlength="10" tabindex="1"></td>
                      <td class="bgDescTablas"><strong>Login</strong></td>
                      <td class="bgDescTablas"><input name="ususisusuario" type="text" id="ususisusuario" value="${ususisusuario}" size="20" maxlength="40" tabindex="2"></td>
                      <td class="bgDescTablas"><strong>Codigo Alterno</strong></td>
                      <td class="bgDescTablas"><input name="ususiscodigoalt" type="text" id="ususiscodigoalt" value="${ususiscodigoalt}" size="20" maxlength="10" tabindex="3"></td>
                  </tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Nombre</strong></td>
                      <td class="bgDescTablas" colspan="2"><input name="ususisnombre" type="text" id="ususisnombre" value="${ususisnombre}" size="20" maxlength="50" tabindex="4"></td>
                      <td class="bgDescTablas"><strong>Apellido</strong></td>
                      <td class="bgDescTablas" colspan="2"><input name="ususisapellido" type="text" id="ususisapellido" value="${ususisapellido}" size="20" maxlength="50" tabindex="5"></td>
                  </tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Tipo Identifiacion</strong></td>
                      <td class="bgDescTablas" colspan="2">
                          <select name="codtipoidentidad" id="codtipoidentidad" style="width: 150px" tabindex="6">
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
                          </select>                      </td>
                      <td class="bgDescTablas"><strong>Numero Identificacion</strong></td>
                      <td class="bgDescTablas" colspan="2"><input name="ususisindenfica" type="text" id="ususisindenfica" value="${ususisindenfica}" size="20" maxlength="18" tabindex="7"></td>
                  </tr>
                <tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Grupo</strong></td>
                      <td class="bgDescTablas" colspan="2">
                          <select name="grusegcodigo" id="grusegcodigo" style="width: 150px" tabindex="8">
                              <option id="grusegcodigo" value=""></option>
                              <sql:query var="r" sql="select grusegcodigo, grusegdescripcion from gruposeguridad WHERE grusegcodigo != 'G2' AND grusegcodigo != 'NO'" dataSource="jdbc/delphos" scope="page"/>
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
                          </select>                      </td>
                      <td class="bgDescTablas"><strong>Contraseña</strong></td>
                      <td class="bgDescTablas" colspan="2"><input name="ususiscontrasena" type="password" id="ususiscontrasena" value="${ususiscontrasena}" size="20" maxlength="20" tabindex="9"></td>
                  </tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Cambia Contraseña</strong></td>
                      <td class="bgDescTablas" colspan="2">
                      <c:choose>
                            <c:when test = '${ususiscambio == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="ususiscambio" value="S" id="ususiscambio_0" checked="true" tabindex="10"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="ususiscambio" value="N" id="ususiscambio_1" tabindex="10"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="ususiscambio" value="S" id="ususiscambio_0" tabindex="10"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="ususiscambio" value="N" id="ususiscambio_1" checked="true" tabindex="10"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose></td>
                      <td class="bgDescTablas"><strong>Fecha Contraseña</strong></td>
                      <td class="bgDescTablas" colspan="2"><input name="ususisfechacrea" type="text" id="ususisfechacrea"  value="${ususisfechacrea}" size="15" maxlength="19" readonly="readonly"/>
                    <input name="button" type="button" id="botonEncuenfecha" value="..." tabindex="11"/></td>
                  </tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Fecha Actualizacion Contraseña</strong></td>
                      <td class="bgDescTablas" colspan="2"><input name="ususisfechamodi" type="text" id="ususisfechamodi"  value="${ususisfechamodi}" size="15" maxlength="19" readonly="readonly"/>
                    <input name="button" type="button" id="botonususisfechamodi" value="..." tabindex="12"/></td>
                      <td class="bgDescTablas"><strong>Dias Caduca Contraseña</strong></td>
                      <td class="bgDescTablas" colspan="2"><input type="text" name="ususisdias" id="ususisdias" value="${ususisdias}" size="20" tabindex="13"></td>
                  </tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Estado Usuario</strong></td>
                      <td class="bgDescTablas" colspan="2">
                          <select name="codestusuasistema" id="codestusuasistema" style="width: 150px" tabindex="14">
                              <option id="codestusuasistema" value=""></option>
                              <sql:query var="r" sql="select codestusuasistema, descripcion from estadousuasistema" dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codestusuasistema == codestusuasistema}'>
                                    <option value="${fila.codestusuasistema}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codestusuasistema}">${fila.descripcion}</option>
                                </c:otherwise>
                               </c:choose>
                             </jsp2:forEach>
                          </select>                      </td>
                      <td class="bgDescTablas"><strong>Permitir Multisesion</strong></td>
                      <td class="bgDescTablas" colspan="2">
                      <c:choose>
                            <c:when test = '${ususismultisesion == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="ususismultisesion" value="S" id="ususismultisesion_0" checked="true" tabindex="15"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="ususismultisesion" value="N" id="ususismultisesion_1" tabindex="15"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="ususismultisesion" value="S" id="ususismultisesion_0" tabindex="15"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="ususismultisesion" value="N" id="ususismultisesion_1" checked="true" tabindex="15"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="7">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                      <td class="bgDescTablas"><strong>Usuario Interno</strong></td>
                      <td class="bgDescTablas" colspan="2">
                      <c:choose>
                            <c:when test = '${ususisinterno == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="ususisinterno" value="S" id="ususisinterno_0" checked="true" tabindex="16"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="ususisinterno" value="N" id="ususisinterno_1" tabindex="16"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="ususisinterno" value="S" id="ususisinterno_0" tabindex="16"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="ususisinterno" value="N" id="ususisinterno_1" checked="true" tabindex="16"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                  </tr>
                <tr>
                <td colspan="7"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="20">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="17"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="18"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="19"/>-->
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
        <jsp:include page="../footer.jsp" />
	</td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    
    Calendar.setup({inputField : "ususisfechacrea",ifFormat : "%d/%m/%Y %H:%M:%S",button : "botonEncuenfecha", showsTime:true, timeFormat:"24",daFormat : "%d/%m/%Y %H:%M:%S"});    
    Calendar.setup({inputField : "ususisfechamodi",ifFormat : "%d/%m/%Y %H:%M:%S",button : "botonususisfechamodi", showsTime:true, timeFormat:"24",daFormat : "%d/%m/%Y %H:%M:%S"});    
    
    //funciones control
    function accion(x)
    {        
        if(validar(arrayNonulos, arrayNumerosEnteros, arrayCombos, arrayCadenasA, arrayComentarios, arrayNumerosDoubles))
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
        llaves = 'ususiscodigo='+document.getElementById('ususiscodigo').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('usuariosistema',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=usuariosistema&";
        url = url + "campos=ususiscodigo,ususisnombre,ususisapellido,grusegcodigo&";
        url = url + "campoLlave=ususiscodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>