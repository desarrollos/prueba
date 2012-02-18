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
            var cajas = new Array('cantidadminima','cantidadmaxima','observacion','archivo');
            var combos = new Array('codprogramapromprev','codactividadsalud','codfinalidadconsulta','codfinalidadprocedimiento');
            
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= new Array('cantidadminima','cantidadmaxima');
            var arrayCombos               	= new Array('codprogramapromprev','codactividadsalud','codfinalidadconsulta','codfinalidadprocedimiento');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion','archivo');
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
            <c:if test="${param.codprogramapromprev != null && param.codactividadsalud != null}">
            <sql:query var="r" sql="SELECT * FROM actividadprograma WHERE codprogramapromprev='${param.codprogramapromprev}' AND codactividadsalud='${param.codactividadsalud}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codprogramapromprev" value="${fila.codprogramapromprev}"/>
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/>
              <c:set var="codfinalidadconsulta" value="${fila.codfinalidadconsulta}"/>  
              <c:set var="codfinalidadprocedimiento" value="${fila.codfinalidadprocedimiento}"/>  
              <c:set var="observacion" value="${fila.observacion}"/>  
              <c:set var="cantidadminima" value="${fila.cantidadminima}"/> 
              <c:set var="cantidadmaxima" value="${fila.cantidadmaxima}"/> 
              <c:set var="archivo" value="${fila.archivo}"/>    
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(actividadprograma.archivofi, '${ruta}${archivo}') from actividadprograma where codprogramapromprev='${param.codprogramapromprev}' AND codactividadsalud='${param.codactividadsalud}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                     
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form action="ActividadPrograma.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Actividad Programa</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="119" class="bgDescTablas"><strong>Programa</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                    <select name="codprogramapromprev" id="codprogramapromprev" style="width: 150px" tabindex="1">
                      <option id="codprogramapromprev" value=""></option>
                      <sql:query var="r" sql="select codprogramapromprev, descripcion from programapromprev" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codprogramapromprev == codprogramapromprev}'>
                            <option value="${fila.codprogramapromprev}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codprogramapromprev}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Actividad Salud</strong></td>
                    <td width="207" class="bgDescTablas"><label>
                      <select name="codactividadsalud" id="codactividadsalud" style="width: 150px" tabindex="2">
                          <option id="codactividadsalud" value=""></option>
                        <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codactividadsalud == codactividadsalud}'>
                               <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                             </c:when>
                            <c:otherwise>
                              <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="5" class="bgDescTablas">&nbsp;</td>
                    <td width="119" class="bgDescTablas"><strong>Finalidad Consulta</strong></td>
                    <td width="196" class="bgDescTablas"><label>
                    <select name="codfinalidadconsulta" id="codfinalidadconsulta" style="width: 150px" tabindex="3">
                        <option id="codfinalidadconsulta" value=""></option>
                        <sql:query var="r" sql="select codfinalidadconsulta, descripcion from finalidadconsulta" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codfinalidadconsulta == codfinalidadconsulta}'>
                               <option value="${fila.codfinalidadconsulta}" selected="selected">${fila.descripcion}</option>
                             </c:when>
                            <c:otherwise>
                              <option value="${fila.codfinalidadconsulta}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Finalidad Procedimiento</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                    <select name="codfinalidadprocedimiento" id="codfinalidadprocedimiento" style="width: 150px" tabindex="4">
                      <option id="codfinalidadprocedimiento" value=""></option>
                      <sql:query var="r" sql="select codfinalidadprocedimiento, descripcion from finalidadprocedimiento" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codfinalidadprocedimiento == codfinalidadprocedimiento}'>
                            <option value="${fila.codfinalidadprocedimiento}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codfinalidadprocedimiento}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Cantidad Minima</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="cantidadminima" type="text" id="cantidadminima" value="${cantidadminima}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'nume')" tabindex="5"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Maxima</strong></td>
                    <td class="bgDescTablas"><label>
                    <input name="cantidadmaxima" type="text" id="cantidadmaxima" value="${cantidadmaxima}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'nume')" tabindex="6"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Archivo</strong></td>
                    <td colspan="4" class="bgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                    <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
                    <a href="#" onclick="abrirCargaArchivo();" tabindex="7"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" /></a>
                    <c:if test='${archivo != null}'> <br />
                      <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
                    </span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                    <p align="center"><strong>
                      <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="8">${observacion}</textarea>
                      <label></label>
                    </strong></p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codprogramapromprev" id="codprogramapromprev" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="12"> -->
		  <label>&nbsp;</label>
                 <!-- <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="9"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="10"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="11"/> -->
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
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivo";
        
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
        llaves = 'codprogramapromprev='+document.getElementById('codprogramapromprev').value+',';
        llaves+= 'codactividadsalud='+document.getElementById('codactividadsalud').value;
        validarLlave('actividadprograma',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadprograma&";
        url = url + "campos=codprogramapromprev,codactividadsalud,codfinalidadconsulta,codfinalidadprocedimiento,observacion,cantidadminima,cantidadmaxima,archivo&";
        url = url + "campoLlave=codprogramapromprev,codactividadsalud";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>