package servlets;

import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import clases.bdS;
import java.io.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.*;
import javax.servlet.http.*;

import clases.ed_ValidarArchivo;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Vector;
import poblacion.InconsistenciasPoblacion;

public class CargarRips extends HttpServlet {

    String usuario, tipoRip;
    ConexionBaseDatos con;
    HashMap tipoDato = null;
    ed_ValidarArchivo vA;
    InconsistenciasPoblacion IncPoblacion;
    String queryReducido = "";
    String retorno = "";
    String nombreArchivo;
    
    String datosInconsistencias = "";
    
    int cantidadColumnas;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        clases.VerificarUsuarioSistema v;
        v = new clases.VerificarUsuarioSistema(request, response);
        
        PrintWriter out = response.getWriter();
        int cantidadArchivos;
        con = new ConexionBaseDatos();
        con.abrirConexion();
        usuario = request.getSession().getAttribute("login").toString();
        String retorno = "";
        
        IncPoblacion = new InconsistenciasPoblacion(usuario , Integer.parseInt(request.getParameter("idencabezado"))  );

        String tipo = request.getParameter("tipo");
        if (tipo.equals("subirRips")) {
            int idencabezado = Integer.parseInt(request.getParameter("idencabezado"));
            String copyFinal = request.getSession().getAttribute("copy" + encabezado( idencabezado) ).toString();
            String archivos = request.getSession().getAttribute("nombreArchivo" + encabezado(idencabezado)).toString();
            //System.out.println( "copyFinal" + encabezado(Integer.parseInt(request.getParameter("idencabezado"))) + " : "+ copyFinal );
            retorno = subirRips(copyFinal, request, idencabezado, archivos);
            System.out.println( "Retorno " + retorno );
            out.println(retorno);


        } else {

            cantidadArchivos = Integer.parseInt(request.getParameter("cantidadArchivos")) - 1;
            request.getSession().setAttribute("cantidadArchivos", cantidadArchivos);
            // System.out.println("Cantidad de archivos: " + cantidadArchivos);

            if (cantidadArchivos > -1) {
                usuario = request.getSession().getAttribute("login").toString();
                int i, contadorLineas = 0;
                int cantidadColumnas, idencabezado;
                String  delimitador, codtipoestrucarch, copy, estructuraColumnas, variablesSQL, accion, tipoRips, tablaRips, tipoCarga;

                ResultSet rs;
                PreparedStatement pstmt;



                //cantidadColumnas = Integer.parseInt(request.getParameter("cantidadColumnas"));

                idencabezado = Integer.parseInt(request.getParameter("idencabezado").replace('.', ','));
                nombreArchivo = request.getParameter("nombreArchivo");
                delimitador = request.getParameter("delimitador");
                codtipoestrucarch = request.getParameter("codtipoestrucarch");
                accion = request.getParameter("accion");
                tipoRip = request.getParameter("tipoRip");
                tipoRips = request.getParameter("tipoRips");
                tipoCarga = request.getParameter("tipoCarga");

                cantidadColumnas = Integer.parseInt(request.getParameter("cantidadColumnas"));

                String ripsValida = request.getParameter("ripsValida");

                // <editor-fold defaultstate="collapsed" desc="Codigo que construye los sql para el ingreso de estos en las tablas PoblacionPeriodico y PoblacionMaestro">
            /*Se construye la estructura del SQL para el ingreso de los datos dependiendo de la seleccion de columnas
                del usuario en el paso anterior*/
                //sql

                tablaRips = "";
                if (tipoRip.equals("US")) {
                    tablaRips = "ripsperiodicousuario";
                } else if (tipoRip.equals("AF")) {
                    tablaRips = "ripsperiodicofactura";
                } else if (tipoRips.equals("ips")) {
                    tablaRips = "ripsperiodicoips";
                } else if (tipoRips.equals("eap")) {
                    tablaRips = "ripsperiodicoeapb";
                }

                variablesSQL = "";
                estructuraColumnas = "";

                HashMap vars = new HashMap();
                vars = clases.UtilidadesDKDA.urlDecodificar(request.getParameter("varsSelecColumnas"), "");

                cargaArchivos.ConstruccionSQL sql;
                sql = new cargaArchivos.ConstruccionSQL(request, vars);
                estructuraColumnas = sql.construirEstructuraColumnas();
                variablesSQL = sql.construirVariablesSQL();


                String ruta = request.getSession().getServletContext().getRealPath("temp");
                //ruta = ruta.replaceAll("\\\\", "/");
                String file = ruta;
                ruta += System.getProperty("file.separator");

                boolean esUsOAf = true;
                String camposTabla = "";
                vA = new ed_ValidarArchivo();
                if (tipoRip.equals("US") || tipoRip.equals("AF")) {

                    file = vA.rutaRips(String.valueOf(idencabezado), nombreArchivo, file);
                    camposTabla = "idencabezado,idregistro," + estructuraColumnas;
                    copy = "COPY " + tablaRips + " (" + camposTabla + ") FROM '" + file + "' WITH DELIMITER '" + delimitador + "'";
                } else {
                    file = vA.rutaRips(String.valueOf(idencabezado), nombreArchivo, file);
                    camposTabla = "idencabezado,idregistro,codtiporips," + estructuraColumnas;
                    copy = "COPY " + tablaRips + " (" + camposTabla + ") FROM '" + file + "' WITH DELIMITER '" + delimitador + "'";
                    esUsOAf = false;
                }
                //  </editor-fold>
                //System.out.println( sqlRip );
                if (request.getSession().getAttribute("idencabezado" + encabezado(idencabezado)) != null) {

                    if (Integer.parseInt(request.getSession().getAttribute("idencabezado" + encabezado(idencabezado)).toString()) != idencabezado) {
                        request.getSession().setAttribute("copy" + encabezado(idencabezado), "");
                        request.getSession().setAttribute("hechos" + encabezado(idencabezado), "");
                        request.getSession().setAttribute("nombreArchivo" + encabezado(idencabezado), "");
                        request.getSession(false);
                    }
                }

                if (request.getSession().getAttribute("copy" + encabezado(idencabezado)) != null && !request.getSession().getAttribute("copy" + encabezado(idencabezado)).equals("")) {
                    request.getSession().setAttribute("copy" + encabezado(idencabezado), request.getSession().getAttribute("copy" + encabezado(idencabezado)) + " %% " + tipoRip + "-" + copy);
                    request.getSession().setAttribute("nombreArchivo" + encabezado(idencabezado), request.getSession().getAttribute("nombreArchivo" + encabezado(idencabezado)) + "-" + nombreArchivo);

                } else {
                    request.getSession().setAttribute("copy" + encabezado(idencabezado), tipoRip + "-" + copy);
                    request.getSession().setAttribute("idencabezado" + encabezado(idencabezado), idencabezado);
                    request.getSession().setAttribute("hechos" + encabezado(idencabezado), "");
                    request.getSession().setAttribute("nombreArchivo" + encabezado(idencabezado), nombreArchivo);

                }
                tipoCarga = ( tipoRips.equals("eap") ? "CargarRipsEAPB" :  tipoCarga );
                
                
                vA.validar(estructuraColumnas, ruta, nombreArchivo, request.getParameter("codregimen"),
                        idencabezado, request.getSession().getAttribute("login").toString(), request.getParameter("columnasSeleccionadas"), delimitador, ripsValida, tipoCarga, Integer.parseInt( request.getParameter("totalColumnas") ));
                con.cerrarConexion();

                System.out.println("COPY" + encabezado(idencabezado) + " : " + copy);
                //subirRips(request.getSession().getAttribute("copy").toString());
            }
        }
    }
    
    public String subirRips(String querys, HttpServletRequest request, int idencabezado, String archivos) {
        //System.out.println("Subiendo Los rips ...................................\n");
        retorno = "";
        datosInconsistencias = "";
        String tipoRip = "null"; 
        try {
            Connection conexion = bdS.getConexion();
            PreparedStatement stmt = null;

            //stmt = con.con.prepareStatement("SET CLIENT_ENCODING='SQL_ASCII'");
            stmt = conexion.prepareStatement("SET CLIENT_ENCODING='LATIN1'");
            stmt.execute();
            //stmt = null;


            String[] query = querys.split("%%");
            String[] nArchivos = archivos.split("-");
            
            for (int i = 0; i < query.length; i++) {
                String[] queryTipoRip = query[ i].split("-");
                tipoRip = queryTipoRip[0];

                //System.out.println("query "+ query[i]);
                //queryReducido = reducirQuery(querys, queryTipoRip[ 0], request, idencabezado);
                //System.out.println( "REDUCIDO: " + queryReducido );
               
                // Verifica que el archivo exista en la ruta indicada
                String archivo = request.getSession().getServletContext().getRealPath("temp") +
                        System.getProperty("file.separator") + idencabezado + System.getProperty("file.separator") + "copy_" + nArchivos[i];
                
                //System.out.println( archivo );
                String retorno = IncPoblacion.registrarInconsistenciaCopyRips( vA.rutaInconsistencias(String.valueOf(idencabezado) , nArchivos[i]) );
                
                if ( retorno == "insertadas" || retorno == "error" ){
                    
                    //Si para el rips hay inconsistencias - consultarlas.
                    //  URLS LOGS/INCONSISTENCIAS ->nArchivos[i] - tipoRip
                    // SELECT COUNT(*) FROM inconsarchivorips WHERE idencabezado = ? AND codtiporips ?
                    
                    
                    //USUS012011.TXT-
                  // System.out.println( "Inconsistenicas para Rips " + IncPoblacion.nInconsistenciasRip(idencabezado, nArchivos[i].substring(0, 2) ) );
                    
                   //vA.rutaRipsInconsistencias(String.valueOf(idencabezado) , nArchivos[i], request.getSession().getServletContext().getRealPath("temp"), "descInconsistencias");
                   datosInconsistencias += "Inconsistencias de archivo " + nArchivos[i].substring(0, 2) + "-"+ (retorno == "insertadas" ? IncPoblacion.nInconsistenciasRip(idencabezado, nArchivos[i].substring(0, 2)) : "Cantidad no disponible") +
                           "->Log|id="+ request.getSession().getAttribute("idencabezado" + encabezado(idencabezado)) + "&nombreArchivo=descInconsistencias_" + nArchivos[i] +
                           ":Inconsistentes|id="+ request.getSession().getAttribute("idencabezado" + encabezado(idencabezado)) +"&nombreArchivo=datosInconsistentes_" + nArchivos[i] + ",";
                   
                  System.out.println( "datosInconsistencias "+datosInconsistencias  );
                   
                   
                   
                   
                }                
                 if (! new java.io.File( archivo).exists()) {
                     //System.out.println("No se encontro el siguiente rip: "  + queryTipoRip[ 1]);
                     continue;
                 }

                 
                 
                stmt = conexion.prepareStatement(queryTipoRip[ 1]);
                stmt.execute();
                

                
                //reporteRipsSubidos += queryTipoRip[ 0] + ",";
                System.out.println("Consulta ejecutada...: " + (i + 1) + " de  " + query.length + " - " + queryTipoRip[0] + " ("+idencabezado+")");
                
                //Llamar al garbage collector.
                System.gc();

            }

            stmt.close();
            
        } catch (SQLException e) {
            //vA = new ed_ValidarArchivo();
            vA.generarLog( String.valueOf( idencabezado) , "("+tipoRip+") " + e.getMessage());
            System.out.println("Error Subirips( "+tipoRip+" ):   " + e.getMessage());
            e.printStackTrace();
            //reporteRipsMalSubidos += tipoRipFalla + ",";
            //ripsEstado.put(tipoRipFalla, "mal");
            subirRips(queryReducido, request, idencabezado, archivos);

        } 
        try {
            
            String fechaenvioCorte[] = request.getParameter("fechaenvio").split("-");
            String nuevaFechaEnvio = fechaenvioCorte[ 2] + "-" + fechaenvioCorte[ 1] + "-" + fechaenvioCorte[ 0];
            String fechaenvio = nuevaFechaEnvio + " 00:00:00";
            
            //System.out.println( fechaenvio ) ;
            Connection conexion = bdS.getConexion();
            PreparedStatement stUsuarios = null;
            stUsuarios = conexion.prepareStatement("UPDATE ripsperiodicousuario SET fecharegistro = '"+ fechaenvio +"' WHERE idencabezado = " + idencabezado);
            stUsuarios.execute();
            
            PreparedStatement ripsperiodicoeapb = null;
            ripsperiodicoeapb = conexion.prepareStatement("UPDATE ripsperiodicoeapb SET fecharegistro = '"+ fechaenvio +"' WHERE idencabezado = " + idencabezado);
            ripsperiodicoeapb.execute();
            
            PreparedStatement ripsperiodicoips = null;
            ripsperiodicoips = conexion.prepareStatement("UPDATE ripsperiodicoips SET fecharegistro = '"+ fechaenvio +"' WHERE idencabezado = " + idencabezado);
            ripsperiodicoips.execute();
            
            
            PreparedStatement ripsperiodicofactura = null;
            ripsperiodicofactura = conexion.prepareStatement("UPDATE ripsperiodicofactura  SET fecharegistro = '"+ fechaenvio +"' WHERE idencabezado = " + idencabezado);
            ripsperiodicofactura.execute();

            ripsperiodicoeapb.close();
            ripsperiodicofactura.close();
            ripsperiodicoips.close();
            
        } catch( SQLException e ) {
            System.out.println( "Error colocando fechas  " + e.getMessage() );
        }
        
        
        //System.out.println( retorno );
        
        retorno = datosInconsistencias;
        
        
        return retorno;

    }

