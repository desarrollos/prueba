package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;

public class CargaArchivoRips implements Control{
    
    private String msj;
    private ConexionBaseDatos c;
    
    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException
    {
        /*if(request.getSession().getAttribute("login") == null)
            return true;*/

        if(request.getParameter("hacerSubmit") != null)
        {
            String codtipoestrucarch, accion, delimitador;
            int idencabezado, cantidadArchivos, contadorArchivos;

            codtipoestrucarch = request.getParameter("codtipoestrucarch");
            accion = request.getParameter("accion");
            idencabezado = Integer.parseInt(request.getParameter("idencabezado"));
            //cantidadArchivos = Integer.parseInt(request.getParameter("cantidadArchivos"));
            contadorArchivos = Integer.parseInt(request.getParameter("contadorArchivos"));
            
            //Registro de los archivos cargados
            int i, j = 1;
            for(i=1;i<=contadorArchivos;i++)
            {
                String tipoRip = null, archivoRip = null;
                tipoRip = request.getParameter("tipoRip"+i);
                archivoRip = request.getParameter("archivoRip"+i);
                
                if(tipoRip != null)
                {
                    request.getSession().setAttribute("tipoRip"+j,tipoRip);
                    request.getSession().setAttribute("archivoRip"+j,archivoRip);
                    j++;
                }
            }
            
            j = j - 1;
            request.getSession().setAttribute("cantidadArchivos",j);
            
            /*
             Variables que recibe SeleccionarColumnas.jsp:
               -nombreArchivo
               -delimitador
               -otroDelimitador
               -codtipoestrucarch
               -idencabezado
               -accion
               -tipoRip //El tipo de rip del archiv
               -archivoRip
               -tipoRips //El tipo de rips (ips ó eap)
            */
            
            String msj, variables = "";
            
            variables += "nombreArchivo="+request.getSession().getAttribute("archivoRip"+j)+"&";
            variables += "delimitador="+request.getParameter("delimitador")+"&";
            variables += "otroDelimitador="+request.getParameter("otroDelimitador")+"&";
            variables += "codtipoestrucarch="+codtipoestrucarch+"&";
            variables += "idencabezado="+idencabezado+"&";
            variables += "accion="+accion+"&";
            variables += "tipoRip="+request.getSession().getAttribute("tipoRip"+j)+"&";
            variables += "archivoRip="+request.getSession().getAttribute("archivoRip"+j)+"&";
            variables += "tipoRips="+request.getParameter("tipoRipsX")+"&";
            
            msj = "<script>window.top.location='SeleccionarColumnas.jsp?"+variables+"';</script>";

            request.setAttribute("msj",msj);
            
            return true;
        }
        return true;
    }
}