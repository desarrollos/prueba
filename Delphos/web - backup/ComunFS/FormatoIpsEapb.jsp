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
            var cajas = new Array('codformatoipseapb','descripcion','numeroanexo','archivo');
            var combos = new Array('codnorma');
            
            var arrayNonulos               	= new Array('codformatoipseapb');
            var arrayNumerosEnteros        	= new Array('numeroanexo');
            var arrayCombos               	= new Array('codnorma');			
            var arrayCadenasANCod          	= new Array('codformatoipseapb');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
            var arrayNumerosDoubles        	= null;

	</script></head>
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM formatoipseapb WHERE codformatoipseapb='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codformatoipseapb" value="${fila.codformatoipseapb}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="numeroanexo" value="${fila.numeroanexo}"/>
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>
              <c:set var="codnorma" value="${fila.codnorma}"/>                                 
              <c:set var="fechanorma" value="${fila.fechanorma}"/>
              <c:set var="archivo" value="${fila.archivo}"/>             
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(formatoipseapb.archivofi, '${ruta}${archivo}') from formatoipseapb where codformatoipseapb='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
                
                <table width="753" border="0" class="tablaContenido">
				<form action="FormatoIpsEapb.jsp" method="post" name="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Formato Relacionado </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="125" class="bgDescTablas"><strong>C&oacute;digo Formato IPS-EAPB</strong></td>
                    <td width="140" class="sinBgDescTablas"><label>
                      <input name="codformatoipseapb" type="text" id="codformatoipseapb" value="${codformatoipseapb}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                    </label></td>
                    <td width="17">&nbsp;</td>
                    <td width="116" class="bgDescTablas"><strong>Nro. Anexo</strong></td>
                    <td width="215" class="sinBgDescTablas"><label>
                      <input name="numeroanexo" type="text" id="numeroanexo" value="${numeroanexo}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'nume')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6">
                      <p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                      <p align="center" class="bgDescTablas"><strong><span class="sinBgDescTablas">
                        <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" onkeypress="javascript:return permite(event, 'com')" tabindex="3"/>
                        </span></strong></p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Norma</strong></td>
                    <td colspan="4" class="sinBgDescTablas">
                    <select name="codnorma" id="codnorma" style="width: 150px" tabindex="4">
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
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Archivo</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();" tabindex="5"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                      <c:if test='${archivo != null}'> <br />
                        <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
                    </span></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="9"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="6"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="7"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="8"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
		</form>
                </table>
                <p>&nbsp;</p>
                </center>
            </td>
</tr>
<tr>
    <td>
        <jsp:include page="../footer.jsp" />
    </td>
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
        llaves = 'codformatoipseapb='+document.getElementById('codformatoipseapb').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('formatoipseapb',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=formatoipseapb&";
        url = url + "campos=codformatoipseapb,descripcion,numeroanexo,codtiponorma,codnorma,fechanorma,archivo&";
        url = url + "campoLlave=codformatoipseapb";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>