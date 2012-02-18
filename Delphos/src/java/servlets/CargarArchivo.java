package servlets;

import clases.UtilidadesDKDA;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import clases.ConexionBaseDatos;
import clases.bdS;
import clases.ed_ValidarArchivo;
import controladores.Control;
import java.util.List;
import java.util.Iterator;

public class CargarArchivo {

    private String msj, ruta, delimitador, otroDelimitador, nombreArchivo, codregimen, codentidadsalud, codarchivo, nombrearchivo, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, copiadctoremis, proceso, grupopoblacion, tipoArchivo;
    
    private java.sql.Date fechainicial, fechafinal, horaenvio;
    private java.sql.Timestamp fechaenvio, fecharecibo;
    private int idEncabezado;
    private double coddepartamento, codmunicipio, registros;

    public int doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException {

        clases.VerificarUsuarioSistema v;
        v = new clases.VerificarUsuarioSistema(request, response);

        ed_ValidarArchivo validar;
        validar = new ed_ValidarArchivo();

        if (request.getParameter("hacerSubmit") != null && request.getParameter("hacerSubmit").equals("1")) {
            Connection conexion = bdS.getConexion();
            String codtipoestrucarch = "";
            ResultSet rs;
            PreparedStatement stmt;
            procesarParametros(request);

            // Registro en la base de datos del encabezado
            try {

                //Ruta donde se guardará temporalmente el archivo subido
                String ruta = (request.getSession().getServletContext().getRealPath("temp") + File.separatorChar).replaceAll("\\\\", "/");
                //Nombre del Archivo que se guardara en la Bd ; archivo que corresponde a "Copia Documento Remisorio"
                String archivo = ruta + copiadctoremis;
                String sql;


                if (request.getParameter("registrarEncabezado").equals("true")) {
                    System.out.println("REGISTRAR ENCABEZADO ...");
                    //Se obtiene el valor de la secuencia del encabezado
                    stmt = conexion.prepareStatement("SELECT nextval('idencabezado_seq') AS idEncabezado");
                    rs = stmt.executeQuery();
                    rs.next();
                    idEncabezado = rs.getInt("idEncabezado");
                    rs.close();
                    stmt.close();

                    sql = "INSERT INTO encabezadoarchivo "
                            + "(idencabezado," + //1
                            "codregimenes," + //2
                            "codentidadsalud," + //3
                            "fechainicial," + //4
                            "fechafinal," + //5
                            "codarchivo," + //6
                            "coddepartamento," + //7
                            "codmunicipio," + //8
                            "nombrearchivo," + //9
                            "codtipoarchivo," + //10
                            "nombreenvia," + //11
                            "telefonoenvia," + //12
                            "emailenvia," + //13
                            "fechaenvio," + //14
                            "fecharecibo," + //15
                            "registros," + //16
                            "proceso," + //17
                            "fecharegistro , " //18
                            + "copiadctoremis," // 19
                            + "codgrupopoblacion," // 20
                            + "tipocarga )" + //21
                            //" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,current_timestamp , lo_import('" + archivo + "'), ?, ?  )";
                            " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'" + fechaenvio + "' , lo_import('" + archivo + "'), ?, ?  )";


                    stmt = conexion.prepareStatement(sql);
                    stmt.setDouble(1, idEncabezado);
                    stmt.setString(2, codregimen);
                    stmt.setString(3, codentidadsalud);
                    stmt.setDate(4, fechainicial);
                    stmt.setDate(5, fechafinal);
                    stmt.setString(6, codarchivo);
                    stmt.setDouble(7, coddepartamento);
                    stmt.setDouble(8, codmunicipio);
                    stmt.setString(9, nombrearchivo);
                    stmt.setString(10, codtipoarchivo);
                    stmt.setString(11, nombreenvia);
                    stmt.setString(12, telefonoenvia);
                    stmt.setString(13, emailenvia);
                    stmt.setTimestamp(14, fechaenvio);
                    stmt.setTimestamp(15, fecharecibo);
                    stmt.setDouble(16, registros);
                    stmt.setString(17, (proceso == null ? "0" : proceso));
                    stmt.setInt(18, Integer.parseInt((grupopoblacion.equals("") ? "0" : grupopoblacion)));
                    stmt.setString(19, tipoArchivo);
                    stmt.executeUpdate();
                    stmt.close();

                } else {
                    String encabezado = request.getParameter("idencabezado");
                    UtilidadesDKDA.eliminarDirectorioSO((request.getSession().getServletContext().getRealPath("temp") + File.separatorChar).replaceAll("\\\\", "/") + encabezado);

                    // Poblacion
                    if (tipoArchivo.equals("poblacion")) {
                        try {


                            PreparedStatement coincpoblacion = null;
                            coincpoblacion = conexion.prepareStatement("DELETE  FROM coincpoblacion  WHERE idencabezado  = '" + encabezado + "'");
                            coincpoblacion.execute();


                            PreparedStatement coincamposreg = null;
                            coincamposreg = conexion.prepareStatement("DELETE  FROM coincamposreg  WHERE idencabezado  = '" + encabezado + "'");
                            coincamposreg.execute();

                            PreparedStatement inconarchafil = null;
                            inconarchafil = conexion.prepareStatement("DELETE  FROM inconarchafil  WHERE idencabezado  = '" + encabezado + "'");
                            inconarchafil.execute();


                            PreparedStatement st_pope = null;
                            st_pope = conexion.prepareStatement("DELETE  FROM poblacionperiodica  WHERE idencabezado  = '" + encabezado + "'");
                            st_pope.execute();

                        } catch (SQLException e) {
                            System.out.println("Error borrando informacion " + e.getMessage());
                        }

                        // Rips    
                    } else {
                        try {

                            if (request.getSession().getAttribute("idencabezado" + encabezado( Integer.parseInt( encabezado ) )) != null) {
                                request.getSession().setAttribute("copy" + encabezado(Integer.parseInt( encabezado )), "");
                                request.getSession().setAttribute("hechos" + encabezado(Integer.parseInt( encabezado )), "");
                                request.getSession().setAttribute("nombreArchivo" + encabezado(Integer.parseInt( encabezado )), "");
                                request.getSession(false);
                            }


                            PreparedStatement st_us = null;
                            st_us = conexion.prepareStatement("DELETE  FROM ripsperiodicousuario  WHERE idencabezado  = '" + encabezado + "'");
                            st_us.execute();
                            PreparedStatement st_af = null;
                            st_af = conexion.prepareStatement("DELETE  FROM ripsperiodicofactura  WHERE idencabezado  = '" + encabezado + "'");
                            st_af.execute();
                            PreparedStatement st_ips = null;
                            st_ips = conexion.prepareStatement("DELETE  FROM ripsperiodicoips  WHERE idencabezado  = '" + encabezado + "'");
                            st_ips.execute();
                            PreparedStatement st_eap = null;
                            st_eap = conexion.prepareStatement("DELETE  FROM ripsperiodicoeapb  WHERE idencabezado  = '" + encabezado + "'");
                            st_eap.execute();
                            PreparedStatement st_inco = null;
                            st_inco = conexion.prepareStatement("DELETE  FROM inconsarchivorips  WHERE idencabezado  = '" + encabezado + "'");
                            st_inco.execute();

                        } catch (SQLException e) {
                            System.out.println("Error borrando informacion " + e.getMessage());
                            validar.generarLog(encabezado, e.getMessage());
                        }
                    }


                    
                    sql = "UPDATE encabezadoarchivo SET "
                            + "codregimenes = ?," + // 1
                            "codentidadsalud = ?," + // 2
                            "fechainicial = ?," + // 3
                            "fechafinal = ?," + // 4
                            "codarchivo = ?," + // 5
                            "coddepartamento = ?," + // 6
                            "codmunicipio = ?," + // 7
                            "nombrearchivo = ?," + // 8
                            "codtipoarchivo = ?," + // 9
                            "nombreenvia = ?," + // 10
                            "telefonoenvia = ?," + // 11
                            "emailenvia = ?," + // 12
                            "fechaenvio = ?," + // 13
                            "fecharecibo = ?," + // 14
                            "registros = ?," + // 15
                            "proceso = ?," + // 16
                            "fecharegistro = '" + fechaenvio + "' , " + // 17
                            ( new File( archivo ).exists() ? "copiadctoremis = lo_import('" + archivo + "')," : "" ) + // 18
                            "codgrupopoblacion = ? ,"
                            + "tipocarga = ? " // 17
                            + "WHERE idencabezado = ? ";  // 18
                    
                    stmt = conexion.prepareStatement(sql);
                    stmt.setString(1, codregimen);
                    stmt.setString(2, codentidadsalud);
                    stmt.setDate(3, fechainicial);
                    stmt.setDate(4, fechafinal);
                    stmt.setString(5, codarchivo);
                    stmt.setDouble(6, coddepartamento);
                    stmt.setDouble(7, codmunicipio);
                    stmt.setString(8, nombrearchivo);
                    stmt.setString(9, codtipoarchivo);
                    stmt.setString(10, nombreenvia);
                    stmt.setString(11, telefonoenvia);
                    stmt.setString(12, emailenvia);
                    stmt.setTimestamp(13, fechaenvio);
                    stmt.setTimestamp(14, fecharecibo);
                    stmt.setDouble(15, registros);
                    stmt.setString(16, (proceso == null ? "0" : proceso));
                    stmt.setInt(17, Integer.parseInt((grupopoblacion.equals("") ? "0" : grupopoblacion)));
                    stmt.setString(18, tipoArchivo);
                    stmt.setInt(19, Integer.parseInt(request.getParameter("idencabezado")));
                    stmt.executeUpdate();
                    stmt.close();
                    System.out.println("ACTUALIZACION EJECUTADA" );

                }
            } catch (SQLException e) {
                System.out.println("Error 2" + e.getMessage());
                validar.generarLog(String.valueOf( request.getParameter("idencabezado") ), e.getMessage());
                
            } catch (Exception e) {
                System.err.println("Error 3 " + e.getMessage());
                validar.generarLog(String.valueOf( request.getParameter("idencabezado") ), e.getMessage());
                e.printStackTrace();
            }
            String pagina = "";
            if (request.getParameter("tipoCarga").equals("CargarPoblacion")) {
                pagina = "CargaArchivoPoblacion.jsp";
            } else if (request.getParameter("tipoCarga").equals("CargarRips")) {
                pagina = "CargaArchivoRips.jsp";
            }
            // Regresa el encabezado registrado ...
            int encabezadoId = 0;
            if (request.getParameter("registrarEncabezado").equals("true")) {

                try {
                    PreparedStatement st = conexion.prepareStatement("SELECT idencabezado AS encabezado FROM encabezadoarchivo ORDER BY idencabezado desc LIMIT 1");
                    ResultSet res = st.executeQuery();
                    res.next();
                    encabezadoId = res.getInt("encabezado");
                    System.out.println(encabezadoId);
                    res.close();
                } catch (SQLException sqlE) {
                    System.out.println("Error 4 " + sqlE.getMessage());
                    validar.generarLog(String.valueOf( request.getParameter("idencabezado") ), sqlE.getMessage());
                }
            } else {
                encabezadoId = Integer.parseInt(request.getParameter("idencabezado"));
            }
            
            return encabezadoId;

        } else {
            return 0;
        }
    }

