<%--
    Document   : menu_Usuarios_Externos
    Created on : 19/08/2011, 14:16PM
    Author     : gaso, Sebastian

    Contiene el menu de Usuarios Externos Temporal
--%>
<%
    String comunFS = "../ComunFS/";
    String FamiliasEnAccion = "../ComunFS/";
    String TablasBasicas = "../ComunFS/";
    String SistemaSalud = "../ComunFS/";
    String reportes = "../reportes/";
    String formularios = "../formularios/";
%>
<!--<a href="<%= SistemaSalud%>CargarArchivo.jsp" onclick="traer( 'CargarArchivo.jsp' ); return false">Recepci&oacute;n Archivo</a>-->

<ul id="salud" class="filetree" style="font-size:12px;">
    <li><span class="folder">SISTEMA SALUD</span>
        <ul>
            <li><span class="folder">Poblaci&oacute;n y Prestaci&oacute;n</span>
                <ul>
                    <span class="file">
                        <li>
                             <a href="<%= formularios%>EntidadSalud.jsp">Entidad Salud</a>
                        </li>
                     </span>

                    <span class="file">
                        <li>
                            <a href="<%= SistemaSalud%>CargarArchivo.jsp?o=r">Registrar Encabezado</a>
                        </li>
                    </span>
                        <span class="file">
                        <li>
                            <a href="<%= SistemaSalud%>CargarArchivo.jsp?o=c">Consultar Encabezado</a>
                        </li>
                    </span>

                </ul>
            </li>
        </ul>
    </li>
</ul>