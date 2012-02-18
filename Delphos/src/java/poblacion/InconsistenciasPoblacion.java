package poblacion;

import java.sql.*;
import clases.ConexionBaseDatos;
import clases.FormatoTimestamp;
import clases.bdS;
import clases.ed_ValidarArchivo;

/**
 * Esta clase sera la encargada de registrar
 * las inconsistencias de poblacion presentes en la carga de un archivo.
 * @author PCGASOFT
 */
public class InconsistenciasPoblacion {

    String usuario;
    ConexionBaseDatos con;
    //Codigo del Encabezado Archivo
    int idEncabezado;
    //Numero de Inconsistencias de un Encabezado Especifico.
    private int CantInconsistencias;
    ed_ValidarArchivo vA;

    public InconsistenciasPoblacion() {
    }

    public InconsistenciasPoblacion(String u, Integer idEncabezado) {
        usuario = u;
        this.idEncabezado = idEncabezado;
        con = new ConexionBaseDatos();
    }

    /**
     * @deprecated Auditar el codigo para eliminacion
     * @param values
     */
    public void registrarInconsistencia2(String values) {
        PreparedStatement pstmt = null;
        try {                                   //inconarchafil - tmp_gaso
            con.abrirConexion();
            pstmt = con.con.prepareStatement("INSERT INTO tmp_gaso(idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch,ususiscodigo,fecharegistro,estado) VALUES " + values);
            pstmt.executeQuery();
            pstmt.close();
            con.cerrarConexion();
            System.out.println("Insertadas las incosistencias");
        } catch (SQLException e) {
            System.err.println("Error SQL registrarInconsistencia(): " + e);
            con.cerrarConexion();
        } catch (Exception e) {
            System.err.println("Error General registrarInconsistencia(): " + e);
        }
    }
    //Registra las inconsistencias encontradas en la carga de los archivos Rips

    public void registrarInconsistenciaed(String values) {
        // PreparedStatement pstmt = null;
        //System.out.println("registrarInconsistencia Rips " + values);
        if (values.length() >= 1) {
            try {                                   //inconarchafil - tmp_gaso
                con.abrirConexion();
                Statement stmt = con.con.createStatement();
                stmt.execute("INSERT INTO inconarchafil(idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch,ususiscodigo,fecharegistro,estado) VALUES " + values);
                stmt.close();
                con.cerrarConexion();
                setNoInconsistencias1(idEncabezado);
            } catch (SQLException e) {
                System.err.println("Error SQL registrarInconsistencia(): " + e);
                con.cerrarConexion();
            } catch (Exception e) {
                System.err.println("Error General registrarInconsistencia(): " + e);
            }
        }
    }
    static int cantidadInconsistencias = 0;

    public void registrarInconsistenciaCopy(String rutaInconsistencias) {

        //vA = new ed_ValidarArchivo();

        System.out.println("Ruta Inconsistencias registrarInconsistenciaCopy() " + rutaInconsistencias);
        //System.out.println("COPY inconarchafil(idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch,ususiscodigo,fecharegistro,estado) FROM  '" + rutaInconsistencias + "'  WITH DELIMITER ','");
        // PreparedStatement pstmt = null;
        if (new java.io.File(rutaInconsistencias).exists()) {
            try {                                   //inconarchafil - tmp_gaso
                Connection conexion = bdS.getConexion();
                Statement stmt = conexion.createStatement();
                stmt.execute("COPY inconarchafil(idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch,ususiscodigo,fecharegistro,estado) FROM  '" + rutaInconsistencias + "'  WITH DELIMITER ','");
                stmt.close();
                //con.cerrarConexion();
                //cantidadInconsistencias = getNoInconsistencias();
                System.out.println("Inconsistencias OK ...");
            } catch (SQLException e) {
                System.err.println("Error SQL registrarInconsistencia(): " + e);
            } catch (Exception e) {
                System.err.println("Error General registrarInconsistencia(): " + e);
            }
        } else {
            System.out.println("NO Existen inconsistencias para este archivo");
        }


    }