    private void procesarParametros(javax.servlet.http.HttpServletRequest request) {
        nombreArchivo = request.getParameter("archivoASubir");
        delimitador = request.getParameter("delimitador");
        otroDelimitador = request.getParameter("otroDelimitador");
        codregimen = request.getParameter("codregimen");
        codentidadsalud = request.getParameter("codentidadsalud");
        fechainicial = UtilidadesDKDA.fechaToDate(request.getParameter("fechainicial").replace("-", "/"));
        fechafinal = UtilidadesDKDA.fechaToDate(request.getParameter("fechafinal").replace("-", "/"));
        codarchivo = request.getParameter("codarchivo");
        coddepartamento = Double.parseDouble(request.getParameter("coddepartamento"));
        codmunicipio = Double.parseDouble(request.getParameter("codmunicipio"));
        nombrearchivo = request.getParameter("nombreArchivo");
        codtipoarchivo = request.getParameter("codigoTipoArchivo");
        nombreenvia = request.getParameter("nombreenvia");
        telefonoenvia = request.getParameter("telefonoenvia");
        emailenvia = request.getParameter("emailenvia");
        String fechaenvioCorte[] = request.getParameter("fechaenvio").split("-");
        String nuevaFechaEnvio = fechaenvioCorte[ 2] + "-" + fechaenvioCorte[ 1] + "-" + fechaenvioCorte[ 0];

        fechaenvio = UtilidadesDKDA.fechaToTimeStamp(nuevaFechaEnvio + " 00:00:00");

        String fechareciboCorte[] = request.getParameter("fechaenvio").split("-");
        String nuevaFechaRecibo = fechareciboCorte[ 2] + "-" + fechareciboCorte[ 1] + "-" + fechareciboCorte[ 0];


        fecharecibo = UtilidadesDKDA.fechaToTimeStamp(nuevaFechaRecibo + " 00:00:00");
        String cRegistros = request.getParameter("registros");

        registros = Double.parseDouble(cRegistros.equals("") ? "0" : cRegistros);
        copiadctoremis = request.getParameter("nombreArchivo");
        proceso = request.getParameter("proceso");
        grupopoblacion = request.getParameter("grupopoblacion");
        tipoArchivo = request.getParameter("tipoArchivo").equals("") ? "poblacion" : request.getParameter("tipoArchivo");
    }
    public String encabezado(int encabezado) {
        return "_" + encabezado + "";
    }    
}
