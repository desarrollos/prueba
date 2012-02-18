/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import clases.*;

import java.sql.*;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.UtilidadesDKDA;
import java.net.URLDecoder;

/**
 *
 * @author John J.S
 */
public class SeleccionarColumnas extends HttpServlet {

    private ed_ValidarArchivo v;

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();
        String xml = "";


        v = new clases.ed_ValidarArchivo();

        String rip = request.getParameter("rip");

        boolean esRip = false;
        String ripsValida = "";

        UtilidadesDKDA dkda = new UtilidadesDKDA();

        HashMap datos = new HashMap();
        ////System.out.println( request.getParameter("datosFormulario") );

        String parametros = new String(URLDecoder.decode(request.getParameter("datosFormulario")).getBytes(), "UTF-8");
        datos = clases.UtilidadesDKDA.urlDecodificar(parametros, "");



        //System.out.println("RIP : " +  rip);
        //System.out.println("tipoRip " + datos.get("tipoRip") );
        //System.out.println("tipoRip Request... " + request.getParameter("tipoRip") );
        //System.out.println("Arvhivo Rip " +  datos.get("archivoRip_" + rip));
        //System.out.println( "NombreArchivo : " + request.getParameter("nombreArchivo") );


        int i, cantidadColumnas = 0, cantEstructura = 0;
        String ruta = (request.getSession().getServletContext().getRealPath("temp") + File.separatorChar).replaceAll("\\\\", "/");

        String tipoRip = "", nombreArchivo = "";
        File file;

        ////System.out.println( "Tipo rip: " + request.getParameter("tipoRip") );

        if ( ! request.getParameter("tipoRip").equals("")) {
            int j = Integer.parseInt((String) datos.get("cantidadArchivos"));
            tipoRip = (String) request.getParameter("tipoRip") + j;


            nombreArchivo = (String) datos.get("archivoRip_" + rip);
            esRip = true;
            System.out.println("Entra Rips:");
        } else {
            nombreArchivo = request.getParameter("nombreArchivo");
            System.out.println("Entra poblacion :" +  nombreArchivo);
        }



        System.out.println("Nombre archivo : " + nombreArchivo);
        System.out.println("Delimitador : " + (!esRip ? request.getParameter("delimitador") : request.getParameter("delimitador_rip")));
        System.out.println("nombre del archivo :" + nombreArchivo);
        
        
        
        file = new File(ruta + nombreArchivo);

        //dkda.ed_CodArchivo(ruta + nombreArchivo);
        UtilidadesDKDA.ed_transformarEncodingArchivo(ruta, ruta + nombreArchivo);


        FileReader fr = null;
        BufferedReader br = null, br1;

        // Codigo estructura archivo

        Connection conexion = bdS.getConexion();
        PreparedStatement stmt1 = null;
        ResultSet rs1 = null;



        String codtipoestrucarch = "";
        try {
            stmt1 = conexion.prepareStatement("SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen=?");
            stmt1.setString(1, request.getParameter("codregimen"));
            System.out.println( "SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen= " + request.getParameter("codregimen") );

            rs1 = stmt1.executeQuery();
            rs1.next();
            codtipoestrucarch = rs1.getString("codtipoestrucarch");
            ////System.out.println( " codtipoestrucarch : " + rs1.getString("codtipoestrucarch") );

            rs1.close();
            stmt1.close();
        } catch (SQLException e) {
            //System.out.println(e.getMessage());
            v.generarLog(String.valueOf(request.getParameter("idencabezado")), e.getMessage());
        }


