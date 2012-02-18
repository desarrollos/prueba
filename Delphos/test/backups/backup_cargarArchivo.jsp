<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html xmlns="http://www.w3.org/1999/xhtml">
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
        <script type="text/javascript">
            function configurar()
            {
                Calendar.setup({inputField : "fechainicial",ifFormat : "%d/%m/%Y",button : "btfechainicial"});
                Calendar.setup({inputField : "fechafinal",ifFormat : "%d/%m/%Y",button : "btfechafinal"});
                Calendar.setup({inputField : "fechaenvio",ifFormat : "%Y-%m-%d %H:%M:%S",button : "btfechaenvio"});
                Calendar.setup({inputField : "fecharecibo",ifFormat : "%Y-%m-%d %H:%M:%S",button : "btfecharecibo"});
            }

            var arrayCamposTexto        = new Array('codarchivo','nombrearchivo','nombreenvia','telefonoenvia','emailenvia','copiadctoremis');
            var arrayCamposNumero       = new Array('registros');
            var arrayCamposFechas       = new Array('fechainicial','fechafinal','fechaenvio','fecharecibo');
            var arrayCamposHoras        = null;
            var arrayCamposDesplegables = new Array('codregimen','codentidadsalud','coddepartamento','codmunicipio','codarchivo','proceso');
	</script>
</head>
<body bgcolor="#FFFFFF">
<!-- ImageReady Slices (panel.psd) -->
${msj}
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
    <td style="background: url('../images/back.png')" width="234" valign="top">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
                    <table border="0"><tr><td><font size="-2"><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target="_blank">Javascript Tree Menu</a></font></td></tr></table>
                     <span class="TreeviewSpanArea">
                         <script type="text/javascript">
				 initializeDocument();
                         </script>
                     </span>
                </td>
            </tr>
        </table>
    </td>
    <td valign="top">
        <form name="formulario" action="CargarArchivo.jsp" method="post" <%--onSubmit="return validar( arrayCamposTexto, arrayCamposNumero, arrayCamposFechas, arrayCamposHoras, arrayCamposDesplegables)"--%>>
        <table border="0" align="center" width="600">
            <tbody>
                <tr>
                    <td colspan="2" align="center" class="titulo1">Encabezado Archivo</td>
                </tr>
                <%--<tr>
                    <td align="left" class="bgDescTablas">Id Encabezado</td>
                    <td><input type="text" name="idencabezado" size="35" readonly></td>
                </tr>--%>
                <tr>
                    <td align="left" class="bgDescTablas">Codigo Regimen</td>
                    <td>
                        <select name="codregimen" id="codregimen">
                            <option value="">---------- Seleccione Regimen ----------</option>
                            <sql:query var="r" sql="SELECT * FROM regimen" dataSource="jdbc/delphos" scope="page"/>
                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                <option value="${fila.codregimen}">${fila.descripcion}</option>
                            </jsp2:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Codigo Entidad Salud</td>
                    <td>
                        <select name="codentidadsalud" id="codentidadsalud">
                            <option value="">---------- Seleccione Entidad ----------</option>
                            <sql:query var="r" sql="SELECT * FROM entidadsalud" dataSource="jdbc/delphos" scope="page"/>
                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                <option value="${fila.codentidadsalud}">${fila.nombrehabilitacion}</option>
                            </jsp2:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Fecha Inicial</td>
                    <td><input type="text" name="fechainicial" id="fechainicial" size="35" readonly><input type="button" name="btfechainicial" id="btfechainicial" value="..."></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Fecha Final</td>
                    <td><input type="text" name="fechafinal" id="fechafinal" size="35" readonly><input type="button" name="btfechafinal" id="btfechafinal" value="..."></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Codigo Archivo</td>
                    <td><input type="text" name="codarchivo" id="codarchivo"></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Departamento</td>
                    <td>
                        <select name="coddepartamento" id="coddepartamento" onChange="cargarMunicipios();">
                            <option value="">---------- Seleccione Departamento  ----------</option>
                            <sql:query var="r" sql="SELECT * FROM departamento" dataSource="jdbc/delphos" scope="page"/>
                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                <option value="${fila.coddepartamento}">${fila.nombre}</option>
                            </jsp2:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Municipio</td>
                    <td>
                    <span id="spanMunicipio">
                        <select name="codmunicipio" id="codmunicipio" disabled>
                            <option>-- Seleccione el municipio --</option>
                        </select>
                    </span>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Nombre Archivo</td>
                    <td><input type="text" name="nombrearchivo" id="nombrearchivo" size="35"></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Codigo Tipo Archivo</td>
                    <td>
                        <select name="codarchivo" id="codarchivo">
                            <option value="">---------- Seleccione Tipo Archivo ----------</option>
                            <sql:query var="r" sql="SELECT * FROM tipoarchivo" dataSource="jdbc/delphos" scope="page"/>
                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                <option value="${fila.codtipoarchivo}">${fila.descripcion}</option>
                            </jsp2:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Nombre Envia</td>
                    <td><input type="text" name="nombreenvia" id="nombreenvia" size="35"></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Telefono Envia</td>
                    <td><input type="text" name="telefonoenvia" id="telefonoenvia" size="35"></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Email Envia</td>
                    <td><input type="text" name="emailenvia" id="emailenvia" size="35"></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Fecha Envio</td>
                    <td><input type="text" name="fechaenvio" id="fechaenvio" size="35" readonly><input type="button" name="btfechaenvio" id="btfechaenvio" value="..."></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Fecha Recibo</td>
                    <td><input type="text" name="fecharecibo" id="fecharecibo" size="35" readonly><input type="button" name="btfecharecibo" id="btfecharecibo" value="..."></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Registros</td>
                    <td><input type="text" name="registros" id="registros" size="35"></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Copia Documento Remisorio</td>
                    <td><input type="text" name="copiadctoremis" id="copiadctoremis" size="35"></td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Proceso</td>
                    <td>
                        <select name="proceso" id="proceso">
                            <option value="I">Inserter Registros Primer Vez</option>
                            <option value="A">Aactualizar los existentes = Borrar e Insertar</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="bgDescTablas">
                        <label>Poblacion <input type="radio" name="tipoCarga" value="CargarPoblacion" onclick="seleccionarTipoRip('')"></label>
                        <label>Rips IPS<input type="radio" name="tipoCarga" value="CargarRips" onclick="seleccionarTipoRip('ips')"></label>
                        <label>Rips EAP<input type="radio" name="tipoCarga" value="CargarRips" onclick="seleccionarTipoRip('eap')"></label>
                    </td>
                </tr>
            </tbody>
        </table>
        <%--<table border="1" align="center" width="600">
            <tbody>
                <tr>
                    <td>Archivo</td>
                    <td><input type="text" name="archivoASubir" id="archivoASubir" size="35" readonly><a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a></td>
                </tr>
                <tr>
                    <td>Delimitador</td>
                    <td>
                        <table border="0">
                            <tr>
                                <td><label>" ; "<input type="radio" name="delimitador" value=";"></input></label></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><label>" , "<input type="radio" name="delimitador" value=","></label></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><label>" | "<input type="radio" name="delimitador" value="|"></label></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><label>Otro<input type="radio" name="delimitador" value="otro"><input type="text" size="2" name="otroDelimitador"></label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>--%>
        <center><input type="submit" value="Registrar Encabezado"></center>
        <input type="hidden"  name="hacerSubmit" value="1">
        <input type="hidden" id="tipoRip" name="tipoRip" value="">
        </form>
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
    configurar();

    function seleccionarTipoRip(tipoRip)
    {
        document.getElementById('tipoRip').value = tipoRip;
    }

    function abrirCargaArchivo()
    {
        var url;
        url = "../common/PopUpCargaArchivo.jsp?";
        url = url + "campo=archivoASubir";
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }

var req;

function cargarMunicipios()
{
   var departamento = document.getElementById("coddepartamento");
   var url = "../ServletSeleccionarMunicipios?codDepartamento=" + encodeURIComponent(departamento.value);
   if (typeof XMLHttpRequest != "undefined")
       req = new XMLHttpRequest();
   else if (window.ActiveXObject)
       req = new ActiveXObject("Microsoft.XMLHTTP");
   req.open("GET", url, true);
   req.onreadystatechange = callbackSeleccionarMunicipios;
   req.send(null);
}

function callbackSeleccionarMunicipios()
{
    if (req.readyState == 4)
        if (req.status == 200)
            obtenerListadoMunicipios();
}

function obtenerListadoMunicipios()
{
    var mdiv = document.getElementById("spanMunicipio");
    var select, xmlMunicipios, i, cantMunicipios, municipio, codMunicipio;

    xmlMunicipios = req.responseXML.getElementsByTagName("municipios")[0];
    cantMunicipios = xmlMunicipios.getElementsByTagName("municipio").length;

    select = "<select name=\"codmunicipio\" id=\"codmunicipio\" style=\"width:150px\">";
    select = select + "<option value=\"\">Seleccione el Municipio</option>";
    for(i=0; i<cantMunicipios; i++ )
    {
        codMunicipio = xmlMunicipios.getElementsByTagName("codMunicipio")[i];
        nombre = xmlMunicipios.getElementsByTagName("nombre")[i];

        select = select+"<option value=\""+codMunicipio.childNodes[0].nodeValue+"\">"+nombre.childNodes[0].nodeValue+"</option>";
    }
    select = select+"</select>";
    mdiv.innerHTML = select;
}

</script>
</body>
</html>





