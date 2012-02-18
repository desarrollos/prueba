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
            var cajas = new Array('coddiagnostico3char','descripcion','observacion');
            var combos = null;
                        
            //validar
            var arrayNonulos               	= new Array('coddiagnostico3char');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= null;
            var arrayCadenasANCod          	= new Array('coddiagnostico3char');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion','observacion');
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
            <sql:query var="r" sql="SELECT * FROM diagnostico3char WHERE coddiagnostico3char='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="coddiagnostico3char" value="${fila.coddiagnostico3char}"/> 
              <c:set var="descripcion" value="${fila.descripcion}"/> 
                <c:set var="observacion" value="${fila.observacion}"/>    
            </jsp2:forEach>
                
                <table width="825" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="Diagnostico3Char.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="3"><div align="center" class="titulo1">Diagn&oacute;stico 3 Caracteres </div></td>
                  </tr>
                  <tr>
                    <td colspan="3">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="45" class="bgDescTablas">&nbsp;</td>
                    <td width="160" class="bgDescTablas"><strong>C&oacute;digo Diagn&oacute;stico </strong>
                      <label><strong>3 Caracteres </strong></label></td>
                    <td width="449" class="bgDescTablas"><input name="coddiagnostico3char" type="text" id="coddiagnostico3char" value="${coddiagnostico3char}" size="20" maxlength="3" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/></td>
                  </tr>
                  <tr>
                    <td colspan="3" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="3" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                      <p align="center">
                        <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onkeypress="javascript:return permite(event, 'com')" tabindex="2"/>
                      </p></td>
                  </tr>
                  <tr>
                    <td colspan="3" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                    <p align="center">
                      <label>
                      <textarea name="observacion" cols="75" rows="3" id="observacion" onkeypress="javascript:return permite(event, 'com')" tabindex="3">${observacion}</textarea>
                      </label>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="7"> -->
		  <label>&nbsp;</label>
                  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="4"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="5"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="6"/> 
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
        llaves = 'coddiagnostico3char='+document.getElementById('coddiagnostico3char').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('diagnostico3char',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=diagnostico3char&";
        url = url + "campos=coddiagnostico3char,descripcion,observacion&";
        url = url + "campoLlave=coddiagnostico3char";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>