        try {
            ResultSet rs3;
            PreparedStatement stm3;
            if ( ! request.getParameter("tipoRip").equals("")) {

                String sql = "SELECT COUNT( * ) AS cantidad FROM estructuraarchivo WHERE codtipoentidadsalud = '" + request.getParameter("tipoRip") + "' AND substr( codtipoestrucarch, 5, 5 ) = '" + request.getParameter("rip").toLowerCase() + "'";
                stm3 = conexion.prepareStatement(sql);
                rs3 = stm3.executeQuery();
                rs3.next();
                cantEstructura = rs3.getInt("cantidad");

            } else {
                stm3 = conexion.prepareStatement("SELECT COUNT(*) AS cantidad FROM estructuraarchivo WHERE codtipoestrucarch= '" + codtipoestrucarch + "'");
                rs3 = stm3.executeQuery();
                rs3.next();
                cantEstructura = rs3.getInt("cantidad");
                System.out.println("CANTIDAD ESTRCUTURA : " +cantEstructura);
                System.out.println("SELECT COUNT(*) AS cantidad FROM estructuraarchivo WHERE codtipoestrucarch= '" + codtipoestrucarch + "'");
            }


        } catch (SQLException e) {
            //System.out.println("Error : " + e.getMessage());
            v.generarLog(String.valueOf(request.getParameter("idencabezado")), e.getMessage());
        }


