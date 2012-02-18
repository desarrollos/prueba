<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
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
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>

        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            //totalidad de elementos en el form
            var cajas = null;
            var combos = null;
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = null;
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
            
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
                <table width="623" border="0" class="tablaContenido">
				<form action="HistoricoConsultas.jsp" method="post" enctype="multipart/form-data" name="formulario">
                  <tr>
                    <td colspan="5"><div align="center">Historico Consultas </div></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="114"><span class="bgDescTablas"><strong>Regimen ES:</strong></span></td>
                    <td width="165" class="sinBgDescTablas"><strong>
                      <select name="codRegimenES" id="codRegimenES">
                        <option>-- Seleccione Regimen --</option>
                      </select>
                    </strong></td>
                    <td width="3">&nbsp;</td>
                    <td width="101" class="bgDescTablas"><strong>Entidad de Salud: </strong></td>
                    <td width="218" class="sinBgDescTablas"><select name="codEntidadSalud" id="codEntidadSalud">
                      <option>-- Seleccione Entidad Salud --</option>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="27" class="bgDescTablas"><strong>Mes:
                    </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="Mes" id="Mes">
                        <option>-- Seleccione Mes --</option>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>A&ntilde;o:</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="Anyo" type="text" id="Anyo" size="5" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Tipo Identificacion: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="CodTipoIdentidad" id="CodTipoIdentidad">
                        <option>-- Seleccione Tipo Identif. --</option>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>  Nro. Identificacion: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="Identificacion" type="text" id="Identificacion" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Tipo Afiliado: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="CodTipoAfiliado" id="CodTipoAfiliado">
                        <option>-- Seleccione Tipo Afiliado --</option>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="sinBgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
            <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
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
        llaves = 'codactividadeconomica='+document.getElementById('codactividadeconomica').value;
        validarLlave('actividadeconomica',llaves);
    } 
</script>
</body>
</html>