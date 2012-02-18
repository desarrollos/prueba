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
            var cajas = new Array('codcausaltraslado','descripcion');
            var combos = new Array('codtipocausatrasl');
            
            //validar
            var arrayNonulos               	= new Array('codcausaltraslado');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipocausatrasl');
            var arrayCadenasANCod          	= new Array('codcausaltraslado');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
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
            <c:if test="${param.codtipocausatrasl != null && param.codcausaltraslado != null}">
            <sql:query var="r" sql="SELECT * FROM causaltraslado WHERE codtipocausatrasl='${param.codtipocausatrasl}' AND codcausaltraslado='${param.codcausaltraslado}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipocausatrasl" value="${fila.codtipocausatrasl}"/>
              <c:set var="codcausaltraslado" value="${fila.codcausaltraslado}"/>   
              <c:set var="descripcion" value="${fila.descripcion}"/>     
            </jsp2:forEach>
            
                <table width="795" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="CausalTraslado.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Causal traslado</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="108" class="bgDescTablas"><strong>Tipo Causal</strong></td>
                    <td width="225" class="bgDescTablas"><label>
                      <select name="codtipocausatrasl" id="codtipocausatrasl" style="width: 150px" tabindex="1">
                          <option id="codtipocausatrasl" value=""></option>
                        <sql:query var="r" sql="select codtipocausatrasl, descripcion from tipocausatraslado" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codtipocausatrasl == codtipocausatrasl}'>
                               <option value="${fila.codtipocausatrasl}" selected="selected">${fila.descripcion}</option>
                             </c:when>
                            <c:otherwise>
                        <option value="${fila.codtipocausatrasl}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="15" class="bgDescTablas">&nbsp;</td>
                    <td width="111" class="bgDescTablas"><strong>C&oacute;digo Causal Traslado</strong></td>
                    <td width="187" class="bgDescTablas">
                        <input type="text" name="codcausaltraslado" id="codcausaltraslado" value="${codcausaltraslado}" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <textarea name="descripcion" id="descripcion" cols="75" rows="3" onKeyPress="javascript:return permite(event, 'com')" tabindex="3">${descripcion}</textarea>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="codtipocausatrasl" id="codtipocausatrasl" value="" >
                  <input type="hidden" name="codcausaltraslado" id="codcausaltraslado" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="7"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="4"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="5"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="6"/> -->
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
        llaves = 'codtipocausatrasl='+document.getElementById('codtipocausatrasl').value+',';
	llaves+= 'codcausaltraslado='+document.getElementById('codcausaltraslado').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('causaltraslado',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=causaltraslado&";
        url = url + "campos=codtipocausatrasl,codcausaltraslado,descripcion&";
        url = url + "campoLlave=codtipocausatrasl,codcausaltraslado";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>