    public String registrarInconsistenciaCopyRips(String rutaInconsistencias) {
        
        //vA = new ed_ValidarArchivo();

        System.out.println("Ruta Inconsistencias registrarInconsistenciaCopy() " + rutaInconsistencias);
        //System.out.println("COPY inconarchafil(idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch,ususiscodigo,fecharegistro,estado) FROM  '" + rutaInconsistencias + "'  WITH DELIMITER ','");
        // PreparedStatement pstmt = null;
        if (new java.io.File(rutaInconsistencias).exists()) {
            try {                                   //inconarchafil - tmp_gaso
                Connection conexion = bdS.getConexion();
                Statement stmt = conexion.createStatement();
                stmt.execute("COPY inconsarchivorips(idregistro,codcampoarchivo,idencabezado,codtipoincarch,ususiscodigo,fecharegistro,estado,codtiporips,codtipoglosarips) FROM  '" + rutaInconsistencias + "'  WITH DELIMITER ','");
                stmt.close();
                //con.cerrarConexion();
                //cantidadInconsistencias = getNoInconsistencias();
                return "insertadas";
            } catch (SQLException e) {
                System.err.println("Error SQL registrarInconsistencia(): Rips " + e);
                con.cerrarConexion();
                return "error";
            } catch (Exception e) {
                System.err.println("Error General registrarInconsistencia() Rips: " + e);
                return "error";
            }
        } else {
            System.out.println("NO Existen inconsistencias para este archivo");
            return "";
        }


    }

    public int setNoInconsistencias(Integer noEncabezado) {
        int cantidad = 0;
        System.out.println(noEncabezado);
        try {
            con = new ConexionBaseDatos();
            con.abrirConexion();
            Statement st = con.con.createStatement();
            ResultSet res = st.executeQuery("SELECT COUNT(*) as total FROM  inconarchafil WHERE idencabezado = " + noEncabezado);
            res.next();
            cantidad = res.getInt("total");
            st.close();
            res.close();
            con.cerrarConexion();
//
            return cantidad;
        } catch (SQLException e) {
            con.cerrarConexion();
            CantInconsistencias = 0;
            System.err.println("Error SQL registrarInconsistencia(): " + e.getMessage());
            return -1;
        } catch (Exception e) {
            System.err.println("Error General registrarInconsistencia(): " + e.getMessage());
            CantInconsistencias = 0;
            return -1;
        }

    }

    public int getNoInconsistencias() {
        System.out.println("Cantidad de inconsistencias " + CantInconsistencias);
        return CantInconsistencias;
    }

    public void setNoInconsistencias1(int valor) {
        CantInconsistencias = valor;
    }

    public int nInconsistenciasRip(Integer noEncabezado, String tipoRip) {
        int numIncons = -1;
        System.out.println("SELECT COUNT(*) as tInconsis FROM inconsarchivorips WHERE idencabezado = " + idEncabezado + " AND codtiporips = '" + tipoRip.toUpperCase() + "'");
        try {
            con = new ConexionBaseDatos();
            con.abrirConexion();
            Statement st = con.con.createStatement();
            ResultSet res = st.executeQuery("SELECT COUNT(*) as tInconsis FROM inconsarchivorips WHERE idencabezado = " + idEncabezado + " AND codtiporips = '" + tipoRip.toUpperCase()+"'");
            res.next();
            numIncons = res.getInt("tInconsis");
            st.close();
            res.close();
            con.cerrarConexion();
//
            return numIncons;
        } catch (SQLException e) {
            con.cerrarConexion();
            System.err.println("Error SQL nInconsistenciasRip(): RIPS " + e.getMessage());
            return numIncons;
        } catch (Exception e) {
            System.err.println("Error General nInconsistenciasRip() RIPS: " + e.getMessage());
            return numIncons;
        }

    }
}
