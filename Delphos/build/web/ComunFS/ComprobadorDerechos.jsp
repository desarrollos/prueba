<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
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
        <img src="../images/cabezote.png" width="906" height="150" alt="" />
    </td>
</tr>
<%-- Datos sesion --%>
<tr valign="top">
    <td colspan="3" width="906" height="16" style="background: url('../images/panel_02.gif')" align="right">
        <span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a>
    </td>
</tr>
<%-- Datos sesion --%>
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

                <table width="630" border="0" class="tablaContenido">
				<form action="ComprobadorDerechos.jsp" method="post" enctype="multipart/form-data" name="formulario">
                  <tr>
                    <td colspan="5"><div align="center">Consulta Comrpbador de Derechos </div></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong> Usuario</strong></td>
                    <td class="sinBgDescTablas"><select name="idUsuario" id="idUsuario">
                      <option value=" "> </option>
                    </select></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Consecutivo</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="Consecutivo" type="text" id="Consecutivo" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="112"><span class="bgDescTablas"><strong>Numero Registro Afilicacion</strong></span></td>
                    <td width="215" class="sinBgDescTablas"><label>
                      <input name="NumRegAfiliacion" type="text" id="NumRegAfiliacion" />
                    </label></td>
                    <td width="1">&nbsp;</td>
                    <td width="118" class="bgDescTablas">&nbsp;</td>
                    <td width="162" class="sinBgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Tipo Identificacion Afiliado</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodTipoIdentAfil" id="CodTipoIdentAfil">
                      <option value=" "> </option>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Nro. Identificacion Afiliado</strong></p></td>
                    <td class="sinBgDescTablas"><label></label>
                      <label></label>
                    <p>
                      <label>
                      <input name="NumeroIdentAfiliado" type="text" id="NumeroIdentAfiliado" />
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="27" colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="27" class="bgDescTablas"><strong>Fecha</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input type="text" size="10" name="Fecha" id="Fecha" readonly="true" />
                    <input name="button" type="button" id="botonInsipsfecins" value="..." />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Hora</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="Hora" type="text" id="Hora" size="5" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Tipo Identificacion Comprobado</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="CodTipoIdentComp" type="text" id="CodTipoIdentComp" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>  Nro. Identificacion Comprobado</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="porcPlan" type="text" id="porcPlan" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Primer Nombre Comprobado</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="PrimerNombreComp" type="text" id="PrimerNombreComp" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Segundo Nombre Comprobado</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="SegundoNombreComp" type="text" id="SegundoNombreComp" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Primer Apellido Comprobado</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="PrimerApellComp" type="text" id="PrimerApellComp" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Segundo Apellido Comprobado</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="SegundoApellComp" type="text" id="SegundoApellComp" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span class="bgDescTablas"><strong>Tipo Afiliado</strong></span></td>
                    <td class="sinBgDescTablas"><input type="text" size="0" name="TipoAfiliado" id="TipoAfiliado" readonly="true" /></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Tipo Cotizante</strong></span></td>
                    <td class="sinBgDescTablas"><input type="text" size="0" name="TipoCotizante" id="TipoCotizante" readonly="true" /></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span class="bgDescTablas"><strong>Contrato Principal</strong></span></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="ContratoPpal" type="text" id="ContratoPpal" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Estrato Socio Economico</strong></span></td>
                    <td class="sinBgDescTablas"><p><label>
                    <input name="EstatoSocEcon" type="text" id="EstatoSocEcon" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Nivel Clasificacion</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="NivelClasif" type="text" id="NivelClasif" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Nacimiento</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input type="text" size="10" name="FechaNac" id="FechaNac" readonly="true" />
                    <input name="button2" type="button" id="button" value="..." />
</label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span class="bgDescTablas"><strong>Sexo</strong></span></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="Sexo" type="radio" value="M" id="radio" />
                    M
                    <input name="Sexo" type="radio" value="F"  id="radio2" checked="checked" />
                    F
                    </label></td>
                    <td>&nbsp;</td>
                    <td><p class="bgDescTablas"><strong>Departamento de Residencia</strong></p>                    </td>
                    <td class="sinBgDescTablas"><label>
                    <input name="CodDeptoRes" type="text" id="CodDeptoRes" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Municipio de Residencia</strong></td>
                    <td class="sinBgDescTablas"><label></label>
                      <input type="text" name="CodMunicipio" id="CodMunicipio" readonly="true" /></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Sub Grupo Geografico</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="CodSubGrupoGeo" type="text" id="CodSubGrupoGeo" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Barrio</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="CodBarrio" type="text" id="CodBarrio" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="sinBgDescTablas"><label></label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Tipo Identif. Comprobado Cotizante</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="TipoIdentCotizComp" type="text" id="TipoIdentCotizComp" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro. Identif. Comprobado Cotizante</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="EdadFinal" type="text" id="EdadFinal" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Usuario del Sistema</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="UsuarioSis" type="text" id="UsuarioSis" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
              <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <input type="button" onClick="buscar();" value="Buscar" tabindex="6">
		  <label>&nbsp;</label>
                  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>
               </div>
            </td>
           </tr>
	</form>
       </table>
     </center>
        
    </td>
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_06.gif" width="906" height="1" alt="">
    </td>
</tr>
<tr>
    <td height="42" colspan="3">
        <img src="../images/panel_07.gif" width="906" height="23" alt="">    </td>
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