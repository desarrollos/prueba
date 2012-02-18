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
            var cajas = new Array('consecutivo','archivo','notainterventoria');
            var combos = new Array('codcontratos','codtipoobligcontratos','codtipofasecontrato','codestcumplimiento');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = new Array('consecutivo');
            var arrayCombos                = new Array('codcontratos','codtipoobligcontratos','codtipofasecontrato','codestcumplimiento');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('archivo','notainterventoria');
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.codtipoobligcontrato != null}">
            <sql:query var="r" sql="SELECT * FROM obligcontractual WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codtipoobligcontrato='${param.codtipoobligcontrato}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codtipoobligcontratof" value="${fila.codtipoobligcontrato}"/>
              <c:set var="consecutivo" value="${fila.consecutivo}"/>
              <c:set var="codtipofasecontrato" value="${fila.codtipofasecontrato}"/>
              <c:set var="codestcumplimiento" value="${fila.codestcumplimiento}"/>
              <c:set var="notainterventoria" value="${fila.notainterventoria}"/>
              <c:set var="archivo" value="${fila.archivo}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(obligcontractual.archivofi, '${ruta}${archivo}') from obligcontractual where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codtipoobligcontrato='${param.codtipoobligcontrato}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
                
                <table width="807" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="Obligaciones.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Obligaciones</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27">&nbsp;</td>
                    <td width="116"><span class="bgDescTablas"><strong>Contrato</strong></span></td>
                  <td width="173" class="sinBgDescTablas"><label>
                  <select name="codcontratos" id="codcontratos" style="width: 150px">
                    <option id="codcontratos" value=""></option>
                    <sql:query var="r" sql="select codcontrato, codregimenes, codentidadsalud from contrato" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf && fila.codcontrato == codcontratof}'>
                          <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}" selected="selected">${fila.codcontrato}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}">${fila.codcontrato}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                  </label></td>
                    <td width="22">&nbsp;</td>
                    <td width="104" class="bgDescTablas"><strong>Consecutivo </strong></td>
                    <td width="200" class="sinBgDescTablas"><input  name="consecutivo" type="text" id="consecutivo" value="${consecutivo}" size="20" maxlength="6" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>Tipo Obligaci&oacute;n</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="codtipoobligcontratos" id="codtipoobligcontratos" style="width: 150px">
                       <option id="codtipoobligcontratos" value=""></option>
                          <sql:query var="r" sql="select codtipoobligcontrato, descripcion from tipoobligcontrato" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoobligcontrato == codtipoobligcontratof}'>
                                <option value="${fila.codtipoobligcontrato}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoobligcontrato}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Fase</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codtipofasecontrato" id="codtipofasecontrato" style="width: 150px">
                        <option id="codtipofasecontrato" value=""></option>
                              <sql:query var="r" sql="select codtipofasecontrato, descripcion from tipofasecontrato" dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codtipofasecontrato == codtipofasecontrato}'>
                                    <option value="${fila.codtipofasecontrato}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codtipofasecontrato}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Estado Cumplimiento</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="codestcumplimiento" id="codestcumplimiento" style="width: 150px">
                      <option id="codestcumplimiento" value=""></option>
                              <sql:query var="r" sql="select codestcumplimiento, descripcion from estadocumplimiento"  dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codestcumplimiento == codestcumplimiento}'>
                                    <option value="${fila.codestcumplimiento}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codestcumplimiento}">${fila.descripcion}</option>
                                </c:otherwise>
                               </c:choose>
                             </jsp2:forEach>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>  Archivo</strong></td>
                    <td class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${archivo != null && archivo != ""}'><br>
                        <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
                    </span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Notas Interventor&iacute;a</strong></p>
                      <p align="center" class="bgDescTablas"> 
                        <textarea name="notainterventoria" cols="75" rows="3" id="notainterventoria">${notainterventoria}</textarea>
                      </p></td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="codtipoobligcontrato" id="codtipoobligcontrato" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
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
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivo";
        
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
        var cad = document.getElementById('codcontratos').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		
		llaves+= 'codtipoobligcontrato='+document.getElementById('codtipoobligcontratos').value;
        validarLlave('obligcontractual',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=obligcontractual&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,codtipoobligcontrato,consecutivo,codtipofasecontrato,codestcumplimiento,archivo&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,codtipoobligcontrato";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>