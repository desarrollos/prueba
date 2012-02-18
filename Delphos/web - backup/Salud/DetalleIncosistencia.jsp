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
            var cajas = new Array('descripcion');
            var combos = new Array('idregistro','codcampoarchivo','codtipoincarch');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('idregistro','codcampoarchivo','codtipoincarch');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('descripcion');
            var arrayNumerosDoubles        = null;
            
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
            <c:if test='${param.idregistro != null && param.idregistro != "" && param.codcampoarchivo != null && param.codcampoarchivo != "" && param.idencabezado != null && param.idencabezado != ""}'>
            <sql:query var="r" sql="SELECT * FROM inconarchafil WHERE idregistro=${param.idregistro} AND codcampoarchivo=${param.codcampoarchivo} AND idencabezado=${param.idencabezado}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idregistrof" value="${fila.idregistro}"/>
              <c:set var="codcampoarchivof" value="${fila.codcampoarchivo}"/>
              <c:set var="idencabezadof" value="${fila.idencabezado}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="codtipoincarch" value="${fila.codtipoincarch}"/>
              
            </jsp2:forEach>
                
                <table width="784" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="DetalleIncosistencia.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Detalle Inconsistencia</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27" class="bgDescTablas">&nbsp;</td>
                    <td width="121" class="bgDescTablas"><strong>Id. Registro</strong></td>
                    <td width="169" class="sinBgDescTablas"><label>
                    <select name="idregistros" id="idregistros" style="width: 150px">
                       <option id="idregistros" value=""></option>
                          <sql:query var="r" sql="select idregistro, idencabezado from poblacionperiodica" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.idregistro == idregistrof && fila.idencabezado == idencabezadof}'>
                                <option value="${fila.idregistro} ${fila.idencabezado}" selected="selected">${fila.idregistro}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.idregistro} ${fila.idencabezado}">${fila.idregistro}</option>
                            </c:otherwise>
                           </c:choose>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="22">&nbsp;</td>
                    <td width="109" class="bgDescTablas"><strong>Campo Archivo</strong></td>
                  <td width="194" class="sinBgDescTablas"><label>
                      <select name="codcampoarchivos" id="codcampoarchivos" style="width: 150px">
                      <option id="codcampoarchivos" value=""></option>
                          <sql:query var="r" sql="select codcampoarchivo, descripcion from listacamposarchivo" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codcampoarchivo == codcampoarchivof}'>
                                <option value="${fila.codcampoarchivo}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codcampoarchivo}">${fila.descripcion}</option>
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
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Tipo Inconsistencia</strong></td>
              <td colspan="4"><label>
              <select name="codtipoincarch" id="codtipoincarch" style="width: 150px">
               <option id="codtipoincarch" value=""></option>
                    <sql:query var="r" sql="select codtipoincarch, descripcion from tipoincarchivo" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                       <c:choose>
                            <c:when test='${fila.codtipoincarch == codtipoincarch}'>
                            <option value="${fila.codtipoincarch}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                        <c:otherwise>
                            <option value="${fila.codtipoincarch}">${fila.descripcion}</option>
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
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <label>
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" />
                      </label>
                    </p></td>
                  </tr>
            <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="idregistro" id="idregistro" value="" >
                  <input type="hidden" name="codcampoarchivo" id="codcampoarchivo" value="" >
                  <input type="hidden" name="idencabezado" id="idencabezado" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
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
        var cad = document.getElementById('idregistros').value;
        var cad2 = cad.split(" ");
		
        llaves = 'idregistro='+cad2[0]+',';
		llaves+= 'codcampoarchivo='+document.getElementById('codcampoarchivos').value+',';
		llaves+= 'idencabezado='+cad2[1];
		validarLlave('inconarchafil',llaves);
		
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=inconarchafil&";
        url = url + "campos=idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch&";
        url = url + "campoLlave=idregistro,codcampoarchivo,idencabezado";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>