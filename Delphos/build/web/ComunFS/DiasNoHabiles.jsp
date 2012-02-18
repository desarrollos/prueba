<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
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
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>

        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script><script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            function configurar()
            {
			Calendar.setup({inputField : "fechanohabil",ifFormat : "%d/%m/%Y",button : "botonFechanohabil", daFormat : "%d/%m/%Y"});
	    }
            
            //totalidad de elementos en el form
            var cajas = new Array('fechanohabil');
            var combos = new Array('tipo');
            
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('tipo');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= null;

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
            <c:if test='${param.llave != null && param.llave !=""}'>
            <sql:query var="r" sql="SELECT * FROM diasnohabiles WHERE fechanohabil='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <fmt:formatDate value="${fila.fechanohabil}" pattern="dd/MM/yyyy" dateStyle="short" var="fechanohabil"/>
              <c:set var="tipo" value="${fila.tipo}"/>  
 
            </jsp2:forEach>
          <table width="784" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="DiasNoHabiles.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">D&iacute;as No H&aacute;biles</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="50" class="bgDescTablas">&nbsp;</td>
                <td width="119" class="bgDescTablas"><strong>Fecha No H&aacute;bil</strong>
                <label></label></td>
                <td width="138" class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <input type="text" size="15" name="fechanohabil" id="fechanohabil" readonly="readonly"  value="${fechanohabil}"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="botonFechanohabil" type="button" id="botonFechanohabil" value="..." tabindex="1"/>
                  </span></span></td>
                <td width="26" class="bgDescTablas">&nbsp;</td>
                <td width="44" class="bgDescTablas"><strong>Tipo</strong></td>
                <td width="266" class="bgDescTablas"><label>
                  <select name="tipo" id="tipo" tabindex="2">
                    <option id="tipo" value=""> </option>
                    <c:if test='${tipo == "D"}'>
                       <option value="D" selected>Dominical</option>
                        <option value="F">Festivo</option>
                        <option value="N">No H&aacute;bil</option> 
                    </c:if>
                    <c:if test='${tipo == "F"}'>
                       <option value="D">Dominical</option>
                        <option value="F" selected>Festivo</option>
                        <option value="N">No H&aacute;bil</option> 
                    </c:if>
                    <c:if test='${tipo == "N"}'>
                       <option value="D">Dominical</option>
                        <option value="F">Festivo</option>
                        <option value="N" selected>No H&aacute;bil</option> 
                    </c:if>
                    <c:if test='${tipo == "" || tipo == null}'>
                        <option value="D">Dominical</option>
                        <option value="F">Festivo</option>
                        <option value="N">No H&aacute;bil</option>
                    </c:if>
                    
                  </select>
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3"/>
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
        <jsp:include page="../footer.jsp" />  </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    configurar();
    
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
        var fini = document.getElementById('fechanohabil').value;
        var f = fini.substring(6,10)+"-"+fini.substring(3,5)+"-"+fini.substring(0,2);
        llaves = 'fechanohabil='+f;
        validarLlave('diasnohabiles',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=diasnohabiles&";
        url = url + "campos=fechanohabil,tipo&";
        url = url + "campoLlave=fechanohabil";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>