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
            var cajas = new Array('codactividadeconomica','descripcion');
            var combos = null;
                      
            //validar
            var arrayNonulos               = new Array('codactividadeconomica');
            var arrayNumerosEnteros        = null;
            var arrayCombos                = null;
            var arrayCadenasANCod          = new Array('codactividadeconomica');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('descripcion');
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
            <sql:query var="r" sql="SELECT * FROM actividadeconomica WHERE codactividadeconomica='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codactividadeconomica" value="${fila.codactividadeconomica}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>  
 
            </jsp2:forEach>
          <table width="795" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="ActividadEconomica.jsp" >
              <span id="mensajeControlador">${msj}</span>
                <tr>
                  <td colspan="3"><div align="center" class="titulo1">Actividad Economica</div></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td width="45" class="bgDescTablas">&nbsp;</td>
                <td width="127" class="bgDescTablas"><strong>C&oacute;digo Actividad Economica</strong>
                <label></label></td>
                <td width="482" class="bgDescTablas"><input name="codactividadeconomica" type="text" id="codactividadeconomica" onKeyPress="javascript:return permite(event, 'num_car_cod')" value="${codactividadeconomica}" size="20" maxlength="6" tabindex="1">
                <label></label></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3"><p align="center"><strong class="bgDescTablas">Descripci&oacute;n</strong></p>
                <p align="center"><strong>
                  <label>
                  <textarea name="descripcion" cols="75" rows="3" id="descripcion" onKeyPress="javascript:return permite(event, 'com')" tabindex="2">${descripcion}</textarea>
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
		  <label>&nbsp;</label>
          <%--
                  <input type="button" onClick="buscar();" value="Buscar" tabindex="17">
		  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/>
                  --%>
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
        llaves = 'codactividadeconomica='+document.getElementById('codactividadeconomica').value;
        validarLlave('actividadeconomica',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadeconomica&";
        url = url + "campos=codactividadeconomica,descripcion&";
        url = url + "campoLlave=codactividadeconomica";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }  
    
</script>
</body>
</html>