package controladores;

import clases.UtilidadesDKDA;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.GenerarArchivoPlano;

public class DetalleInconsistenciasEncabezado implements Control{
    
    private String msj;
    
    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException
    {
        /*if(request.getSession().getAttribute("login") == null)
            return true;*/

        /*if(request.getSession().getAttribute("login") != null)
            if(!request.getSession().getAttribute("perfil").equals("Administrador"))
                return true;*/
        
        if(request.getParameter("hacerSubmit") != null)
        {
            String nombreArchivo = "";
            nombreArchivo = "Enc"+request.getParameter("idencabezado")+"."+UtilidadesDKDA.obtenerFechaActual()+" "+UtilidadesDKDA.obtenerHoraActual()+".txt";
            nombreArchivo = nombreArchivo.replaceAll(":","");
            
            GenerarArchivoPlano plano;
            plano = new GenerarArchivoPlano();
            
            if(plano.generarArchivoPlano(request.getParameter("sql"),nombreArchivo,request))
            {
                msj = "<a href='../temp/"+nombreArchivo+"' target='_blank'>" +
                      "<img src='../images/Novedad.gif' border='0'>" +
                      "</a><br>Descargar";
            }
            else
            {
                msj = "";
            }
            
            request.setAttribute("msj",msj);
            
            return true;
        }
        return true;
    }
}