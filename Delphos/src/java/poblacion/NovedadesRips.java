package poblacion;

import java.sql.*;
import clases.ConexionBaseDatos;
import clases.FormatoTimestamp;

public class NovedadesRips 
{
    String usuario;
    public NovedadesRips(String u) 
    {
        usuario = u;
    }
 
    //Registra las inconsistencias encontradas en la carga de los archivos Rips
    public void registrarInconsistencia(int idEncabezado, String codTipoRip, int idRegistro, String codTipoIncArch, String campo)
    {
        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        
        PreparedStatement pstmt = null;
        
        try
        {
            con.abrirConexion();
            
            ComunProcesos com = new ComunProcesos();
            
            pstmt = con.con.prepareStatement("INSERT INTO inconsarchivorips (idencabezado,codtiporips,codcampoarchivo,idregistro,codtipoincarch,codtipoglosarips,ususiscodigo,fecharegistro) VALUES (?,?,?,?,?,?,?,?)");
            pstmt.setInt(1,idEncabezado);
            pstmt.setString(2,codTipoRip);
            pstmt.setDouble(3,com.obtenerCodCampoArchivo(campo));
            pstmt.setInt(4,idRegistro);
            pstmt.setString(5,codTipoIncArch);
            pstmt.setString(6,""); //OJO GLOSA???
            pstmt.setString(7,usuario);
            pstmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
            pstmt.executeUpdate();
            pstmt.close();
            
            con.cerrarConexion();
        }
        catch(SQLException e)
        {
            System.err.println("Error NovedadesRips.registrarInconsistencia: "+e);
            con.cerrarConexion();
        }
    }
}