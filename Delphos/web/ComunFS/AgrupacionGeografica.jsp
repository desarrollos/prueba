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
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
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
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('codareageografica','descripcion','habitantes','mapa');
            var combos = null;
                        
            //validar
            var arrayNonulos               	= new Array('codareageografica');
            var arrayNumerosEnteros        	= new Array('codareageografica','habitantes');
            var arrayCombos               	= null;
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion','mapa');
            var arrayNumerosDoubles         = null;
			
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
            <c:if test='${param.llave != null && param.llave !=""}'>
            <sql:query var="r" sql="SELECT * FROM agrupaciongeografica WHERE codareageografica=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codareageografica" value="${fila.codareageografica}"/>
              <c:set var="regionoficial" value="${fila.regionoficial}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="habitantes" value="${fila.habitantes}"/>  
              <c:set var="mapa" value="${fila.mapa}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(agrupaciongeografica.archivofi, '${ruta}${mapa}') from agrupaciongeografica where codareageografica=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                     
            </jsp2:forEach>
                
                <table width="789" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="AgrupacionGeografica.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Agrupaci&oacute;n Geogr&aacute;fica</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="117" class="bgDescTablas"><strong>C&oacute;digo Agrupaci&oacute;n</strong></td>
                    <td width="172" class="bgDescTablas"><input name="codareageografica" type="text" id="codareageografica" tabindex="1" onKeyPress="javascript:return permite(event, 'nume');" value="${codareageografica}" size="20" maxlength="6"/></td>
                    <td width="25" class="bgDescTablas">&nbsp;</td>
                    <td width="143" class="bgDescTablas"><strong>&iquest; Es Region Oficial?</strong></td>
                  <td width="189" class="bgDescTablas">     
      					<c:choose>
                            <c:when test = '${regionoficial == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input name="regionoficial" type="radio" id="regionoficial_0" value="S" checked="checked" tabindex="2"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="regionoficial" value="N" id="regionoficial_1" tabindex="2"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="regionoficial" value="S" id="regionoficial_0" tabindex="2"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="regionoficial" value="N" id="regionoficial_1" checked="true" tabindex="2"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>                    </td>
              </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><label></label></td>
                    <td class="bgDescTablas"><strong>Habitantes</strong></td>
                    <td class="bgDescTablas"><input name="habitantes" type="text" id="habitantes" tabindex="3" onkeypress="javascript:return permite(event, 'nume');" value="${habitantes}" size="20" maxlength="8"/></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Mapa</strong></td>
                    <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                      <input name="mapa" type="text" id="mapa" size="15"  value="${mapa}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${mapa != null && mapa != ""}'><br>
                        <a href="../temp/${mapa}" target="_blank">Descargar ${mapa}</a> </c:if>
                    </span></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <input name="descripcion" type="text" id="descripcion" tabindex="5" onkeypress="javascript:return permite(event, 'com');" value="${descripcion}" size="75" maxlength="40"/>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                 <!-- <input type="button" onClick="buscar();" value="Buscar" tabindex="9" > -->
		  <label>&nbsp;</label>
               <!--   <input name="guardar2" type="button" id="guardar2" tabindex="6" onClick="accion(1);" value="Guardar" />
                  <input name="editar" type="button" id="editar" tabindex="7" onClick="accion(2);" value="Actualizar" />
                  <input name="eliminar" type="button" id="eliminar" tabindex="8" onClick="accion(3);" value="Eliminar" /> -->
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
        llaves = 'codareageografica='+document.getElementById('codareageografica').value;
        validarLlave('agrupaciongeografica',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=agrupaciongeografica&";
        url = url + "campos=codareageografica,descripcion,regionoficial,habitantes&";
        url = url + "campoLlave=codareageografica";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>