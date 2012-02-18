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
            function configurar()
        {
            Calendar.setup({inputField : "fechanormas",ifFormat : "%d/%m/%Y",button : "botonFechanorma"});
		}
			
			//totalidad de elementos en el form
            var cajas = new Array('codnormas','referencia','fechanormas','referencia','archivo');
            var combos = new Array('codtiponormas','codestadonorma');
                      
            //validar
            var arrayNonulos               = new Array('codnormas','fechanormas');
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('codtiponormas','codestadonorma');
            var arrayCadenasANCod          = new Array('codnorma');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('referencia','archivo');
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
            <c:if test="${param.codtiponorma != null && param.codnorma != null && param.fechanorma != null}">
            <sql:query var="r" sql="SELECT * FROM normas WHERE codtiponorma='${param.codtiponorma}' AND codnorma='${param.codnorma}' AND fechanorma='${param.fechanorma}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtiponormaf" value="${fila.codtiponorma}"/>
              <c:set var="codnormaf" value="${fila.codnorma}"/>
              <fmt:formatDate value="${fila.fechanorma}" pattern="dd/MM/yyyy" var="fechanormaf"/>
              <c:set var="referencia" value="${fila.referencia}"/>
              <c:set var="archivo" value="${fila.archivo}"/>              
              <c:set var="codestadonorma" value="${fila.codestadonorma}"/>  
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(normas.archivofi, '${ruta}${archivo}') from normas where codtiponorma='${param.codtiponorma}' AND codnorma='${param.codnorma}' AND fechanorma='${param.fechanorma}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                         
</jsp2:forEach>
                
                <table width="748" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
		<form name="formulario" id="formulario" method="post" action="Normas.jsp">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Normas</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Norma</strong></td>
                    <td width="169" class="bgDescTablas"><label>
                      <select name="codtiponormas" id="codtiponormas" style="width: 150px">
                        <option id="codtiponormas" value=""></option>
                        <sql:query var="r" sql="select codtiponorma, descripcion from tiponorma" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codtiponorma == codtiponormaf}'>
                              <option value="${fila.codtiponorma}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codtiponorma}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td width="19" class="bgDescTablas">&nbsp;</td>
                    <td width="113" class="bgDescTablas"><strong class="bgDescTablas">C&oacute;digo Norma</strong></td>
                  <td width="203" class="bgDescTablas"><label>
                      <input name="codnormas" type="text" id="codnormas" value="${codnormaf}" size="20" maxlength="10" />
                    </label></td>
              </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="109" class="bgDescTablas"><strong>Fecha</strong></td>
              <td colspan="4" class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="fechanormas" type="text" id="fechanormas" value="${fechanormaf}" size="15" readonly="readonly" />
                      <span class="sinBgDescTablas" style="width: 20%">
                      <input name="button" type="button" id="botonFechanorma" value="..." />
                      </span></span></label>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Referencia</strong></p>
                    <p align="center"><strong>
                      <textarea name="referencia" id="referencia" cols="75" rows="3">${referencia}</textarea>
                      <label></label>
                    </strong></p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Archivo</strong></td>
                  <td class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                    <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
                    <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                  <c:if test='${archivo != null && archivo != ""}'><br>
                  <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
                  </span></label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Estado Norma</strong></p></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codestadonorma" id="codestadonorma" style="width: 150px">
                        <option id="codestadonorma" value=""></option>
                        <sql:query var="r" sql="select codestadonorma, descripcion from estadonorma" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codestadonorma == codestadonorma}'>
                              <option value="${fila.codestadonorma}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codestadonorma}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtiponorma" id="codtiponorma" value="" >
                  <input type="hidden" name="codnorma" id="codnorma" value="" >
                  <input type="hidden" name="fechanorma" id="fechanorma" value="" >
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
    configurar();
	
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
        llaves = 'codtiponorma='+document.getElementById('codtiponormas').value+',';
		llaves+= 'codnorma='+document.getElementById('codnormas').value+',';
		llaves+= 'fechanorma='+document.getElementById('fechanormas').value;
        validarLlave('normas',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=normas&";
        url = url + "campos=codtiponorma,codnorma,fechanorma,referencia,archivo,codestadonorma&";
        url = url + "campoLlave=codtiponorma,codnorma,fechanorma";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>