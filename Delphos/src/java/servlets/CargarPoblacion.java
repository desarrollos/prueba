package servlets;

import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import clases.ValidacionCamposBD;
import java.io.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.FormatoTimestamp;
import clases.bdS;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.*;
import javax.servlet.http.*;

import clases.ed_ValidarArchivo;
import java.sql.Connection;
import java.sql.Statement;
import poblacion.InconsistenciasPoblacion;


import poblacion.generarNovedades;

public class CargarPoblacion extends HttpServlet {

    String usuario;
    ConexionBaseDatos con;
    ed_ValidarArchivo vA;
    InconsistenciasPoblacion IncPoblacion;

    generarNovedades nov;

    int nInconsistencias=0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        /***/
        String ipaddress = request.getHeader("HTTP_X_FORWARDED_FOR");
        if (ipaddress  == null){
            ipaddress = request.getRemoteAddr();
        }
        System.out.println("Ip Cliente : "+ ipaddress);
        /***/
        
        System.out.println( "CANTDAD: " +  request.getParameter("totalReal") );
        
        clases.VerificarUsuarioSistema v;
        v = new clases.VerificarUsuarioSistema(request, response);
        
        vA = new ed_ValidarArchivo();
        nov  = new generarNovedades();

        usuario = request.getSession().getAttribute("login").toString();
        IncPoblacion = new InconsistenciasPoblacion(usuario , Integer.parseInt(request.getParameter("idencabezado"))  );
        int i, contadorLineas = 0;
        int cantidadColumnas, idencabezado;
        String nombreArchivo, delimitador, codtipoestrucarch, sqlPeriodico, sqlMaestro, estructuraColumnas, variablesSQL;

        ResultSet rs;
        PreparedStatement pstmt;

        con = new ConexionBaseDatos();
        con.abrirConexion();

//        System.out.println("---------------");
//        System.out.println("Encabezado: " + request.getParameter("idencabezado"));
//        System.out.println("Nombre archivo: " + request.getParameter("nombreArchivo"));
//        System.out.println("Delimitador: " + request.getParameter("delimitador"));
//        System.out.println("codtipoestrucarch: " + request.getParameter("codtipoestrucarch"));
//        System.out.println("codigo Regimen " + request.getParameter("codregimen"));
//        System.out.println("Cantidad de Columnas " + request.getParameter("cantidadColumnas"));
        //SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen=?
        //SELECT   ea.posicionfinal - ea.posicioninicial FROM estructuraarchivo ea , listacamposarchivo l WHERE ea.codtipoestrucarch= '1' AND l.codcampoarchivo = ea.codcampoarchivo AND l.nombrecampotabla = 'codtipoidentafiliado'
        System.out.println(request.getParameter("varsSelecColumnas"));
        HashMap vars = new HashMap();
        vars = clases.UtilidadesDKDA.urlDecodificar(request.getParameter("varsSelecColumnas"), "");

        cantidadColumnas = Integer.parseInt(request.getParameter("cantidadColumnas"));
        idencabezado = Integer.parseInt(request.getParameter("idencabezado").replace('.', ','));
        nombreArchivo = request.getParameter("nombreArchivo");
        delimitador = request.getParameter("delimitador");
        codtipoestrucarch = request.getParameter("codtipoestrucarch");
        System.out.println( "El delimitador " + delimitador );

        int codEntidadSalud = 0;
        try {
            pstmt = con.con.prepareStatement("SELECT codentidadsalud FROM encabezadoarchivo WHERE idencabezado=?");
            pstmt.setInt(1, idencabezado);
            rs = pstmt.executeQuery();
            rs.next();
            codEntidadSalud = rs.getInt("codentidadsalud");
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            System.out.println("Error SELECT codentidadsalud ");
        }

        // <editor-fold defaultstate="collapsed" desc="Codigo que construye los sql para el ingreso de estos en las tablas PoblacionPeriodico y PoblacionMaestro">
        /*Se construye la estructura del SQL para el ingreso de los datos dependiendo de la seleccion de columnas
        del usuario en el paso anterior*/
        //sql

