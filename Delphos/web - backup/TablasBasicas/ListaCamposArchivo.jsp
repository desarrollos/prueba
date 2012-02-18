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
            var cajas = new Array('codcampoarchivo','descripcion','formato','nombrecampotabla','nombretabla','codigoalterno','codigoennorma');
            var combos = new Array('tipcamcodigo','codnorma');
		
            //validar
            var arrayNonulos               	= new Array('codcampoarchivo');
            var arrayNumerosEnteros        	= new Array('codcampoarchivo');
            var arrayCombos               	= new Array('tipcamcodigo','codnorma');			
            var arrayCadenasANCod          	= new Array('formato','codigoalterno','codigoennorma');
            var arrayCadenasA              	= new Array('nombrecampotabla','nombretabla');
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
            <c:if test='${param.llave != null && param.llave !=""}'>
            <sql:query var="r" sql="SELECT * FROM listacamposarchivo WHERE codcampoarchivo=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codcampoarchivo" value="${fila.codcampoarchivo}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="tipcamcodigo" value="${fila.tipcamcodigo}"/>
              <c:set var="formato" value="${fila.formato}"/>
              <c:set var="nombrecampotabla" value="${fila.nombrecampotabla}"/>
              <c:set var="nombretabla" value="${fila.nombretabla}"/>    
              <c:set var="codigoalterno" value="${fila.codigoalterno}"/>  
              <c:set var="codigoennorma" value="${fila.codigoennorma}"/>  
              <c:set var="codnorma" value="${fila.codnorma}"/>      
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>  
              <c:set var="fechanorma" value="${fila.fechanorma}"/>        
            </jsp2:forEach>
            <table width="811" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="ListaCamposArchivo.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Listado Campos Archivo</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30" class="bgDescTablas">&nbsp;</td>
                <td width="139" class="bgDescTablas"><strong>C&oacute;digo Campo Archivo</strong></td>
                <td width="190"><label>
                  <input name="codcampoarchivo" type="text" id="codcampoarchivo" value="${codcampoarchivo}" size="20" maxlength="4" onKeyPress="javascript:return permite(event, 'nume')" tabindex="1">
                </label></td>
                <td width="11">&nbsp;</td>
                <td width="102"><strong class="bgDescTablas">C&oacute;digo Alterno</strong></td>
                <td width="204"><label>
                  <input name="codigoalterno" type="text" id="codigoalterno" value="${codigoalterno}" size="20" maxlength="10" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tipo Campo</strong></td>
                <td><label>
                  <select name="tipcamcodigo" id="tipcamcodigo" style="width: 150px" tabindex="3">
                    <option id="tipcamcodigo" value=""></option>
                    <sql:query var="r" sql="select tipcamcodigo, tipcamdescripc from tipocampo" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.tipcamcodigo == tipcamcodigo}'>
                          <option value="${fila.tipcamcodigo}" selected="selected">${fila.tipcamdescripc}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.tipcamcodigo}">${fila.tipcamdescripc}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Formato</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label>
                  <input name="formato" type="text" id="formato" value="${formato}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="4">
                  </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Nombre Campo Tabla</strong></td>
                <td><label>
                  <input name="nombrecampotabla" type="text" id="nombrecampotabla" value="${nombrecampotabla}" size="20" maxlength="40" onKeyPress="javascript:return permite(event, 'carac')" tabindex="5">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Nombre Tabla</strong></td>
                <td><label>
                  <input name="nombretabla" type="text" id="nombretabla" value="${nombretabla}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'carac')" tabindex="6">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Codigo Asigando Por Norma</strong></td>
                <td colspan="4"><label>
                  <input name="codigoennorma" type="text" id="codigoennorma" value="${codigoennorma}" size="20" maxlength="10" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="7">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Norma</strong></td>
                <td colspan="4"><select name="codnorma" id="codnorma" style="width: 150px" tabindex="8">
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
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                <p align="center">
                  <label>
                  <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" onKeyPress="javascript:return permite(event, 'com')" tabindex="9">
                  </label>
                </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="13"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="10"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="11"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="12"/> -->
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
        llaves = 'codcampoarchivo='+document.getElementById('codcampoarchivo').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('listacamposarchivo',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=listacamposarchivo&";
        url = url + "campos=codcampoarchivo,descripcion,tipcamcodigo,formato,nombrecampotabla,nombretabla,codigoalterno,codigoennorma&";
        url = url + "campoLlave=codcampoarchivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>