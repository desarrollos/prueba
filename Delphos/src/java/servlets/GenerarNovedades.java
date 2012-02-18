/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import poblacion.generarNovedades;
import clases.ed_ValidarArchivo;
import java.sql.SQLException;

/**
 * 
 *
 * @author John J.S
 */
public class GenerarNovedades extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *
     */
     
    generarNovedades nov;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HashMap vars = new HashMap();

        String usuario = request.getSession().getAttribute("login").toString();

        vars = clases.UtilidadesDKDA.urlDecodificar(request.getParameter("varsSelecColumnas"), "");

        int idencabezado = Integer.parseInt(request.getParameter("idencabezado").replace('.', ','));

        String ruta = request.getSession().getServletContext().getRealPath("temp") + System.getProperty("file.separator");
        String nombreArchivo = request.getParameter("nombreArchivo");

        //Nombre del Criterio con el que se hizo la busqueda(Nombre Campo BD)
        String criterioBusqueda = request.getParameter("criterioSeleccionado");

        String estructuraColumnas = "";
        cargaArchivos.ConstruccionSQL sql;
        
        sql = new cargaArchivos.ConstruccionSQL(request, vars);
        estructuraColumnas = sql.construirEstructuraColumnas();


        String rutaArchivosNovedades = ruta + idencabezado + System.getProperty("file.separator") + "nov" + System.getProperty("file.separator");
       // System.out.println("*******************Rutaaaaaa Servelt" + rutaArchivosNovedades);



        


        


       // System.out.println( "FECHAS SELECCIONADAS " + UtilidadesDKDA.fechasSeleccionadas(request) );
        // formatoFecha ->  7, 8 ...
        // request.getParameter("fechasSeleccionadas")  <- Pasa con el formato a?o mes dia ...
        // UtilidadesDKDA.fechasSeleccionadas(request) <- Devuelve el nombre del campo en listacamposarchivo


        //System.out.println("Formato Fechas Generar Novedades" + request.getParameter( "formatoFecha" ));

        //System.out.println( "*Columnas seleccionadas*:  " +request.getParameter("columnasSeleccionadas") );

       // System.out.println("*** Nuevos Parametros ****");
       // System.out.println(request.getParameter("fechasSeleccionadas") );
       //System.out.println(UtilidadesDKDA.fechasSeleccionadas(request.getParameter("soloTiposFechas")));
       // System.out.println("***  ****");

        String posicionColumnas = request.getParameter("columnasSeleccionadas") ;

        String formatoFechas = request.getParameter("fechasSeleccionadas"); // 8:/:DD:MM:AAAA

        nov  = new generarNovedades();
        ed_ValidarArchivo vA;
        vA = new ed_ValidarArchivo();

        File file = new File(vA.rutaDatosCorrectos(""+idencabezado , nombreArchivo, ruta));

        // System.out.println("parametro columnas obligatorias=========>" + request.getParameter("posTipoIDCedula"));

        //System.out.println("El nombre del archivo es");

        System.out.println( "GENERANDO NOVEDADES..." );
        if( file.exists() ){
            nov.generarN(estructuraColumnas ,ruta ,nombreArchivo , request.getParameter("posTipoIDCedula"),request.getParameter("posCampos") , UtilidadesDKDA.fechasSeleccionadas(request.getParameter("soloTiposFechas")), vA.rutaDatosCorrectos(""+idencabezado , nombreArchivo, ruta) , String.valueOf(idencabezado)  , formatoFechas , posicionColumnas , criterioBusqueda,usuario);
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