        variablesSQL = "";
        estructuraColumnas = "";

        cargaArchivos.ConstruccionSQL sql;


        sql = new cargaArchivos.ConstruccionSQL(request, vars);


        estructuraColumnas = sql.construirEstructuraColumnas();
        //variablesSQL = sql.construirVariablesSQL();

        // Original periodico
        //sqlPeriodico = "INSERT INTO poblacionperiodica (idregistro,idencabezado," + estructuraColumnas + ") VALUES (?,?," + variablesSQL + ")";
        sqlPeriodico = "INSERT INTO poblacionperiodica (idregistro,idencabezado," + estructuraColumnas + ") VALUES ";
        sqlMaestro = "INSERT INTO poblacion (idusuario," + estructuraColumnas + ") VALUES (?," + variablesSQL + ")";

        //System.out.println("Estructura Columnas ****** " + estructuraColumnas);

        // </editor-fold>

        String ruta = request.getSession().getServletContext().getRealPath("temp") + System.getProperty("file.separator");
        //ruta = ruta.replaceAll("\\\\","/");

        File file = new File(ruta + nombreArchivo);



        // vA.getInformacionBD( estructuraColumnas );


        // vA.validar(estructuraColumnas, ruta , nombreArchivo);
        // vA.getInformacionBD( estructuraColumnas );


        //File file = new File("\\home\\gpi\\Comercial\\ArchivosSubidos\\"+request.getParameter("nombreArchivo"));
        FileReader fr = null;
        BufferedReader br = null;

        try {
            fr = new FileReader(file);
            br = new BufferedReader(new FileReader(file));

            String linea;
            Vector vectorTokensLinea;

            // <editor-fold defaultstate="collapsed" desc="Codigo que inserta y valida los registros del archivo">
            //Lee linea a linea el archivo

          



            StringBuffer values = new StringBuffer("");
            /** Esta variable almacenará los datos de poblacion periodica formatiados ( sin consecutivo , sin codigoencabezado )*/
            StringBuffer PoblacionPeriodica = new StringBuffer("");
            String inicio = "";
            StringBuffer sqlPeriodicoFinal = new StringBuffer("");


         //   System.out.println("Formato Fechas Poblacion " + request.getParameter( "formatoFecha" ));

            //System.out.println( "*Columnas seleccionadas*:  " +request.getParameter("columnasSeleccionadas") );


    //        System.out.println( "Antes de Iniciar " + System.currentTimeMillis() );

            //Validar Registros ED                                                                                                                                                                                                  //                                                
            vA.validar(estructuraColumnas, ruta, nombreArchivo, request.getParameter("codregimen"),  idencabezado, request.getSession().getAttribute("login").toString() , 
                    request.getParameter("columnasSeleccionadas") , delimitador, request.getParameter("codtipoestrucarch"), request.getParameter("tipoCarga") , Integer.parseInt( request.getParameter("totalColumnas") ));

//            System.out.println( "Ubicacion Poblacion Periodica " + vA.getUrlPoblacionPeriodica() );
//)

  //          System.out.println( "Despues de la validacion  " + System.currentTimeMillis() );




                String urlPoblacionP = vA.ruta(""+idencabezado , nombreArchivo);

            try {
//                Statement stmt = con.con.createStatement();
//                stmt.executeQuery("COPY poblacionperiodica ( idencabezado , idregistro ,"+ estructuraColumnas + ") FROM '" +  vA.ruta(""+idencabezado , nombreArchivo) + "' WITH DELIMITER '" +  delimitador +"'" );
//                stmt.close();
//                con.cerrarConexion();
                
                //Consultar : http://www.postgresql.org/docs/7.4/static/multibyte.html

                Connection conexion = bdS.getConexion();
                System.out.println( "COPY poblacionperiodica ( idencabezado , idregistro ,"+ estructuraColumnas + ") FROM '" +  urlPoblacionP + "' WITH DELIMITER '" +  delimitador +"'" );
                PreparedStatement stmt;
                //stmt = con.con.prepareStatement("SET CLIENT_ENCODING='SQL_ASCII'");
                stmt = conexion.prepareStatement("SET CLIENT_ENCODING='LATIN1'");
                stmt.execute(); 
                stmt.close();
                stmt = conexion.prepareStatement( "COPY poblacionperiodica ( idencabezado , idregistro ,"+ estructuraColumnas + ") FROM '" +  urlPoblacionP + "' WITH DELIMITER '" +  delimitador +"'" );
                stmt.execute();
                System.out.println("Insercion Exitosa a Poblacion Periodica :=) " + idencabezado );
                stmt.close();

                
                
                //Registro de inconsistencias
                IncPoblacion.registrarInconsistenciaCopy( vA.rutaInconsistencias(String.valueOf(idencabezado), nombreArchivo) );
               
                //Llamar al garbage collector.
                System.gc();
                                                                        //0-5--1-numeroidentafiliado;0-codtipoidentafiliado
//                System.out.println( request.getParameter("posTipoIDCedula") );
//                System.out.println( request.getParameter("posCampos") );

                //nov.generarN(estructuraColumnas ,ruta ,nombreArchivo , "0-numeroidentafiliado;5-codtipoidentafiliado" ,"1-primerapellido;2-segundoapellido;3-primernombre;4-segundonombre;8-fechanacimiento" , "fechanacimiento", vA.rutaDatosCorrectos(""+idencabezado , nombreArchivo) , ""+idencabezado);



            } catch (SQLException e) {
                System.out.println("Error Insertando a Poblacion Periodica: ( "+idencabezado+" ) " + e.getMessage());
                System.out.println("e.getErrorCode()" + e.getErrorCode() + " | "  + e.getSQLState());
                vA.generarLog( String.valueOf( idencabezado ), e.getMessage());
               // e.printStackTrace();
                System.gc();
            }

//            System.out.println( "Ruta Poblacion: " + vA.getUrlPoblacionPeriodica() );
//            System.out.println( "Ruta Inconsistencias: " +  vA.getUrlInconsistencias() );


            fr.close();
            br.close();
            // </editor-fold>
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        con.cerrarConexion();

    }


