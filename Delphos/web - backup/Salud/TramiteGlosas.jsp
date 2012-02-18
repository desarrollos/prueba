<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
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
<%-- Datos sesion --%>

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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM tramiteglosa WHERE codregimencto='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimencto" value="${fila.codregimencto}"/>
              <c:set var="codentidadsaludcto" value="${fila.codentidadsaludcto}"/>
              <c:set var="codcontrato" value="${fila.codcontrato}"/>
              <c:set var="consecutivo" value="${fila.consecutivo}"/>
              <c:set var="codregimenpago" value="${fila.codregimenpago}"/>              
              <c:set var="codentidadsaludpago" value="${fila.codentidadsaludpago}"/>
              <c:set var="codtipoidentpago" value="${fila.codtipoidentpago}"/>
              <c:set var="numidentfuncpago" value="${fila.numidentfuncpago}"/>              
              <c:set var="codregimenprest" value="${fila.codregimenprest}"/>
              <c:set var="codentidadsaludprest" value="${fila.codentidadsaludprest}"/>
              <c:set var="codtipoidentiprest" value="${fila.codtipoidentiprest}"/>
              <c:set var="numidentfuncprest" value="${fila.numidentfuncprest}"/>
              <c:set var="prefijofactura" value="${fila.prefijofactura}"/>
              <c:set var="nrofactura" value="${fila.nrofactura}"/>
              <c:set var="fechadevolucion" value="${fila.fechadevolucion}"/>
              <c:set var="codconcgeneglosadevo" value="${fila.codconcgeneglosadevo}"/>               
              <c:set var="codconcespeglosadevo" value="${fila.codconcespeglosadevo}"/>
              <c:set var="obsglosadevolucion" value="${fila.obsglosadevolucion}"/>
              <c:set var="fechaanticipo" value="${fila.fechaanticipo}"/>
              <c:set var="valoranticipo" value="${fila.valoranticipo}"/>
              <c:set var="fechainicial" value="${fila.fechainicial}"/>
              <c:set var="valorinicial" value="${fila.valorinicial}"/>
              <c:set var="codconcgeneglosaini" value="${fila.codconcgeneglosaini}"/>
              <c:set var="codconcespeglosaini" value="${fila.codconcespeglosaini}"/> 
              <c:set var="obsglosainicial" value="${fila.obsglosainicial}"/>
              <c:set var="fechapagonoglosa" value="${fila.fechapagonoglosa}"/>
              <c:set var="vlrpagonoglosa" value="${fila.vlrpagonoglosa}"/>
              <c:set var="fecharespglosaini" value="${fila.fecharespglosaini}"/>
              <c:set var="codconcgeneglosarespi" value="${fila.codconcgeneglosarespi}"/>
              <c:set var="codconcespeglosarespi" value="${fila.codconcespeglosarespi}"/>
              <c:set var="vlrrespglosaini" value="${fila.vlrrespglosaini}"/>
              <c:set var="obsrespuesta" value="${fila.obsrespuesta}"/>              
              <c:set var="fechadesicentidad" value="${fila.fechadesicentidad}"/>
              <c:set var="vlrlenvanentidad" value="${fila.vlrlenvanentidad}"/>
              <c:set var="fecpagoglosalenva" value="${fila.fecpagoglosalenva}"/>
              <c:set var="fecglosadefinitiva" value="${fila.fecglosadefinitiva}"/>
              <c:set var="codconcgeneglosadefinit" value="${fila.codconcgeneglosadefinit}"/>
              <c:set var="codconcespecglosadefinitiva" value="${fila.codconcespecglosadefinitiva}"/>
              <c:set var="obsglosadefinitiva" value="${fila.obsglosadefinitiva}"/>
              <c:set var="vlrdiscusion" value="${fila.vlrdiscusion}"/> 
              <c:set var="fechacreacion" value="${fila.fechacreacion}"/>
            </jsp2:forEach>
                
                <table width="650" border="0" class="tablaContenido">
				<form action="TramiteGlosas.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="5"><div align="center">Tramite Glosas </div></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Codigo Contrato:</strong></td>
                    <td class="sinBgDescTablas"><select name="codcontrato" id="codcontrato">
                        <option>-- Seleccione Codigo Contrato --</option>
                    </select></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Consecutivo: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="consecutivo" type="text" id="consecutivo" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="99" class="bgDescTablas"><strong>Entidad de Salud: </strong></td>
                    <td width="223" class="sinBgDescTablas"><select name="codEntidadSalud" id="codEntidadSalud">
                      <option>-- Seleccione Entidad Salud --</option>
                    </select></td>
                    <td width="1">&nbsp;</td>
                    <td width="91" class="bgDescTablas"><strong>Entidad Salud  Pago: </strong></td>
                    <td width="214" class="sinBgDescTablas"><label>
                      <select name="CodEntidadSaludPago" id="CodEntidadSaludPago">
                        <option>-- Seleccione Entidad Salud --</option>
                          </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Regimen:
                    </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodRegimenCto" id="CodRegimenCto">
                      <option>-- Seleccione Regimen --</option>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Regimen Pago:</strong></p></td>
                    <td class="sinBgDescTablas">
                    <p>
                      <select name="CodRegimenPago" id="CodRegimenPago">
                        <option>-- Seleccione Regimen Pago --</option>
                      </select>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="27" colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="27" class="bgDescTablas"><strong>Tipo Identif. Responsable Pago:
                    </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodTipoIdentPago" id="CodTipoIdentPago">
                      <option>-- Seleccione Tipo Identif. --</option>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro Identif. Responsable Pago:</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="NumIdentFuncPago" type="text" id="NumIdentFuncPago" size="15" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Regimen Del Prestador: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="CodRegimenPrest" id="CodRegimenPrest">
                        <option>-- Seleccione Regimen --</option>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>  Entidad Salud Del Prestador: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodEntidadSaludPrest" id="CodEntidadSaludPrest">
                      <option>-- Seleccione Entidad Salud --</option>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Tipo Identificacion Del Prestador: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodTipoIdentiPrest" id="CodTipoIdentiPrest">
                      <option>-- Seleccione Tipo Identif. --</option>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro. Identif. Del Prestador: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="NumIdentFuncPrest" type="text" id="NumIdentFuncPrest" size="15" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Numero Factura:</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="NroFactura" type="text" id="NroFactura" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Prefijo Factura:</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="PrefijoFactura" type="text" id="PrefijoFactura" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span class="bgDescTablas"><strong>Fecha Devolucion:</strong></span></td>
                    <td class="sinBgDescTablas"><input type="text" size="10" name="FechaDevolucion" id="FechaDevolucion" readonly="true" />
                      <input name="button" type="button" id="botonInsipsfecins" value="..." /></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Concepto General Glosa Devolucion:</strong></span></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="CodConcGeneGlosaDevo" id="CodConcGeneGlosaDevo">
                        <option>-- Seleccione Conpecto --</option>
                            </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span class="bgDescTablas"><strong>Concepto Especifico Glosa Devolucion:</strong></span></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodConcEspeGlosaDevo" id="CodConcEspeGlosaDevo">
                      <option>-- Seleccione Conpecto --</option>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Observaciones Devolucion:</strong></span></td>
                    <td class="sinBgDescTablas"><p>
                      <label>
                      <textarea name="ObsGlosaDevolucion" rows="5" id="ObsGlosaDevolucion"></textarea>
                      </label>
                    </p>                    
                    <label></label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Fecha Anticipo:</strong></td>
                    <td class="sinBgDescTablas"><label></label>
                      <input type="text" size="10" name="FechaAnticipo" id="FechaAnticipo" readonly="true" />
                      <input name="button2" type="button" id="button" value="..." /></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Anticipo:</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="ValorAnticipo" type="text" id="ValorAnticipo" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span class="bgDescTablas"><strong>Fecha Inicial:</strong></span></td>
                    <td class="sinBgDescTablas"><label>
                    <input type="text" size="10" name="FechaInicial" id="FechaInicial" readonly="true" />
                    <input name="button22" type="button" id="button2" value="..." />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><p class="bgDescTablas"><strong>Valor Inicial: </strong></p>                    </td>
                    <td class="sinBgDescTablas"><label>
                    <input name="ValorInicial" type="text" id="ValorInicial" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Observacion Glosa Inicial: </strong></td>
                    <td class="sinBgDescTablas"><label></label>
                      <label>
                      <textarea name="ObsGlosaInicial" rows="5" id="ObsGlosaInicial"></textarea>
                      </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="sinBgDescTablas"><label></label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Fecha Pago No Glosado: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input type="text" size="10" name="FechaPagoNoGlosa" id="FechaPagoNoGlosa" readonly="true" />
                      <input name="button222" type="button" id="button22" value="..." />
