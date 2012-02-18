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
            var cajas = new Array('codsumincomerc','descripcion','nombrelargo','nombrecorto','codennorma','codigocum','codalterno','codigorips','numexpediente','observacion','codigobarras','costo','cantmaxima','tarifasmdlv');
            var combos = new Array('codsuministro','codconcentracion','codformafarmac','codviaadmin','codunidadmedida','codtipomedicamento','codprovetitular','codprovefabrica');
                      
            //validar
            var arrayNonulos               	= new Array('codsumincomerc');
            var arrayNumerosEnteros        	= new Array('cantmaxima');
            var arrayCombos               	= new Array('codsuministro','codconcentracion','codformafarmac','codviaadmin','codunidadmedida','codtipomedicamento','codprovetitular','codprovefabrica');
            var arrayCadenasANCod          	= new Array('codsumincomerc','codennorma','codalterno','codigorips','numexpediente','codigobarras');
            var arrayCadenasA              	= new Array('nombrelargo','nombrecorto');
            var arrayComentarios           	= new Array('codsuministro','observacion');
            var arrayNumerosDoubles        	= new Array('costo','tarifasmdlv');
            
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
            <sql:query var="r" sql="SELECT * FROM suministrocomerc WHERE codsumincomerc='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codsumincomerc" value="${fila.codsumincomerc}"/>
              <c:set var="codsuministro" value="${fila.codsuministro}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="nombrelargo" value="${fila.nombrelargo}"/>             
              <c:set var="nombrecorto" value="${fila.nombrecorto}"/>
              <c:set var="codennorma" value="${fila.codennorma}"/>
              <c:set var="codigocum" value="${fila.codigocum}"/>              
              <c:set var="codalterno" value="${fila.codalterno}"/>              
              <c:set var="codigorips" value="${fila.codigorips}"/>
              <c:set var="numexpediente" value="${fila.numexpediente}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="costo" value="${fila.costo}"/>
              <c:set var="cantmaxima" value="${fila.cantmaxima}"/>
              <c:set var="codigobarras" value="${fila.codigobarras}"/>             
              <c:set var="aplicahombre" value="${fila.aplicahombre}"/>
              <c:set var="aplicamujer" value="${fila.aplicamujer}"/>
              <c:set var="tarifasmdlv" value="${fila.tarifasmdlv}"/>
              <c:set var="codconcentracion" value="${fila.codconcentracion}"/>
              <c:set var="codformafarmac" value="${fila.codformafarmac}"/>
              <c:set var="codviaadmin" value="${fila.codviaadmin}"/>
              <c:set var="codunidadmedida" value="${fila.codunidadmedida}"/>
              <c:set var="codtipomedicamento" value="${fila.codtipomedicamento}"/>
              <c:set var="codprovetitular" value="${fila.codprovetitular}"/>
              <c:set var="codprovefabrica" value="${fila.codprovefabrica}"/>
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="SuministroComerc.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Suministro Comercial</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>C&oacute;digo Suministro Comercial</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <input name="codsumincomerc" type="text" id="codsumincomerc" value="${codsumincomerc}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Alterno</strong></td>
                <td><label>
                <input name="codalterno" type="text" id="codalterno" value="${codalterno}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Suministro</strong></td>
                <td colspan="4"><label>
                <select name="codsuministro" id="codsuministro" style="width: 150px" tabindex="3">
                 <option id="codsuministro" value=""></option>
                  <sql:query var="r" sql="select codsuministro, descripcion from suministros" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codsuministro == codsuministro}'>
                        <option value="${fila.codsuministro}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codsuministro}">${fila.descripcion}</option>
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
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Nombre Largo</strong></p>
                <p align="center"><strong>
                  <textarea name="nombrelargo" cols="75" rows="3" id="nombrelargo" onKeyPress="javascript:return permite(event, 'carac')" tabindex="4">${nombrelargo}</textarea>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Nombre Corto</strong></p>
                <p align="center"><strong>
                  <label>
                  <input name="nombrecorto" type="text" id="nombrecorto" value="${nombrecorto}" size="75" maxlength="60" onKeyPress="javascript:return permite(event, 'carac')" tabindex="5">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="150"><strong class="bgDescTablas">C&oacute;digo Suministro en Normatividad</strong></td>
                <td width="160"><label>
                  <input name="codennorma" type="text" id="codennorma" value="${codennorma}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="6">
                </label></td>
                <td width="12">&nbsp;</td>
                <td width="128" class="bgDescTablas"><strong>C&oacute;digo CUM</strong></td>
                <td width="167"><label>
                  <input name="codigocum" type="text" id="codigocum" value="${codigocum}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="7">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>C&oacute;digo RIPS</strong></span></td>
                <td><label>
                  <input name="codigorips" type="text" id="codigorips" value="${codigorips}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="8">
                </label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>No. Trazador o Expediente</strong></span></td>
                <td><span class="sinBgDescTablas">
                </span>
                  <label>
                  <input name="numexpediente" type="text" id="numexpediente" value="${numexpediente}" size="20" maxlength="12" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="9">
                  </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Concentraci&oacute;n</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codconcentracion" id="codconcentracion" style="width: 150px" tabindex="10">
                    <option id="codconcentracion" value=""></option>
                    <sql:query var="r" sql="select codconcentracion, descripcion from concentracion" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codconcentracion == codconcentracion}'>
                          <option value="${fila.codconcentracion}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codconcentracion}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Forma Farmaceutica</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codformafarmac" id="codformafarmac" style="width: 150px" tabindex="11">
                    <option id="codformafarmac" value=""></option>
                    <sql:query var="r" sql="select codformafarmac, descripcion from formafarmacia" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codformafarmac == codformafarmac}'>
                          <option value="${fila.codformafarmac}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codformafarmac}">${fila.descripcion}</option>
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
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>V&iacute;a Administraci&oacute;n</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codviaadmin" id="codviaadmin" style="width: 150px" tabindex="12">
                    <option id="codviaadmin" value=""></option>
                    <sql:query var="r" sql="select codviaadmin, descripcion from viasadmin" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codviaadmin == codviaadmin}'>
                          <option value="${fila.codviaadmin}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codviaadmin}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Unidad Medida</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                <select name="codunidadmedida" id="codunidadmedida" style="width: 150px" tabindex="13">
                  <option id="codunidadmedida" value=""></option>
                  <sql:query var="r" sql="select codunidadmedida, descripcion from unidadmedida" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codunidadmedida == codunidadmedida}'>
                        <option value="${fila.codunidadmedida}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codunidadmedida}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </span></span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong class="bgDescTablas">Tipo Medicamento</strong></td>
                <td><span class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipomedicamento" id="codtipomedicamento" style="width: 150px" tabindex="14">
                    <option id="codtipomedicamento" value=""></option>
                    <sql:query var="r" sql="select codtipomedicamento, descripcion from tipomedicamento" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipomedicamento == codtipomedicamento}'>
                          <option value="${fila.codtipomedicamento}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipomedicamento}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Laboratorio Titular</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codprovetitular" id="codprovetitular" style="width: 150px" tabindex="15">
                    <option id="codprovetitular" value=""></option>
                    <sql:query var="r" sql="select codproveedor, nombre from proveedor" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codproveedor == codprovetitular}'>
                          <option value="${fila.codproveedor}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codproveedor}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Laboratorio Fabricante</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codprovefabrica" id="codprovefabrica" style="width: 150px" tabindex="16">
                    <option id="codprovefabrica" value=""></option>
                    <sql:query var="r" sql="select codproveedor, nombre from proveedor" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codproveedor == codprovefabrica}'>
                          <option value="${fila.codproveedor}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codproveedor}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Costo</strong></td>
                <td class="bgDescTablas"><input name="costo" type="text" id="costo" value="${costo}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="17"></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Cantidad Maxima</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="cantmaxima" type="text" id="cantmaxima" value="${cantmaxima}" size="20" maxlength="10" onKeyPress="javascript:return permite(event, 'nume')" tabindex="18">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tarifa en SMDLV</strong></td>
                <td class="bgDescTablas"><input name="tarifasmdlv" type="text" id="tarifasmdlv" value="${tarifasmdlv}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="19"></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>C&oacute;digo Barras</strong></td>
                <td colspan="4" class="bgDescTablas"><label>
                  <input name="codigobarras" type="text" id="codigobarras" value="${codigobarras}" size="20" maxlength="70" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="20">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Aplica Hombre</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${aplicahombre == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0" checked="true" tabindex="21"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" tabindex="21"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0" tabindex="21"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" checked="true" tabindex="21"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Aplica Mujer</strong></td>
        <td class="bgDescTablas"><c:choose>
                            <c:when test = '${aplicamujer == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0" checked="true" tabindex="22"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" tabindex="22"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0" tabindex="22"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" checked="true" tabindex="22"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Descripci&oacute;n</strong></p>
                  <p align="center">
                    <label>
                    <textarea name="descripcion" cols="75" rows="3" id="descripcion" onKeyPress="javascript:return permite(event, 'com')" tabindex="23">${descripcion}</textarea>
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                <p align="center">
                  <label>
                  <textarea name="observacion" id="observacion" cols="75" rows="3" onKeyPress="javascript:return permite(event, 'com')" tabindex="24">${observacion}</textarea>
                  </label>
                </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="28">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="25"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="26"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="27"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
          </table>
        </form>
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
        llaves = 'codsumincomerc='+document.getElementById('codsumincomerc').value+',';
		llaves+= 'codsuministro='+document.getElementById('codsuministro').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('suministrocomerc',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=suministrocomerc&";
        url = url + "campos=codsumincomerc,codsuministro,descripcion,nombrelargo,nombrecorto,codennorma,codigocum,codalterno&";
        url = url + "campoLlave=codsumincomerc";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>