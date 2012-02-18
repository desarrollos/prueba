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
            var cajas = new Array('codbanco','descripcion');
            var combos = new Array('codempresa','codtipoentfinanciera');
            
            //validar
            var arrayNonulos               	= new Array('codbanco');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codempresa','codtipoentfinanciera');
            var arrayCadenasANCod          	= new Array('codbanco');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
            var arrayNumerosDoubles         = null;
            
	</script></head>
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
            <sql:query var="r" sql="SELECT * FROM banco WHERE codbanco='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codbanco" value="${fila.codbanco}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="codempresa" value="${fila.codempresa}"/>
              <c:set var="codtipoentfinanciera" value="${fila.codtipoentfinanciera}"/>          
            </jsp2:forEach>
          <table width="811" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="Banco.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Banco</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="27" class="bgDescTablas">&nbsp;</td>
                <td width="119" class="bgDescTablas"><strong>C&oacute;digo Banco</strong></td>
                <td width="171"><input name="codbanco" type="text" id="codbanco" value="${codbanco}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="1"></td>
                <td width="18">&nbsp;</td>
                <td width="124"><strong class="bgDescTablas">Tipo Entidad Financiera</strong></td>
                <td width="183"><label>
                  <select name="codtipoentfinanciera" id="codtipoentfinanciera" style="width: 150px" tabindex="2">
                  <option id="codtipoentfinanciera" value=""></option>
                  <sql:query var="r" sql="select codtipoentfinanciera, descripcion from tipoentfinanciera" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoentfinanciera == codtipoentfinanciera}'>
                        <option value="${fila.codtipoentfinanciera}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoentfinanciera}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                  </select>
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Empresa</strong></td>
                <td colspan="4"><label>
                  <select name="codempresa" id="codempresa" style="width: 150px" tabindex="3">
                  <option id="codempresa" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codempresa == codempresa}'>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                  </select>
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                <p align="center"><strong>
                  <label>
                  <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onKeyPress="javascript:return permite(event, 'com')" tabindex="4">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="8"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="5"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="6"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="7"/> -->
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
		llaves = 'codbanco='+document.getElementById('codbanco').value;
        validarLlave('banco',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=banco&";
        url = url + "campos=codbanco,descripcion,codtipoidentidad,codempresa,codtipoentfinanciera&";
        url = url + "campoLlave=codbanco";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>