        try {


            fr = new FileReader(file);
            br = new BufferedReader(new FileReader(file));
            br1 = new BufferedReader(new FileReader(file));
            xml = "<table id=\"tablaColumnas\" border=\"1\" align=\"center\" style=\"border-collapse:collapse\" cellspacing=\"0\" cellpadding=\"0\">";

            int contadorLineas = 0;
            boolean tablaCreada = false;
            //StringTokenizer tokensLinea = null;
            Vector vectorItemsLinea = null;
            String linea;




            ////System.out.println("Delimitador seleccionado : " + request.getParameter("delimitador"));

            int cantComas = 0;
            while (((linea = br1.readLine()) != null)) {

                vectorItemsLinea = UtilidadesDKDA.split(linea, (!esRip ? request.getParameter("delimitador") : request.getParameter("delimitador_rip")));
                if (vectorItemsLinea.size() > cantComas) {
                    cantComas = vectorItemsLinea.size();
                }
            }
            if (cantEstructura >= cantComas) {
                //System.out.println("ENTRA 1:   " + cantEstructura + "  " + cantComas);
                cantComas = cantEstructura;


            } else if (cantEstructura < cantComas) {
                //System.out.println("ENTRA 2:   " + cantEstructura + "  " + cantComas);
                cantComas = cantComas;

            }
            //splitCantidad = ( cantidad > splitCantidad ? cantidad : ( cantidad <= splitCantidad ? (cantidad - splitCantidad) + 1 : 0  ) );


            while (((linea = br.readLine()) != null) && contadorLineas < 18) {

                contadorLineas++;
                ////System.out.println("Linea: " + linea);

                //tokensLinea = new StringTokenizer(linea,request.getParameter("delimitador"));
                vectorItemsLinea = UtilidadesDKDA.split(linea, (!esRip ? request.getParameter("delimitador") : request.getParameter("delimitador_rip")));
                if (!tablaCreada) {

                    xml += "<tr>";
                    //cantidadColumnas = tokensLinea.countTokens();
                    cantidadColumnas = cantComas;
                    for (i = 0; i < cantidadColumnas; i++) {

                        String imgColumna = ("imgColumna_" + i);
                        xml += "<td align=\"center\" bgcolor=\"#CCCCCC\"  class=\"titulo1\">Columna " + (i + 1) + " <img src=\"../carga_archivos/poblacion/img/fecha.png\" id=\"calendarioFecha_"+ i +"\"  title=\"" + imgColumna + "\" /> </td>";

                    }
                    xml += "</tr>";

                    xml += "<tr>";
                    for (i = 0; i < cantidadColumnas; i++) {

                        xml += "<td align=\"center\" bgcolor=\"#CCCCCC\">"
                                + "<input type=\"hidden\" name=\"variablesNovedades_" + i + "\" value=\"" + i + "-\" />"
                                + "<select   title=\"" + i + "\" class=\"letraPequena\" name=\"columna" + i + "\" id=\"columna" + i + "\"></option><option value=\"\"></option><option value=\"-1\">*** IGNORAR ***</option>";

                        ResultSet rs, rs2;
                        PreparedStatement stmt, stmt2;

                        try {

                            if (! request.getParameter("tipoRip").equals("")) {

                                stmt = conexion.prepareStatement("SELECT * FROM estructuraarchivo WHERE codtipoentidadsalud = ? AND substr( codtipoestrucarch, 5, 5 ) = ? ORDER BY(posicionarchivo) ASC");
                                stmt.setString(1, request.getParameter("tipoRip"));
                                stmt.setString(2, request.getParameter("rip").toLowerCase());


                                ////System.out.println( "SELECT * FROM estructuraarchivo WHERE codtipoentidadsalud = '"+ request.getParameter("tipoRip") +"' AND substr( codtipoestrucarch, 5, 5 ) = '"+ request.getParameter("rip").toLowerCase() +"'" );

                                ////System.out.println( "SELECT * FROM estructuraarchivo WHERE codtipoestrucarch='"+ codtipoestrucarch +"'  ORDER BY posicionarchivo" );
                            } else {
                                stmt = conexion.prepareStatement("SELECT * FROM estructuraarchivo WHERE codtipoestrucarch=? ORDER BY posicionarchivo");
                                ////System.out.println( "SELECT * FROM estructuraarchivo WHERE codtipoestrucarch='"+ codtipoestrucarch +"'  ORDER BY posicionarchivo" );
                                stmt.setString(1, codtipoestrucarch);
                            }
                            rs = stmt.executeQuery();


                            int c = 0;
                            while (rs.next()) {

                                if (c == 0) {
                                    ripsValida = rs.getString("codtipoestrucarch");
                                }
                                c++;
                                double codcampoarchivo;
                                codcampoarchivo = rs.getDouble("codcampoarchivo");

                                stmt2 = conexion.prepareStatement("SELECT * FROM listacamposarchivo WHERE codcampoarchivo=?");
                                stmt2.setDouble(1, codcampoarchivo);
                                ////System.out.println( "SELECT * FROM listacamposarchivo WHERE codcampoarchivo= " + codcampoarchivo );

                                rs2 = stmt2.executeQuery();
                                rs2.next();

                                if ((i + 1) == rs.getInt("posicionarchivo")) {

                                    xml += "<option selected value=\"" + codcampoarchivo + "\" style=\"background:#DBE780;\">" + dkda.convertirACarEspecial(rs2.getString("descripcion")) + "</option>";

                                } else {

                                    xml += "<option value=\"" + codcampoarchivo + "\">" + dkda.convertirACarEspecial(rs2.getString("descripcion")) + "</option>";

                                }
                                rs2.close();
                                stmt2.close();
                            }
                            rs.close();
                            stmt.close();
                        } catch (SQLException e) {

                            System.out.println("ERROR COLUMNAS  " + e.getMessage());
                            v.generarLog(String.valueOf(request.getParameter("idencabezado")), e.getMessage());

                        }


                        xml += "</select>";
                        xml += "</td>";

                    }
                    xml += "</tr>";
                    tablaCreada = true;
                }

                xml += "<tr>";
                //while(tokensLinea.hasMoreTokens())
                ////System.out.println(vectorItemsLinea.size() + "  " + cantidadColumnas);
                for (i = 0; i < cantidadColumnas; i++) {

                    String token = "";
                    if (i < vectorItemsLinea.size()) {
                        token = vectorItemsLinea.get(i).toString();
                    }


                    xml += "<td class=\"letraPequena\">" + dkda.convertirACarEspecial(token) + "</td>";
                    ////System.out.println("ENTRA");
                }

                xml += "</tr>";
            }


            xml += "</table>";
            fr.close();
            br.close();


        } catch (FileNotFoundException e) {
            //System.out.println("ERROR COLUMNAS  2" + e.getMessage());
            v.generarLog(String.valueOf(request.getParameter("idencabezado")), e.getMessage());
            e.printStackTrace();
        } catch (IOException e) {
            //System.out.println("ERROR COLUMNAS  3" + e.getMessage());
            v.generarLog(String.valueOf(request.getParameter("idencabezado")), e.getMessage());
            e.printStackTrace();
        } catch (NullPointerException e) {
            //System.out.println("ERROR COLUMNAS  4" + e.getMessage());
            v.generarLog(String.valueOf(request.getParameter("idencabezado")), e.getMessage());
        }
        try {
            FileWriter fw = new FileWriter(new File(request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + "error.html"));
            fw.write(xml);
            fw.close();
        } catch (IOException e) {
            //System.out.println("ERROR COLUMNAS  4" + e.getMessage());
            v.generarLog(String.valueOf(request.getParameter("idencabezado")), e.getMessage());
            return;
        }