</label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Pago No Glosado: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="VlrPagoNoGlosa" type="text" id="VlrPagoNoGlosa" size="15" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Fecha Respuesta Glosa Inicial: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input type="text" size="10" name="FechaRespGlosaIni" id="FechaRespGlosaIni" readonly="true" />
                      <input name="button222" type="button" id="button22" value="..." />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Concepto General Glosa Respuesta Inicial: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="select">
                      <option>-- Seleccione Concepto --</option>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Concepto Especifico Glosa Respuesta Inicial: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodConcEspeGlosaRespI" id="CodConcEspeGlosaRespI">
                      <option>-- Seleccione Concepto --</option>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Respuesta Glosa Inicial: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="VlrRespGlosaIni" type="text" id="VlrRespGlosaIni" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Observaciones Respuesta : </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <textarea name="ObsRespuesta" rows="5" id="ObsRespuesta"></textarea>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="sinBgDescTablas"><label></label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Fecha Decision Entidad: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input type="text" size="10" name="FechaDesicEntidad" id="FechaDesicEntidad" readonly="true" />
                    <input name="button2222" type="button" id="button222" value="..." />
</label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Levantado Entidad: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="VlrLenvanEntidad" type="text" id="VlrLenvanEntidad" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Fecha Pago Glosa Levantada: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input type="text" size="10" name="FecPagoGlosalenva" id="FecPagoGlosalenva" readonly="true" />
                      <input name="button2222" type="button" id="button222" value="..." />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Glosa Definitiva: </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input type="text" size="10" name="FecGlosaDefinitiva" id="FecGlosaDefinitiva" readonly="true" />
                    <input name="button22222" type="button" id="button2222" value="..." />
</label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Concepto General Glosa Definitiva:</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="CodConcGeneGlosaDefinit" id="CodConcGeneGlosaDefinit">
                        <option>-- Seleccione Concepto --</option>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Concepto Especifico Glosa Definitiva:</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="CodConcEspecGlosaDefinitiva" id="select">
                      <option>-- Seleccione Concepto --</option>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Observaciones Glosa Definitiva: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <textarea name="ObsGlosaDefinitiva" rows="5" id="ObsGlosaDefinitiva"></textarea>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="sinBgDescTablas"><label></label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Valor Discusion Final: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="VlrDiscusion" type="text" id="VlrDiscusion" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Creacion: </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input type="text" size="10" name="FechaCreacion" id="FechaCreacion" readonly="true" />
                      <input name="button222222" type="button" id="button22222" value="..." />
</label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
          <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->
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
        <jsp:include page="../footer.jsp" />
	</td>
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
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=tramiteglosa&";
        url = url + "campos=codregimencto,codentidadsaludcto,codcontrato,consecutivo,codregimenpago,codentidadsaludpago,codtipoidentpago,numidentfuncpago&";
        url = url + "campoLlave=codregimencto";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>