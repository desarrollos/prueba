<!--
	Familias en accion
-->
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
            var cajas = new Array('quedocarchi');
            var combos = new Array('quejconsecuts','codtipodctoasociados');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('quejconsecuts','codtipodctoasociados');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('quedocarchi');
            var arrayNumerosDoubles        	= null;
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
            <c:if test='${param.codunifami != null && param.quejconsecut != null && param.codtipodctoasociado != null && param.quejconsecut != ""}'>
            <sql:query var="r" sql="SELECT * FROM quejadocumento WHERE codunifami='${param.codunifami}' AND quejconsecut=${param.quejconsecut} AND codtipodctoasociado='${param.codtipodctoasociado}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="quejconsecutf" value="${fila.quejconsecut}"/>
              <c:set var="codtipodctoasociadof" value="${fila.codtipodctoasociado}"/>
              <c:set var="quedocentreg" value="${fila.quedocentreg}"/>
              <c:set var="quedocarchi" value="${fila.quedocarchi}"/>   
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(quejadocumento.archivofi, '${ruta}${quedocarchi}') from quejadocumento WHERE codunifami='${param.codunifami}' AND quejconsecut=${param.quejconsecut} AND codtipodctoasociado='${param.codtipodctoasociado}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                    
            </jsp2:forEach>
    
<form name="formulario" method="post" action="DocumentoQuejas.jsp">
<span id="mensajeControlador">${msj}</span>
<table width="847" border="0" class="tablaContenido">

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Documentos Quejas</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="27">&nbsp;</td>
    <td width="165"><span class="bgDescTablas" style="width: 10%"><strong>Consecutivo Queja</strong></span></td>
    <td colspan="4"><label>
      <select name="quejconsecuts" id="quejconsecuts" style="width: 150px">
        <option id="quejconsecuts" value=""></option>
        <sql:query var="r" sql="select codunifami, quejconsecut from quejas" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.codunifami == codunifamif && fila.quejconsecut == quejconsecutf}'>
              <option value="${fila.codunifami} ${fila.quejconsecut}" selected="selected">${fila.quejconsecut}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.codunifami} ${fila.quejconsecut}">${fila.quejconsecut}</option>
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
    <td><p class="bgDescTablas"><strong>Documentos Entregado</strong></p></td>
    <td width="135"><p><span class="bgDescTablas" style="width: 15%"><strong><c:choose>
                            <c:when test = '${quedocentreg == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="quedocentreg" value="S" id="quedocentreg_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="quedocentreg" value="N" id="quedocentreg_1" />
                                    </span> 
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="quedocentreg" value="S" id="quedocentreg_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="quedocentreg" value="N" id="quedocentreg_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose>
      </strong></span></p></td>
    <td width="17">&nbsp;</td>
    <td width="126"><strong class="bgDescTablas">Tipo Documento Asociado</strong></td>
    <td width="172"><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipodctoasociados" id="codtipodctoasociados" style="width: 150px">
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
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6"><div align="center" class="bgDescTablas"><strong>Archivo Documento<span class="sinBgDescTablas" style="width: 20%">
      <input name="quedocarchi" type="text" id="quedocarchi" size="15"  value="${quedocarchi}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${quedocarchi != null && quedocarchi != ""}'><br>
        <a href="../temp/${quedocarchi}" target="_blank">Descargar ${quedocarchi}</a> </c:if>
    </span></strong></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="quejconsecut" id="quejconsecut" value="" >
                  <input type="hidden" name="codtipodctoasociado" id="codtipodctoasociado" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17"> -->
		  <label>&nbsp;</label>
		  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
          </table>
        </form>
        </center>
        
    </td>
</tr>
<tr>
    <td>
       <jsp:include page="../footer.jsp" />  </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    //funciones control
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=quedocarchi";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
        var cad = document.getElementById('quejconsecuts').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codunifami='+cad2[0]+',';
		llaves+= 'quejconsecut='+cad2[1]+',';
		
        llaves+= 'codtipodctoasociado='+document.getElementById('codtipodctoasociados').value;
        validarLlave('quejadocumento',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=quejadocumento&";
        url = url + "campos=codunifami,quejconsecut,codtipodctoasociado,quedocentreg,quedocarchi&";
        url = url + "campoLlave=codunifami,quejconsecut,codtipodctoasociado";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>