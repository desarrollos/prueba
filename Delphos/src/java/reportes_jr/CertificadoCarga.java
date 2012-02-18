/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportes_jr;

import clases.ConexionBaseDatos;
import clases.bdS;
import clases.ed_QR;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.UnknownHostException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

// Excel


import net.sf.jasperreports.engine.export.*;
import net.sf.jasperreports.engine.*;
import java.io.*;
import java.net.InetAddress;


import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

/**
 *
 * @author gaso
 */
public class CertificadoCarga extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private Connection con = null;
    public String urlLogoDelphos;
    String MsjRip;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conexion = bdS.getConexion();


        //http://localhost:8080/Delphos/CertificadoCarga?noEncabezado=4&tipoCarga=CargarRips

        
        

        String destinoQR = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + request.getRequestURI() + "?noEncabezado=" + request.getParameter("noEncabezado") + "&tipoCarga=" + request.getParameter("tipoCarga");
        String imgQR = request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + "QR" + request.getParameter("noEncabezado") + ".png";
        ed_QR.createQrCode(imgQR, destinoQR, 95, "png");

        System.out.println("URL QR " + destinoQR);

        String archivoJR = "poblacionCertificadoCargue";

        if (request.getParameter("tipoCarga").equals("CargarRips")) {
            MsjRip = "En el Sistema de Información se ha registrado el Tipo de Carga IPS, bajo Archivos RIPS (REGISTROS INDIVIDUALES DE PRESTADORES DE SERVICIOS) con las siguientes características.";
            archivoJR = "RipsIPSCertificadoCargue";
        }
        if (request.getParameter("tipoCarga").equals("CargarRipsEAPB")) {
            MsjRip = "En el Sistema de Información se ha registrado el Tipo de Carga EAPB, bajo Archivos RIPS (REGISTROS INDIVIDUALES DE PRESTADORES DE SERVICIOS) con las siguientes características.";
            archivoJR = "RipsIPSCertificadoCargue";
        }
        if (request.getParameter("tipoCarga").equals("")) {
            MsjRip = "En el Sistema de Información se ha registrado el Tipo de Carga POBLACIÓN, con las siguientes características";
            archivoJR = "poblacionCertificadoCargue";
        }



        urlLogoDelphos = request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + "LogoDelphos.png";
        compilarJrxml(request,archivoJR);

        final HashMap ParametrosReport = new HashMap();
        ParametrosReport.put("URL_LOGO_DELPHOS", urlLogoDelphos);
        ParametrosReport.put("noEncabezado", Integer.parseInt(request.getParameter("noEncabezado")));
        ParametrosReport.put("MsjRip", MsjRip);
        ParametrosReport.put("codigoQR", imgQR);

        final ServletOutputStream servletOutputStream = response.getOutputStream();

        final InputStream reportStream = getServletConfig().getServletContext().getResourceAsStream("/reportes/formatos/"+archivoJR+".jasper");

        try {
            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, ParametrosReport, conexion);

            //byte[] bytes = JasperRunManager.runReportToPdf(reportStream, new HashMap() ,con.con);
            //response.setContentType("application/pdf");
            response.setContentType("application/download");
            //response.setHeader("Content-Disposition", "attachment; filename=\"" + "fichero.pdf" + "\"");
            response.setHeader("Content-Disposition", "attachment; filename=\"archivo.pdf\"");

            servletOutputStream.flush();
            servletOutputStream.close();
            // eliminarJasper(request);
        } catch (JRException e) {
            StringWriter stringWriter = new StringWriter();
            PrintWriter printWriter = new PrintWriter(stringWriter);
            e.printStackTrace(printWriter);
            response.setContentType("text/plain");
            response.getOutputStream().print(stringWriter.toString());
        }
    }
    
    //request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + archivoJR + ".jrxml"

    public void compilarJrxml(HttpServletRequest request , String archivoJR ) {
        String urlArchivosJR = request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar;
        try {
            JasperCompileManager.compileReportToFile( urlArchivosJR+archivoJR+".jrxml", urlArchivosJR+archivoJR+".jasper");
            System.out.println("Reporte compilado ... ");
        } catch (JRException e) {
            System.out.println("Problemas encontrados al compilar JRXML " + e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
