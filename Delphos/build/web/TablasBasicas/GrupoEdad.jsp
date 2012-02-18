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
            var cajas = new Array('descripcion','codgrupoedads','edadinicial','edadfinal');
            var combos = new Array('codtipogrupoedads');
			
            var arrayNonulos               	= new Array('codgrupoedads');
            var arrayNumerosEnteros        	= new Array('codgrupoedads','edadinicial','edadfinal');
            var arrayCombos               	= new Array('codtipogrupoedads');			
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
            var arrayNumerosDoubles        	= null;

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
            <c:if test='${param.codtipogrupoedad != null && param.codgrupoedad != null && param.codgrupoedad != ""}'>
            <sql:query var="r" sql="SELECT * FROM grupoedad WHERE codtipogrupoedad='${param.codtipogrupoedad}' AND codgrupoedad=${param.codgrupoedad}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipogrupoedadf" value="${fila.codtipogrupoedad}"/>
              <c:set var="codgrupoedadf" value="${fila.codgrupoedad}"/>    
              <c:set var="descripcion" value="${fila.descripcion}"/> 
              <c:set var="edadinicial" value="${fila.edadinicial}"/> 
              <c:set var="edadfinal" value="${fila.edadfinal}"/>      
            </jsp2:forEach>
                
                <table width="796" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="GrupoEdad.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Grupo Edad</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="124" class="bgDescTablas"><strong>Tipo Grupo Edad</strong></td>
                    <td width="166" class="bgDescTablas"><label>
                      <select name="codtipogrupoedads" id="codtipogrupoedads" style="width: 150px"tabindex="1">
                          <option id="codtipogrupoedads" value=""></option>
                          <sql:query var="r" sql="select codtipogrupoedad, descripcion from tipogrupoedad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipogrupoedad == codtipogrupoedadf}'>
                                <option value="${fila.codtipogrupoedad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipogrupoedad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="26" class="bgDescTablas">&nbsp;</td>
                    <td width="150" class="bgDescTablas"><strong>C&oacute;digo Grupo Edad</strong></td>
                    <td width="180" class="bgDescTablas"><label>
                      <input name="codgrupoedads" type="text" id="codgrupoedads" value="${codgrupoedadf}" size="20" maxlength="2" onkeypress="javascript:return permite(event, 'nume')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Inicial</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="edadinicial" type="text" id="edadinicial" value="${edadinicial}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="3"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Final</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="edadfinal" type="text" id="edadfinal" value="${edadfinal}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="4"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="40" onkeypress="javascript:return permite(event, 'com')" tabindex="5"/>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipogrupoedad" id="codtipogrupoedad" value="" >
                  <input type="hidden" name="codgrupoedad" id="codgrupoedad" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="9"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="6"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="7"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="8"/> -->
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
        llaves = 'codtipogrupoedad='+document.getElementById('codtipogrupoedads').value+',';
	llaves+= 'codgrupoedad='+document.getElementById('codgrupoedads').value;
        validarLlave('grupoedad',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=grupoedad&";
        url = url + "campos=codtipogrupoedad,codgrupoedad,descripcion,edadinicial,edadfinal&";
        url = url + "campoLlave=codtipogrupoedad,codgrupoedad";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>