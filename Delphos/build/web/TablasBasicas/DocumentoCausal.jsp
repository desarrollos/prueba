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
            var cajas = new Array ('doccauobserv');
            var combos = new Array ('novcaucodigos','codtipodctoasociados');
            
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('novcaucodigos','codtipodctoasociados');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('doccauobserv');
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
            <c:if test="${param.codtiponovedad != null && param.novcaucodigo != null && param.codtipodctoasociado != null}">
            <sql:query var="r" sql="SELECT * FROM documentocausal WHERE codtiponovedad='${param.codtiponovedad}' AND novcaucodigo='${param.novcaucodigo}' AND codtipodctoasociado='${param.codtipodctoasociado}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtiponovedad" value="${fila.codtiponovedad}"/>
              <c:set var="novcaucodigof" value="${fila.novcaucodigo}"/>
              <c:set var="codtipodctoasociadof" value="${fila.codtipodctoasociado}"/>
              <c:set var="doccauobserv" value="${fila.doccauobserv}"/>          
            </jsp2:forEach>
                
                <table width="799" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="DocumentoCausal.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Documento Causal</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="127" class="bgDescTablas"><strong>Novedad</strong></td>
                    <td width="179" class="bgDescTablas">
                    <select name="novcaucodigos" id="novcaucodigos" style="width: 150px" tabindex="1">
                      <option id="novcaucodigos" value=""></option>
                      <sql:query var="r" sql="select codtiponovedad, novcaucodigo, novcaudescri from novedadcausal" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codtiponovedad == codtiponovedad && fila.novcaucodigo == novcaucodigof}'>
                            <option value="${fila.codtiponovedad} ${fila.novcaucodigo}" selected="selected">${fila.novcaudescri}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codtiponovedad} ${fila.novcaucodigo}">${fila.novcaudescri}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td width="18" class="bgDescTablas">&nbsp;</td>
                    <td width="137" class="bgDescTablas"><strong>Tipo Documento Asociado</strong></td>
                    <td width="185" class="bgDescTablas"><label>
                    <select name="codtipodctoasociados" id="codtipodctoasociados" style="width: 150px" tabindex="2">
                          <option id="codtipodctoasociados" value=""></option>
                          <sql:query var="r" sql="select codtipodctoasociado, descripcion from tipodctoasociado" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipodctoasociado == codtipodctoasociadof}'>
                                <option value="${fila.codtipodctoasociado}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipodctoasociado}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center">
                      <label>
                      <textarea name="doccauobserv" id="doccauobserv" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="3">${doccauobserv}</textarea>
                      </label>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtiponovedad" id="codtiponovedad" value="" >
                  <input type="hidden" name="novcaucodigo" id="novcaucodigo" value="" >
                  <input type="hidden" name="codtipodctoasociado" id="codtipodctoasociado" value="" >
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
        var cad = document.getElementById('novcaucodigos').value;
        var cad2 = cad.split(" ");
        
        llaves = 'novcaucodigo='+cad2[1]+',';
	llaves+= 'codtipodctoasociado='+document.getElementById('codtipodctoasociados').value+',';
        llaves+= 'codtiponovedad='+cad2[0];
        validarLlave('documentocausal',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=documentocausal&";
        url = url + "campos=codtiponovedad,novcaucodigo,codtipodctoasociado,doccauobserv&";
        url = url + "campoLlave=codtiponovedad,novcaucodigo,codtipodctoasociado";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>