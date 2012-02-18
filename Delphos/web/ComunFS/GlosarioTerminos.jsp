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
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('codglorario','descripcion');
            var combos = new Array('codnorma');
			
            var arrayNonulos               	= new Array('codglorario');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codnorma');			
            var arrayCadenasANCod          	= new Array('codglorario');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM glosarioterminos WHERE codglorario='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codglorario" value="${fila.codglorario}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="codnorma" value="${fila.codnorma}"/>      
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>  
              <c:set var="fechanorma" value="${fila.fechanorma}"/>        
            </jsp2:forEach>
            <table width="786" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="GlosarioTerminos.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="3"><div align="center" class="titulo1">Glosario T&eacute;rminos</div></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td width="28" class="bgDescTablas">&nbsp;</td>
                <td width="121" class="bgDescTablas"><strong>C&oacute;digo Glosario</strong></td>
                <td width="505"><label>
                  <input name="codglorario" type="text" id="codglorario" value="${codglorario}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="1">
                </label></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Norma</strong></td>
                <td><select name="codnorma" id="codnorma" style="width: 150px" tabindex="2">
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
                </select></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                <p align="center">
                  <label>
                  <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onKeyPress="javascript:return permite(event, 'com')" tabindex="3">
                  </label>
                </p></td>
              </tr>
              <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        llaves = 'codglorario='+document.getElementById('codglorario').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('glosarioterminos',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=glosarioterminos&";
        url = url + "campos=codglorario,descripcion,codtiponorma,codnorma,fechanorma&";
        url = url + "campoLlave=codglorario";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>