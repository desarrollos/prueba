<%
String contenido = request.getParameter("contenido");

if( contenido.equals("miempresa") ) {
    %>
            <CENTER><h1>FAMILIAS EN ACCI&Oacute;N</h1></CENTER>

            Programa de la Agencia Presidencial, para la Acci&oacute;n Social y la Cooperaci&oacute;n Internacional, dirigido a familias del nivel 1 del SISBEN y a familias en situaci&oacute;n de desplazamiento, con ni&ntilde;as y ni&ntilde;os menores de 18 a&ntilde;os.

            
    <%
}

if( contenido.equals("proposito") ) {
    %>
            <CENTER><h1>PROP&Oacute;SITO</h1></CENTER>

            Las familias tienen la oportunidad de mejorar condiciones b&aacute;sicas como la identificaci&oacute;n, adoptando un sistema de pagos a trav&eacute;s de entidades financieras para el pago de los subsidios a las familias beneficiarias. El valor total del subsidio en este Programa de Transferencias Condicionadas depende del grado de cumplimiento de los compromisos de corresponsabilidad.
            <br />

            <br /><b>POBLACI&Oacute;N BENEFICIARIA</b>
            <br />
            <div style="padding-left: 20px" class="contenidoweb">
                Familias pertenecientes al nivel 1 del SISBEN, familias en condici&oacute;n de desplazamiento registradas en el SIPOD y familias ind&iacute;genas registradas en los Censos Ind&iacute;genas avalados por el Ministerio del Interior y Justicia con menores de 18 a&ntilde;os
            </div>

            <br /><b>COBERTURA GEOGRAFICA</b>
            <br />
            <div style="padding-left: 20px" class="contenidoweb">
                32 departamentos y 1093 de los 1098 municipios colombianos, correspondiente esto al 99.54% de la cobertura geogr&aacute;fica
            </div>
    <%

}

if( contenido.equals("objetivos") ) {
    %>
     <CENTER><h1>OBJETIVOS</h1></CENTER>

            Contribuir a la formaci&oacute;n de capital humano de las familias en extrema pobreza (Sisben 1, Poblaci&oacute;n en Condici&oacute;n de Desplazamiento, Comunidades Ind&iacute;genas), mediante dos estrategias:
            <br />

            <ol type="1">
                <li>Complementar el ingreso de las familias con ni&ntilde;os menores de 18 a&ntilde;os, incentivando la formaci&oacute;n de capital humano a trav&eacute;s de:
                    <ul type="square">
                        <li>El consumo de alimentos, la incorporaci&oacute;n de h&aacute;bitos nutricionales y acciones de cuidado de la salud y seguimiento nutricional a los menores</li>
                        <li>La asistencia y permanencia escolar en los niveles de educaci&oacute;n b&aacute;sica primaria, b&aacute;sica secundaria y media vocacional.<br /><br /></li>
                    </ul>
                </li>
                <li>Servir inicialmente como eje articulador en la fase de implementaci&oacute;n de la Red de Protecci&oacute;n Social para la Superaci&oacute;n de la Extrema Pobreza - JUNTOS, integr&aacute;ndose de manera complementaria y coordinada al conjunto de la oferta y a la estrategia de intervenci&oacute;n integral con enfoque de promoci&oacute;n social de la Red
                </li>
            </ol>
    <%

}

if( contenido.equals("imagencorporativa") ) {
 %>
            <CENTER><h1>IMAGEN CORPORATIVA</h1></CENTER>

            MISI&Oacute;N<br /><br />
            VISI&Oacute;N<br /><br />
            POLITICAS<br /><br />
            ESTRATEGIAS<br /><br />
            METAS

 <%

}

if( contenido.equals("plandesarrollo") ) {
    %>
            <CENTER><h1>PLAN DESARROLLO</h1></CENTER>

            Objetivos<br /><br />
            Metas<br /><br />
            Plan<br /><br />
            Compromisos
            

    <%


}

%>