//    public String reducirQuery(String querys, String actual, HttpServletRequest request, int idencabezado) {
//        System.out.println("Reducir: " + actual);
//        agregarAHechos(request, idencabezado, actual);
//        
//        String[] query = querys.split("%%");
//        
//        for (int i = 0; i < query.length; i++) {
//            String[] queryTipoRip = query[ i].split("-");
//            if(  actual.equals( queryTipoRip[ 0 ] ) ) {
//                continue;
//            }
//            if(  ! estaEnHechos(queryTipoRip[ 0 ], request, idencabezado) ) {
//                System.out.println( "Agregar a retorno" );
//                retorno += queryTipoRip[ 0 ]  + " - " + queryTipoRip[ 1 ] +  " %% ";
//            } else {
//                System.out.println( "NO Entra en comparacion hechos." );
//            }
//        }
//
//        return retorno;
//    }
//    public String agregarAHechos( HttpServletRequest request, int idencabezado, String actual ) {
//      request.getSession().setAttribute("hechos" + encabezado(idencabezado), request.getSession().getAttribute("hechos" + encabezado(idencabezado)) + "-" + actual);
//      return request.getSession().getAttribute("hechos" + encabezado(idencabezado)).toString();
//    }
    public String encabezado(int encabezado) {
        return "_" + encabezado + "";
    }
//    public boolean estaEnHechos( String cual, HttpServletRequest request, int idencabezado )  {
//        String hechosCorte[] = request.getSession().getAttribute("hechos" + encabezado(idencabezado)).toString().split("-");
//        for( int n = 0; n < hechosCorte.length; n++ ) {
//            if( hechosCorte[ n ].length() == 0 ) {
//                continue;
//            }
//            System.out.println( "Comparacion: " + hechosCorte[ n ] + " " + hechosCorte[ n ].length() + " con " + cual +" " +  cual.length() );
//            if( hechosCorte[ n ].equals( cual ) ) {
//                System.out.println("Entra");
//                return true;
//                
//            } 
//        }
//        
//        return false;
//        
//        
//    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CargarRips.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /** Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CargarRips.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /** Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
