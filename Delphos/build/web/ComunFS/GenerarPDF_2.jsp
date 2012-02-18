<%@page import="clases.UtilidadesDKDA"%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<html>
    <head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delphos</title>
    </head>
    <body>
<%
    String nombreArchivoPdf;

    nombreArchivoPdf = request.getSession().getAttribute("tabla").toString()+request.getSession().getAttribute("login")+UtilidadesDKDA.obtenerFechaActual2()+UtilidadesDKDA.obtenerHoraActual()+".pdf";
    nombreArchivoPdf = nombreArchivoPdf.replaceAll(":","");

    clases.GenerarPdf generarPdf;
    generarPdf = new clases.GenerarPdf();
    generarPdf.generarPdf(request.getSession().getAttribute("sql").toString()+request.getSession().getAttribute("where").toString(),nombreArchivoPdf,request);

    String rutaPdf = request.getSession().getServletContext().getRealPath("temp")+"\\";
    rutaPdf = rutaPdf.replaceAll("\\\\","/");
    pageContext.setAttribute("ruta",rutaPdf);
%>
        <script>window.close();</script>
    </body>
</html>