    public int nInconsistencias(){
        return  nInconsistencias;
    }
    /*************************************************************************************************************************/
    private void comprobarNovedades(int idRegistro, int idEncabezado) {
        /*ConexionBaseDatos con;
        con = new ConexionBaseDatos();*/

        ResultSet rs = null, rs2 = null;
        PreparedStatement pstmt = null, pstmt2 = null;

        String numIdenAfiliado = "";

        try {
            //con.abrirConexion();

            pstmt = con.con.prepareStatement("SELECT * FROM poblacionperiodica WHERE idregistro=? AND idencabezado=?");
            pstmt.setInt(1, idRegistro);
            pstmt.setInt(2, idEncabezado);

            rs = pstmt.executeQuery();
            rs.next();
            numIdenAfiliado = rs.getString("numeroidentafiliado");

            pstmt2 = con.con.prepareStatement("SELECT * FROM poblacion WHERE numeroidentafiliado=?");
            pstmt2.setString(1, numIdenAfiliado);
            rs2 = pstmt2.executeQuery();
            rs2.next();

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                String campo, codNovedad = "";

                campo = rs.getMetaData().getColumnName(i);

                poblacion.NovedadesPoblacion pob;
                pob = new poblacion.NovedadesPoblacion(usuario);

                codNovedad = pob.existeNovedadCampo(campo);

                if (!codNovedad.equals("")) {
                    String valorAnterior, valorNuevo;
                    valorAnterior = rs2.getString(campo);
                    valorNuevo = rs.getString(campo);

                    if (valorAnterior != null && valorNuevo != null && !(valorAnterior.equals(valorNuevo))) {
                        pob.registrarNovedad(codNovedad, rs2.getInt("idusuario"), campo, valorAnterior, valorNuevo, idEncabezado);
                    }
                }
            }

            rs.close();
            pstmt.close();
                
            //con.cerrarConexion();
        } catch (SQLException e) {
            System.err.println("Error Obtener CodCampoArchivo: "+e);
            //con.cerrarConexion();
        }
    }

    /*************************************************************************************************************************/
    //Realiza la validacion del registro ingresado en la tabla poblacionperiodica y de existir alguna, es registrada la inconsistencia
    //con el metodo "registrarIncArchAfil"
    private void validarRegistro(int idRegistro, int idEncabezado) {
        /*ConexionBaseDatos con;
        con = new ConexionBaseDatos();*/

        ResultSet rs = null;
        PreparedStatement pstmt = null;

        try {
            //con.abrirConexion();

            pstmt = con.con.prepareStatement("SELECT * FROM poblacionperiodica WHERE idregistro=? AND idencabezado=?");
            pstmt.setInt(1, idRegistro);
            pstmt.setInt(2, idEncabezado);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String resultadoValidacion, campo, valorCampo;

                for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                    campo = rs.getMetaData().getColumnName(i);
                    valorCampo = rs.getString(campo);

                    ValidacionCamposBD v;
                    v = new ValidacionCamposBD();

                    resultadoValidacion = v.validar("poblacion", campo, valorCampo);
                    if (!resultadoValidacion.equals("OK")) {
                        registrarIncArchAfil(idRegistro, campo, idEncabezado, resultadoValidacion);
                    }
                }
            }
            rs.close();
            pstmt.close();

            //con.cerrarConexion();
        } catch (SQLException e) {
            System.err.println("Error Obtener CodCampoArchivo: "+e);
            //con.cerrarConexion();
        }
    }

    //Registra las inconsistencias encontradas en la tabla incarchafil
    private void registrarIncArchAfil(int idRegistro, String campoTabla, int idEncabezado, String codigoError) {
        /*ConexionBaseDatos con;
        con = new ConexionBaseDatos();*/

        PreparedStatement pstmt = null;

        try {
            //con.abrirConexion();

            poblacion.NovedadesPoblacion pob;
            pob = new poblacion.NovedadesPoblacion(usuario);

            poblacion.ComunProcesos com;
            com = new poblacion.ComunProcesos();

            pstmt = con.con.prepareStatement("INSERT INTO inconarchafil (idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch,estado) VALUES (?,?,?,?,?,?)");
            pstmt.setInt(1, idRegistro);
            pstmt.setDouble(2, com.obtenerCodCampoArchivo(campoTabla));
            pstmt.setInt(3, idEncabezado);
            pstmt.setString(4, codigoError);
            pstmt.setString(5, codigoError);
            pstmt.setString(6, "SIN VALIDAR");
            pstmt.executeUpdate();

            pstmt.close();

            //con.cerrarConexion();
        } catch (SQLException e) {
            System.err.println("Error registrando IncArchAfil: " + e);
            //con.cerrarConexion();
        }
    }

    /*************************************************************************************************************************/
    //Obtiene el consecutivo para el id del registro de la tabla poblacion periodica
    private int obtenerIdRegistroPoblacionPeriodica() {
        int resultado = 0;
        /*ConexionBaseDatos con;
        con = new ConexionBaseDatos();*/

        ResultSet rs = null;
        PreparedStatement pstmt = null;

        try {
            //con.abrirConexion();

            pstmt = con.con.prepareStatement("SELECT MAX(idregistro) AS id FROM poblacionperiodica");
            rs = pstmt.executeQuery();

            rs.next();
            resultado = rs.getInt("id");
            rs.close();
            pstmt.close();

            //con.cerrarConexion();
            return (resultado + 1);
        } catch (SQLException e) {
            System.out.println("Error obtenerIdRegistroPoblacionPeriodica() " + e);
            //con.cerrarConexion();
            return -1;
        }
    }

    /*************************************************************************************************************************/
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
            System.out.println("Error " + ex);
            Logger.getLogger(CargarPoblacion.class.getName()).log(Level.SEVERE, null, ex);
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
            System.out.println("Error doPost " + ex );
            Logger.getLogger(CargarPoblacion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /** Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
