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
            var cajas = new Array('codbarrios','nombrebarrio','representante','habitantes','mapa');
            var combos = new Array('codsubgrupos');
            
            //validar
            var arrayNonulos               	= new Array('codbarrios');
            var arrayNumerosEnteros        	= new Array('codbarrios','habitantes');
            var arrayCombos               	= new Array('codsubgrupos');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= new Array('representante');
            var arrayComentarios           	= null;
            var arrayNumerosDoubles             = null;
            
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
            <c:if test='${param.coddepartamento != null && param.codmunicipio !=null && param.codsubgrupo !=null && param.codbarrio !=null && param.coddepartamento != "" && param.codmunicipio !="" && param.codsubgrupo !="" && param.codbarrio !=""}'>
            <sql:query var="r" sql="SELECT * FROM barrio WHERE coddepartamento=${param.coddepartamento} AND codmunicipio=${param.codmunicipio} AND codsubgrupo=${param.codsubgrupo} AND codbarrio=${param.codbarrio}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="coddepartamentof" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipiof" value="${fila.codmunicipio}"/>
              <c:set var="codsubgrupof" value="${fila.codsubgrupo}"/>
              <c:set var="codbarriof" value="${fila.codbarrio}"/>  
              <c:set var="nombrebarrio" value="${fila.nombre}"/>
              <c:set var="representante" value="${fila.representante}"/>
              <c:set var="habitantes" value="${fila.habitantes}"/>
              <c:set var="mapa" value="${fila.mapa}"/>   
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(barrio.archivofi, '${ruta}${mapa}') from barrio where coddepartamento=${param.coddepartamento} AND codmunicipio=${param.codmunicipio} AND codsubgrupo=${param.codsubgrupo} AND codbarrio=${param.codbarrio}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                   
            </jsp2:forEach>
                
                <table width="778" border="0" class="tablaContenido">
		<form action="Barrio.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Barrio</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="26" class="bgDescTablas">&nbsp;</td>
                    <td width="104" class="bgDescTablas"><strong>Sub Grupo Geografico</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codsubgrupos" id="codsubgrupos" style="width: 150px" tabindex="1">
                           <option id="codsubgrupos" value=""></option>
                          <sql:query var="r" sql="select coddepartamento, codmunicipio, codsubgrupo, nombre from subgrupogeografico" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.coddepartamento == coddepartamentof && fila.codmunicipio == codmunicipiof && fila.codsubgrupo == codsubgrupof}'>
                                <option value="${fila.coddepartamento} ${fila.codmunicipio} ${fila.codsubgrupo}" selected="selected">${fila.nombre}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.coddepartamento} ${fila.codmunicipio} ${fila.codsubgrupo}">${fila.nombre}</option>
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
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>C&oacute;digo Barrio</strong></td>
                    <td width="194" class="bgDescTablas"><label>
                    <input name="codbarrios" type="text" id="codbarrios" value="${codbarriof}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'nume')" tabindex="2"/>
                    </label></td>
                    <td width="15" class="bgDescTablas">&nbsp;</td>
                    <td width="83" class="bgDescTablas"><strong>Nombre</strong></td>
                    <td width="220" class="bgDescTablas"><label>
                      <input name="nombrebarrio" type="text" id="nombrebarrio" value="${nombrebarrio}" size="20" maxlength="40" onkeypress="javascript:return permite(event, 'num_car')" tabindex="3"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Representante</strong></td>
                    <td class="bgDescTablas"><input name="representante" type="text" id="representante" value="${representante}" size="20" maxlength="60" onkeypress="javascript:return permite(event, 'carac')" tabindex="4"/></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Habitantes</strong></td>
                    <td class="bgDescTablas"><input name="habitantes" type="text" id="habitantes" value="${habitantes}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Mapa</strong></td>
                    <td class="bgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="mapa" type="text" id="mapa" size="15"  value="${mapa}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();" tabindex="6"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                      <c:if test='${mapa != null}'> <br />
                        <a href="../temp/${mapa}" target="_blank">Descargar ${mapa}</a> </c:if>
                    </span></label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><label></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="coddepartamento" id="coddepartamento" value="" >
                  <input type="hidden" name="codmunicipio" id="codmunicipio" value="" >
                  <input type="hidden" name="codsubgrupo" id="codsubgrupo" value="" >
                  <input type="hidden" name="codbarrio" id="codbarrio" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="10"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="7"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="8"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="9"/> -->
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
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=mapa";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
        var cad = document.getElementById('codsubgrupos').value;                    
        var cad2 = cad.split(" ");
                    
        llaves = 'coddepartamento='+cad2[0]+',';
        llaves+= 'codmunicipio='+cad2[1]+',';
        llaves+= 'codsubgrupo='+cad2[2]+',';
        llaves+= 'codbarrio='+document.getElementById('codbarrios').value;
        validarLlave('barrio',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=barrio&";
        url = url + "campos=coddepartamento,codmunicipio,codsubgrupo,codbarrio,nombre,representante,habitantes&";
        url = url + "campoLlave=coddepartamento,codmunicipio,codsubgrupo,codbarrio";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>