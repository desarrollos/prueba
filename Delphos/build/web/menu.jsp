<%@page import="java.net.InetAddress;" %>
<jsp:include page="menu_izquierdo/cargador_librerias.jsp" />
<jsp:include page="menu_izquierdo/contenedor_arriba.jsp" />
<%
String hostName = "";
int puerto = request.getServerPort();
//System.out.println("request.getSession().getAttribute(codGrupo).toString() " + request.getSession().getAttribute("codGrupo").toString());
String usuario =  request.getSession().getAttribute("login").toString();
String grupoUsuarios = request.getSession().getAttribute("codGrupo").toString();
//grupoUsuarios = "Usuarios_Externos";
//Boolean desarrollo = false;
try {
    java.net.InetAddress localMachine = java.net.InetAddress.getLocalHost();
    hostName = localMachine.getHostName();
} catch (java.net.UnknownHostException uhe) {

}
/*
 *Algo sobre puertos... No borrar..
 *
http://translate.google.com.co/translate?hl=es&langpair=en|es&u=http://www.coderanch.com/t/414402/JSP/java/port-number-server-host-name
*/

// Si la ip corresponde al sistema de familas en acccion

if (!usuario.equals("root")){

    if (puerto == 8080) {
%>

<jsp:include page="menu_izquierdo/menu_familias.jsp" />
<%

             // Si la ip corresponde al sistema de salud.
} else if (puerto == 8084) 
    {   
        if (grupoUsuarios.equals("IEP")){
            
            %>
                <jsp:include page="menu_izquierdo/menu_Usuarios_Externos.jsp" />
            <% 
            
        }else{
            %>
                <jsp:include page="menu_izquierdo/menu_salud.jsp" />
            <% 
        }           
    }
}

   else {

  %>
<jsp:include page="menu_izquierdo/menu_desarrollo.jsp" />
<%
}
%>
<jsp:include page="menu_izquierdo/contenedor_abajo.jsp" />