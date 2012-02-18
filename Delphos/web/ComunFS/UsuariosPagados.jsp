<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
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
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            //totalidad de elementos en el form
            var cajas = new Array('diaspago','valordias','observacion');
            var combos = new Array('nroordens','idusuarios');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = new Array('diaspago');
            var arrayCombos                = new Array('nroordens','idusuarios');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('observacion');
            var arrayNumerosDoubles        = new Array('valordias');
            
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
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <c:if test='${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.nroorden != null && param.idusuario != null && param.idusuario != ""}'>
            <sql:query var="r" sql="SELECT * FROM usuariospagocto WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND nroorden='${param.nroorden}' AND idusuario=${param.idusuario}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="nroordenf" value="${fila.nroorden}"/>
              <c:set var="idusuariof" value="${fila.idusuario}"/>              
              <c:set var="diaspago" value="${fila.diaspago}"/>
              <c:set var="valordias" value="${fila.valordias}"/>  
              <c:set var="observacion" value="${fila.observacion}"/>
            </jsp2:forEach>
                
                <table width="741" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="UsuariosPagados.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Usuarios Pagados </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="93" class="bgDescTablas"><strong class="bgDescTablas">No. Orden</strong></td>
                    <td width="164" class="sinBgDescTablas"><label>
                      <select name="nroordens" id="nroordens" style="width: 150px">
                        <option id="nroordens" value=""></option>
                        <sql:query var="r" sql="select codcontrato, codregimenes, codentidadsalud, nroorden from pagosecretariacto" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf && fila.codcontrato == codcontratof && fila.nroorden == nroordenf}'>
                              <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.nroorden}" selected="selected">${fila.codcontrato}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.nroorden}">${fila.codcontrato}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td width="28">&nbsp;</td>
                    <td width="102" class="bgDescTablas"><p><strong>Id. Usuario</strong></p></td>
                    <td width="225" class="sinBgDescTablas">
                    <p>
                      <select name="idusuarios" id="idusuarios" style="width: 150px">
                         <option id="idusuarios" value=""></option>
                              <sql:query var="r" sql="select idusuario from poblacion" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.idusuario == idusuariof}'>
                                    <option value="${fila.idusuario}" selected="selected">${fila.idusuario}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.idusuario}">${fila.idusuario}</option>
                                </c:otherwise>
                               </c:choose>
                        </jsp2:forEach>
                      </select>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>D&iacute;as a Pagar</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="diaspago" type="text" id="diaspago" value="${diaspago}" size="20" maxlength="4" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor D&iacute;as</strong></td>
                    <td class="sinBgDescTablas"><input name="valordias" type="text" id="valordias" value="${valordias}" size="20" maxlength="15" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas"> 
                        <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
                      </p></td>
                  </tr>
             <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="nroorden" id="nroorden" value="" >
                  <input type="hidden" name="idusuario" id="idusuario" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->
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
        var cad = document.getElementById('nroordens').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		llaves+= 'nroorden='+cad2[3]+',';
		
		llaves+= 'idusuario='+document.getElementById('idusuarios').value;
        validarLlave('usuariospagocto',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=usuariospagocto&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,nroorden,idusuario,diaspago,valordias&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,nroorden,idusuario";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>