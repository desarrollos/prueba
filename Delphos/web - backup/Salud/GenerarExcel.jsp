<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="clases.UtilidadesDKDA"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
    String nombreArchivoExcel;

    nombreArchivoExcel = request.getSession().getAttribute("tabla").toString()+request.getSession().getAttribute("login")+UtilidadesDKDA.obtenerFechaActual2()+UtilidadesDKDA.obtenerHoraActual()+".xls";
    nombreArchivoExcel = nombreArchivoExcel.replaceAll(":","");

    clases.GenerarExcel generarExcel;
    generarExcel = new clases.GenerarExcel();
    generarExcel.generarExcel(request.getSession().getAttribute("sql").toString()+request.getSession().getAttribute("where").toString(),nombreArchivoExcel,request);

    String rutaExcel = request.getSession().getServletContext().getRealPath("temp")+"\\";
    rutaExcel = rutaExcel.replaceAll("\\\\","/");
    pageContext.setAttribute("ruta",rutaExcel);
%>
    <script>window.close();</script>
    </body>
</html>
