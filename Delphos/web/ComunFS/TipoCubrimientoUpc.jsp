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
            var cajas = new Array('codtipocubrimupcs','descripcion','porcupc');
            var combos = new Array('codregimens','codnorma');
            
            //validar
            var arrayNonulos               	= new Array ('codtipocubrimupcs');
			var arrayNumerosEnteros        	= null;
			var arrayCombos               	= new Array ('codregimens','codnorma');			
			var arrayCadenasANCod          	= new Array ('codtipocubrimupcs');
			var arrayCadenasA              	= null;
			var arrayComentarios           	= new Array ('descripcion');
			var arrayNumerosDoubles        	= new Array ('porcupc')

            
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
            <c:if test="${param.codregimen != null && param.codtipocubrimupc != null}">
            <sql:query var="r" sql="SELECT * FROM tipocubrimientoupc WHERE codregimen='${param.codregimen}' AND codtipocubrimupc='${param.codtipocubrimupc}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenf" value="${fila.codregimen}"/>
              <c:set var="codtipocubrimupcf" value="${fila.codtipocubrimupc}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="porcupc" value="${fila.porcupc}"/>             
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>
              <c:set var="codnorma" value="${fila.codnorma}"/>
              <c:set var="fechanorma" value="${fila.fechanorma}"/>             
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="TipoCubrimientoUpc.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Tipo Cubrimiento UPC</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Regimen</strong></span></td>
                <td><select name="codregimens" id="codregimens" style="width: 150px" tabindex="1">
                  <option id="codregimens" value=""></option>
                  <sql:query var="r" sql="select codregimen, descripcion from regimen" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codregimen == codregimenf}'>
                        <option value="${fila.codregimen}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimen}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Tipo Cubrimiento</strong></td>
                <td><label>
                  <input name="codtipocubrimupcs" type="text" id="codtipocubrimupcs" value="${codtipocubrimupcf}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="98"><span class="bgDescTablas"><strong>Norma</strong></span></td>
                <td width="183"><label>
                  <select name="codnorma" id="codnorma" style="width: 150px" tabindex="3">
                    <option id="codnorma" value=""></option>
                    <sql:query var="r" sql="select codtiponorma, codnorma, fechanorma, referencia from normas" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtiponorma == codtiponorma && fila.codnorma == codnorma && fila.fechanorma == fechanorma}'>
                          <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}" selected="selected">${fila.referencia}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}">${fila.referencia}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </label></td>
                <td width="24">&nbsp;</td>
                <td width="131" class="bgDescTablas"><strong><strong>Porcentaje</strong></strong></td>
                <td width="181"><input name="porcupc" type="text" id="porcupc" value="${porcupc}" size="20" maxlength="8" onKeyPress="javascript:return permite(event, 'numd')" tabindex="4"></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Descripci&oacute;n</strong></p>
                  <p align="center">
                    <label>
                    <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" onKeyPress="javascript:return permite(event, 'com')" tabindex="5">
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimen" id="codregimen" value="" >
                  <input type="hidden" name="codtipocubrimupc" id="codtipocubrimupc" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="9">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="6"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="7"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="8"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
          </table>
        </form>
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
        llaves = 'codregimen='+document.getElementById('codregimens').value+',';
		llaves+= 'codtipocubrimupc='+document.getElementById('codtipocubrimupcs').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('tipocubrimientoupc',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=tipocubrimientoupc&";
        url = url + "campos=codregimen,codtipocubrimupc,descripcion,porcupc,codtiponorma,codnorma,fechanorma&";
        url = url + "campoLlave=codregimen,codtipocubrimupc";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>