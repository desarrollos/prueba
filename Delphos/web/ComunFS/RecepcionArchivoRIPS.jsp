<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

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
            <sql:query var="r" sql="SELECT * FROM encabezadoarchivo WHERE idencabezado='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idencabezado" value="${fila.idencabezado}"/>
              <c:set var="codregimenes" value="${fila.codregimenes}"/>
              <c:set var="codentidadsalud" value="${fila.codentidadsalud}"/>
              <c:set var="fechainicial" value="${fila.fechainicial}"/>
              <c:set var="fechafinal" value="${fila.fechafinal}"/>              
              <c:set var="codarchivo" value="${fila.codarchivo}"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>              
              <c:set var="nombrearchivo" value="${fila.nombrearchivo}"/>
              <c:set var="codtipoarchivo" value="${fila.codtipoarchivo}"/>
              <c:set var="nombreenvia" value="${fila.nombreenvia}"/>
              <c:set var="telefonoenvia" value="${fila.telefonoenvia}"/>
              <c:set var="emailenvia" value="${fila.emailenvia}"/>
              <c:set var="fechaenvio" value="${fila.fechaenvio}"/>
              <c:set var="horaenvio" value="${fila.horaenvio}"/>
              <c:set var="fecharecibo" value="${fila.fecharecibo}"/>
              <c:set var="registros" value="${fila.registros}"/>
              <c:set var="copiadctoremis" value="${fila.copiadctoremis}"/>
              <c:set var="proceso" value="${fila.proceso}"/>
            </jsp2:forEach>
                
                <table width="623" border="0" class="tablaContenido">
				<form action="PagosContrato.jsp" method="post" enctype="multipart/form-data" name="formulario">
                  <tr>
                    <td colspan="5"><div align="center" class="titulo1">Recepci&oacute;n Archivo RIPS</div></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Id Encabezado</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input type="text" name="idencabezado" id="idencabezado" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Entidad de Salud</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codentidadsalud" id="codentidadsalud">
                       <option value=" " selected="selected"> </option>
                      <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                      </jsp2:forEach>
                    </select>
                      </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><strong class="bgDescTablas">Fecha Inicial</strong></td>
                    <td><input type="text" size="10" name="fechainicial" id="fechainicial" readonly="true" />
                      <input name="botonFechainicial" type="button" id="botonFechainicial" value="..." /></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Fecha Final</strong></td>
                    <td><input type="text" size="10" name="fechafinal" id="fechafinal" readonly="true" />
                      <input name="botonFechafinal" type="button" id="botonFechafinal" value="..." /></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Departamento</strong></td>
                    <td><label>
                      <select name="coddepartamento" id="coddepartamento">
                      <option value=" " selected="selected"> </option>
                      <sql:query var="r" sql="select coddepartamento, nombre from departamento" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.coddepartamento}">${fila.nombre}</option>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Municipio</strong></td>
                    <td><label>
                      <select name="codmunicipio" id="codmunicipio">
                       <option value=" " selected="selected"> </option>
                      <sql:query var="r" sql="select codmunicipio, nombre from municipio" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.codmunicipio}">${fila.nombre}</option>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="114"><strong class="bgDescTablas">C&oacute;digo Archivo</strong></td>
                    <td width="165" class="sinBgDescTablas"><strong>
                      <label>
                      <input type="text" name="codarchivo" id="codarchivo" />
                      </label>
                    </strong></td>
                    <td width="3">&nbsp;</td>
                    <td width="101" class="bgDescTablas"><strong>Tipo Archivo</strong></td>
                    <td width="218" class="sinBgDescTablas"><label>
                      <select name="codtipoarchivo" id="codtipoarchivo">
                      <option value=" " selected="selected"> </option>
                      <sql:query var="r" sql="select codtipoarchivo, descripcion from tipoarchivo" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.codtipoarchivo}">${fila.descripcion}</option>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Nombre Archivo</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <input type="text" name="nombrearchivo" id="nombrearchivo" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="5" class="titulo1"><div align="center">Datos De Env&iacute;o</div></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Nombre</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input type="text" name="nombreenvia" id="nombreenvia" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Telefono</strong></p></td>
                    <td class="sinBgDescTablas"><label></label>
                      <label></label>
                    <p>
                      <label>
                      <input type="text" name="telefonoenvia" id="telefonoenvia" />
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><strong class="bgDescTablas">Email</strong></td>
                    <td><label>
                      <input type="text" name="emailenvia" id="emailenvia" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Fecha</strong></td>
                    <td><input type="text" size="10" name="fechaenvio" id="fechaenvio" readonly="true" />
                      <input name="botonFechainicial2" type="button" id="botonFechaenvio" value="..." /></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Hora</strong></td>
                    <td class="sinBgDescTablas"><label><span class="bgDescTablas">
                    <select name="horaenvio" id="horaenvio">
                      <option value="0">0</option>
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                      <option value="9">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                    </select>
                    </span> <span class="bgDescTablas"> :
                    <select name="horaenviomin" id="horaenviomin">
                      <option value="00">00</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      <option value="24">24</option>
                      <option value="25">25</option>
                      <option value="26">26</option>
                      <option value="27">27</option>
                      <option value="28">28</option>
                      <option value="29">29</option>
                      <option value="30">30</option>
                      <option value="31">31</option>
                      <option value="32">32</option>
                      <option value="33">33</option>
                      <option value="34">34</option>
                      <option value="35">35</option>
                      <option value="36">36</option>
                      <option value="37">37</option>
                      <option value="38">38</option>
                      <option value="39">39</option>
                      <option value="40">40</option>
                      <option value="41">41</option>
                      <option value="42">42</option>
                      <option value="43">43</option>
                      <option value="44">44</option>
                      <option value="45">45</option>
                      <option value="46">46</option>
                      <option value="47">47</option>
                      <option value="48">48</option>
                      <option value="49">49</option>
                      <option value="50">50</option>
                      <option value="51">51</option>
                      <option value="52">52</option>
                      <option value="53">53</option>
                      <option value="54">54</option>
                      <option value="55">55</option>
                      <option value="56">56</option>
                      <option value="57">57</option>
                      <option value="58">58</option>
                      <option value="59">59</option>
                    </select>
                    </span> </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Recibo</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input type="text" size="10" name="fecharecibo" id="fecharecibo" readonly="true" />
                    <input name="botonFechainicial3" type="button" id="botonFecharecibo" value="..." />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Nro. Registros</strong></td>
                    <td><label>
                      <input type="text" name="registros" id="registros" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Copia Documento Remisorio</strong></td>
                    <td><label>
                      <input name="copiadctoremis" type="file" id="copiadctoremis" size="15" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas"><strong>Proceso</strong></td>
                    <td colspan="4"><label>
                      <select name="proceso" id="proceso">
                        <option value="A">Actualizar Existentes</option>
                        <option value="I">Insertar por primera vez</option>
                      </select>
                    </label>                      <label></label></td>
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
        url = url + "tabla=encabezadoarchivo&";
        url = url + "campos=idencabezado,codregimenes,codentidadsalud,fechainicial,fechafinal,codarchivo,coddepartamento,codmunicipio&";
        url = url + "campoLlave=idencabezado";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>