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
            var cajas = new Array('coddepartamento','habitantes','nombredepartamento','gobernador','secretariosalud');
            var combos = null;
            
            //validar
            var arrayNonulos               = new Array('coddepartamento');
            var arrayNumerosEnteros        = new Array('coddepartamento','habitantes');
            var arrayCombos                = null;
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = new Array('nombredepartamento','gobernador','secretariosalud')
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
			
			//var arrayArchivos = new Array('mapa');
			
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
            <sql:query var="r" sql="SELECT * FROM departamento WHERE coddepartamento=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="nombredepartamento" value="${fila.nombre}"/>
              <c:set var="gobernador" value="${fila.gobernador}"/>    
              <c:set var="secretariosalud" value="${fila.secretariosalud}"/> 
              <c:set var="habitantes" value="${fila.habitantes}"/> 
              <c:set var="mapa" value="${fila.mapa}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(departamento.archivofi, '${ruta}${mapa}') from departamento where coddepartamento=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                    
            </jsp2:forEach>
                
                <table width="828" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="Departamento.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Departamento</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="156" class="bgDescTablas"><strong>C&oacute;digo Departamento</strong></td>
                    <td width="148" class="bgDescTablas"><input name="coddepartamento" type="text" id="coddepartamento" value="${coddepartamento}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="1"/></td>
                    <td width="23" class="bgDescTablas">&nbsp;</td>
                    <td width="115" class="bgDescTablas"><strong>Nombre</strong></td>
<td width="204" class="bgDescTablas"><label>
                      <input name="nombredepartamento" type="text" id="nombredepartamento" value="${nombredepartamento}" size="20" maxlength="30" onkeypress="javascript:return permite(event, 'carac')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Gobernador</strong></td>
<td class="bgDescTablas"><label>
                      <input name="gobernador" type="text" id="gobernador" value="${gobernador}" size="20" maxlength="60" onkeypress="javascript:return permite(event, 'carac')" tabindex="3"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Secretario Salud</strong></td>
<td class="bgDescTablas"><label>
<input name="secretariosalud" type="text" id="secretariosalud" value="${secretariosalud}" size="20" maxlength="60" onkeypress="javascript:return permite(event, 'carac')" tabindex="4"/>
</label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Habitantes</strong></td>
<td class="bgDescTablas"><label>
                      <input name="habitantes" type="text" id="habitantes" value="${habitantes}" size="20" maxlength="8" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Mapa</strong></td>
                    <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                      <input name="mapa" type="text" id="mapa" size="15"  value="${mapa}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();" tabindex="6"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                      <c:if test='${mapa != null}'> <br />
                        <a href="../temp/${mapa}" target="_blank">Descargar ${mapa}</a> </c:if>
                    </span></td>
              </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><label></label></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        llaves = 'coddepartamento='+document.getElementById('coddepartamento').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('departamento',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=departamento&";
        url = url + "campos=coddepartamento,nombre,gobernador,secretariosalud,habitantes&";
        url = url + "campoLlave=coddepartamento";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>