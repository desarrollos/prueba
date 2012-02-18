package poblacion;

import java.sql.*;
import clases.ConexionBaseDatos;
import clases.FormatoTimestamp;


public class NovedadesPoblacion 
{
    String usuario;
    ConexionBaseDatos con;
    
    public NovedadesPoblacion(String u)
    {
        usuario = u;
        
        con = new ConexionBaseDatos();
    }
    
    //Verifica si existe registrada una novedad para el campo en analisis en la tabla "tiponovedad" para registrar esta.
    public String existeNovedadCampo(String campo)
    {
        
        
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        
        String codNovedad = "";
        
        try
        {
            con.abrirConexion();
            
            pstmt = con.con.prepareStatement("SELECT codtiponovedad FROM tiponovedad WHERE descripcion=?");
            pstmt.setString(1,campo);
            rs = pstmt.executeQuery();
            if(rs.next())
                codNovedad = rs.getString("codtiponovedad");
            else
                codNovedad = "";
            rs.close();
            pstmt.close();
            
            con.cerrarConexion();
            return codNovedad;
        }
        catch(SQLException e)
        {
            System.err.println("Error existeNovedadCampo: "+e);
            con.cerrarConexion();
            return "";
        }
    }
    
    //Registra las novedades detectadas en el metodo "comprobarNovedades" en la tabla "novedadcampo"
    public void registrarNovedad(String codNovedad, double idUsuario, String campo, String valorAnterior, String valorNuevo, double idEncabezado)
    {
        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        
        PreparedStatement pstmt = null;
        
        try
        {
            con.abrirConexion();
            
            ComunProcesos com = new ComunProcesos();
            
            pstmt = con.con.prepareStatement("INSERT INTO novedadcampo (idusuario,codtiponovedad,codcampoarchivo,fecha,datoanterior,datoactualizado,observacion,ususiscodigo,fecharegistro,codestadoregistro,idencabezado) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            pstmt.setDouble(1,idUsuario);
            pstmt.setString(2,codNovedad);
            pstmt.setDouble(3,com.obtenerCodCampoArchivo(campo));
            pstmt.setTimestamp(4,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
            pstmt.setString(5,valorAnterior);
            pstmt.setString(6,valorNuevo);
            pstmt.setString(7,"");
            pstmt.setString(8,usuario);
            pstmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
            pstmt.setString(10,"SVAL");
            pstmt.setDouble(11,idEncabezado);
            pstmt.executeUpdate();
            pstmt.close();
            
            con.cerrarConexion();
        }
        catch(SQLException e)
        {
            System.err.println("Error NovedadesPoblacion.registrarNovedad: "+e);
            con.cerrarConexion();
        }
    }
}
