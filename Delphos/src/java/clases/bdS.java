
package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author PCGASO
 */
public class bdS {

    //Instancia estatica de la conexion, sino uno llega a existir
    private static Connection connection = null;
    private static DataSource source;
    private InitialContext contexto;

    /**
     *
     * @return Devuelve la instancia unica de Conexion
     */
    public static Connection getConexion() {
        //Si la instancia no ha sido creado aun, se crea
        if (bdS.connection == null) {
            contruyendoConexion();
        }
        return bdS.connection;
    }

    //Obtener las instancias de Conexion JDBC
    private static void contruyendoConexion() {
        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/delphos?allowEncodingChanges=true";
            String usuario = "postgres";
            String clave = "armen1a@d3lph052011";
            // javax.sql.DataSource ds = (DataSource) contexto.lookup("java:comp/env/jdbc/delphos");
            bdS.connection = DriverManager.getConnection(url, usuario, clave);
        } catch (ClassNotFoundException e) {
            System.out.println("ClassNotFoundException(contruyendoConexion)  : " + e.getMessage());
            System.gc();
        } catch (SQLException e) {
            System.out.println("SQLException(contruyendoConexion) : " + e.getMessage());
            System.gc();
        } catch (Exception e) {
            System.out.println(" Exception General (contruyendoConexion) : " + e.getMessage());
            System.gc();
        }
    }

    public static void liberarConexionS(Connection conex) {
        try {
            conex.close();
        } catch (SQLException ex) {
            System.out.println( estadosSQL.getM(ex.getSQLState(), ex.getMessage()));
        }
    }

    private static void inicializarDataSorce(){
        try {
            // Obtenemos el pool.
            Context initCtx = new InitialContext();
            Context envCtx  = (Context) initCtx.lookup("java:comp/env");
            source     = (DataSource) envCtx.lookup("jdbc/delphos");
            // javax.sql.DataSource ds = (DataSource) contexto.lookup("java:comp/env/jdbc/delphos");
            //bdS.connection = DriverManager.getConnection(url, usuario, clave);

        } catch (Exception e) {
            System.out.println(" Exception General (inicializarDataSorce) : " + e.getMessage());
            System.gc();
        }
    }


    public static DataSource  getConexionD() {
        //Si la instancia no ha sido creado aun, se crea
        if (source == null) {
            inicializarDataSorce();
            System.out.println("Inicializando Contexto BD inicializarDataSorce");
        }
        System.out.println("... Retornando DataSource");
        return source;
    }

      /**
     * Cierra la conexion. Al provenir de BasicDataSource, en realidad no se
     * esta cerrando. La llamada a close() le indica al BasicDataSource que
     * hemos terminado con dicha conexion y que puede asignarsela a otro que la
     * pida.
     *
     * @param conexion
     */
    public static void liberaConexion(Connection conexion) {
        try {
            if (null != conexion) {
                // En realidad no cierra, solo libera la conexion.
                conexion.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