        if (! request.getParameter("tipoRip").equals("")) {
            int cantidadArchivos;
            cantidadArchivos = Integer.parseInt((String) datos.get("cantidadArchivos"));

            xml += "<input type=\"hidden\" name=\"nombreArchivo\" value=\"" + request.getParameter("archivoRip") + cantidadArchivos + "\">"
                    + "<input type=\"hidden\" name=\"delimitador\" value=\"" + (!esRip ? request.getParameter("delimitador") : request.getParameter("delimitador_rip")) + "\">"
                    + "<input type=\"hidden\" name=\"codtipoestrucarch\" value=\"" + codtipoestrucarch + "\">"
                    + "<input type=\"hidden\" name=\"idencabezado\" value=\"" + request.getParameter("idencabezado") + "\">"
                    + "<input type=\"hidden\" name=\"accion\" value=\"" + request.getParameter("accion") + "\">"
                    + "<input type=\"hidden\" name=\"tipoRip\" value=\"" + tipoRip + cantidadArchivos + "\">"
                    + "<input type=\"hidden\" name=\"archivoRip\" value=\"" + request.getParameter("archivoRip") + cantidadArchivos + "\">"
                    + "<input type=\"hidden\" name=\"tipoRips\" value=\"" + (String) request.getParameter("tipoRip") + "\">"
                    + "<input type=\"hidden\" name=\"cantidadColumnas\" id=\"cantidadColumnasRips\" value=\"" + cantidadColumnas + "\">"
                    + "<input type=\"hidden\" name=\"ripsValida\" id=\"ripsValida\" value=\"" + ripsValida + "\">"
                    + "<input type=\"hidden\" name=\"totalReal\" id=\"totalReal\" value=\"" + cantEstructura + "\">";




        } else {
            xml += "<input type=\"hidden\" name=\"nombreArchivo\" id=\"nombreArchivoPoblacion\" value=\"" + nombreArchivo + "\">"
                    + "<input type=\"hidden\" name=\"delimitador\" id=\"delimitadorPoblacion\" value=\"" + (!esRip ? request.getParameter("delimitador") : request.getParameter("delimitador_rip")) + "\">"
                    + "<input type=\"hidden\" name=\"codtipoestrucarch\" id=\"codtipoestrucarchPoblacion\" value=\"" + codtipoestrucarch + "\">"
                    + "<input type=\"hidden\" name=\"idencabezado\" value=\"" + request.getParameter("idencabezado") + "\">"
                    + "<input type=\"hidden\" name=\"cantidadColumnas\" id=\"cantidadColumnasPoblacion\" value=\"" + cantidadColumnas + "\">"
                    + "<input type=\"hidden\" name=\"totalReal\" id=\"totalReal\" value=\"" + cantEstructura + "\">";
            
            
            String xmlPoblacion = "<input type=\"hidden\" name=\"nombreArchivo\" id=\"nombreArchivoPoblacion\" value=\"" + nombreArchivo + "\">"
                    + "<input type=\"hidden\" name=\"delimitador\" id=\"delimitadorPoblacion\" value=\"" + (!esRip ? request.getParameter("delimitador") : request.getParameter("delimitador_rip")) + "\">"
                    + "<input type=\"hidden\" name=\"codtipoestrucarch\" id=\"codtipoestrucarchPoblacion\" value=\"" + codtipoestrucarch + "\">"
                    + "<input type=\"hidden\" name=\"idencabezado\" value=\"" + request.getParameter("idencabezado") + "\">"
                    + "<input type=\"hidden\" name=\"cantidadColumnas\" id=\"cantidadColumnasPoblacion\" value=\"" + cantidadColumnas + "\">"
                    + "<input type=\"hidden\" name=\"totalReal\" id=\"totalReal\" value=\"" + cantEstructura + "\">";
            
            System.out.println( xmlPoblacion );


        }
        ////System.out.println( xml );

        xml = "<contenido>"
                + "<html><![CDATA[<form id=\"varsSelecColumnas\" method=\"post\">" + xml + "</form>]]></html>"
                + "</contenido>";


        try {

            out.println(xml);

        } finally {
            out.close();
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
