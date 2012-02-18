package poblacion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import clases.ConexionBaseDatos;
import clases.bdS;
import java.sql.Connection;

public class ComunProcesos 
{
    ConexionBaseDatos con;
    
    public ComunProcesos() 
    {
        con = new ConexionBaseDatos();
    }

       
    //Obtiene el codigo del campo del archivo para el registro de la inconsistencia en el metodo "registrarIncArchAfil"
     public double obtenerCodCampoArchivo( String campo )
    {
        Connection conexion  = bdS.getConexion();
        double resultado = 0;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        
        try
        {
            
            pstmt = conexion.prepareStatement("SELECT codcampoarchivo FROM listacamposarchivo WHERE nombrecampotabla=?");
            pstmt.setString(1,campo);
            rs = pstmt.executeQuery();
            rs.next();
            resultado = rs.getDouble("codcampoarchivo");
            rs.close();
            pstmt.close();
            
            //con.cerrarConexion();
            return resultado;
        }
        catch(SQLException e)
        {
            System.err.println("Error Obtener CodCampoArchivo: "+e);
            
            return -1;
        }
        catch(Exception ex)
        {
            
            return 0;
        }
    }

     //Obtiene el codigo del campo del archivo para el registro de la inconsistencia en el metodo "registrarIncArchAfil"
     public double obtenerCodCampoArchivo( String campo  , String tabla )
    {
        Connection conexion  = bdS.getConexion();
        double resultado = 0;
        ResultSet rs = null;
        PreparedStatement pstmt = null;

        try
        {
            
            pstmt = conexion.prepareStatement("SELECT codcampoarchivo FROM listacamposarchivo WHERE nombrecampotabla=?  AND nombretabla=?");
            pstmt.setString(1,campo);
            pstmt.setString(2,tabla);
            rs = pstmt.executeQuery();
            rs.next();
            resultado = rs.getDouble("codcampoarchivo");
            rs.close();
            pstmt.close();

            //con.cerrarConexion();
            return resultado;
        }
        catch(SQLException e)
        {
            System.err.println("Error Obtener CodCampoArchivo: "+e);
           // con.cerrarConexion();
            return -1;
        }
        catch(Exception ex)
        {
           // con.cerrarConexion();
            return 0;
        }


    }

     //Obtiene el codigo del campo del archivo para el registro de la inconsistencia en el metodo "registrarIncArchAfil"
     public int obtenerCodCampoArchivoInt( String campo,String tabla )
    {
        Connection conexion  = bdS.getConexion();
        int resultado = 0;
        ResultSet rs = null;
        PreparedStatement pstmt = null;

        try
        {
            
            pstmt = conexion.prepareStatement("SELECT codcampoarchivo FROM listacamposarchivo WHERE nombrecampotabla=?  AND nombretabla=?");
            pstmt.setString(1,campo);
            pstmt.setString(2,tabla);
            rs = pstmt.executeQuery();
            rs.next();
            resultado = rs.getInt("codcampoarchivo");
            rs.close();
            pstmt.close();

            
            return resultado;
        }
        catch(SQLException e)
        {
            System.err.println("Error Obtener CodCampoArchivo: "+e);
            
            return -1;
        }
        catch(Exception ex)
        {
            
            return 0;
        }
    }
}