package poblacion.comprobadorDerechos;

import clases.ConexionBaseDatos;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import poblacion.NovedadesRips;
import poblacion.NovedadesPoblacion;

public class ComprobadorDeDerechos 
{
    String usuario;
    public ComprobadorDeDerechos(String u) 
    {
        usuario = u;
    }
    
    /*
        idUsuario: Comun para los dos procesos.
        codContrato: Comun para los dos procesos.
        proceso: Comun para los dos procesos.
        idEncabezado: Para el proceso de RIPS.
        codTipoRips: Para el proceso de RIPS. Codigo del tipo de rip que se esta subiendo, tabla tiporips
        idRegistro:  Para el proceso de RIPS. Id del registro del archivo plano.
    */
    public void comprobarDerechos(double idUsuario, String codContrato, String proceso, int idEncabezado, String codTipoRips, int idRegistro)
    {
        ConexionBaseDatos con;
        PreparedStatement pstmt;
        ResultSet rs;
        
        if(proceso.toUpperCase().equals("POBLACION"))
        {
            con = new ConexionBaseDatos();
            con.abrirConexion();
            
            try
            {
                String codcontratoppal, codcontrato2, codcontrato3;
                
                pstmt = con.con.prepareStatement("SELECT codcontratoppal, codcontrato2, codcontrato3 FROM poblacion_ WHERE idusuario=?");
                pstmt.setDouble(1,idUsuario);
                rs = pstmt.executeQuery();
                rs.next();
                codcontratoppal = rs.getString("codcontratoppal");
                codcontrato2 = rs.getString("codcontrato2");
                codcontrato3 = rs.getString("codcontrato3");
                rs.close();
                pstmt.close();

                NovedadesPoblacion pob;
                pob = new NovedadesPoblacion(usuario);
                /*COMENTARIADO PORQUE ESTA EMPEZADO
                if(!codcontratoppal.isEmpty())
                {
                    if(codcontratoppal.equals(codContrato))
                        pob.registrarNovedad(pob.existeNovedadCampo("codcontratoppal"),idUsuario,"codcontratoppal",codcontratoppal,codContrato);
                }
                else if(!codcontrato2.isEmpty())
                {
                    if(codcontrato2.equals(codContrato))
                        pob.registrarNovedad(pob.existeNovedadCampo("codcontrato2"),idUsuario,"codcontrato2",codcontrato2,codContrato);
                }
                else if(!codcontrato3.isEmpty())
                {
                    if(codcontrato3.equals(codContrato))
                        pob.registrarNovedad(pob.existeNovedadCampo("codcontrato3"),idUsuario,"codcontrato3",codcontrato3,codContrato);
                }
                */
                con.cerrarConexion();
            }
            catch(SQLException e)
            {
                con.cerrarConexion();
                System.err.println("Error ComprobadorDeDerechos - POBLACION: "+e);
            }
        }
        else if(proceso.toUpperCase().equals("RIPS"))
        {
            con = new ConexionBaseDatos();
            con.abrirConexion();
            
            try
            {
                String codcontratoppal, codcontrato2, codcontrato3;
                
                pstmt = con.con.prepareStatement("SELECT codcontratoppal, codcontrato2, codcontrato3 FROM poblacion_ WHERE idusuario=?");
                pstmt.setDouble(1,idUsuario);
                rs = pstmt.executeQuery();
                rs.next();
                codcontratoppal = rs.getString("codcontratoppal");
                codcontrato2 = rs.getString("codcontrato2");
                codcontrato3 = rs.getString("codcontrato3");
                rs.close();
                pstmt.close();

                NovedadesRips rip;
                rip = new NovedadesRips(usuario);
                
                if(!codcontratoppal.isEmpty())
                {
                    if(codcontratoppal.equals(codContrato))
                        rip.registrarInconsistencia(idEncabezado,codTipoRips,idRegistro,"","codcontratoppal");
                }
                else if(!codcontrato2.isEmpty())
                {
                    if(codcontrato2.equals(codContrato))
                        rip.registrarInconsistencia(idEncabezado,codTipoRips,idRegistro,"","codcontrato2");
                }
                else if(!codcontrato3.isEmpty())
                {
                    if(codcontrato3.equals(codContrato))
                        rip.registrarInconsistencia(idEncabezado,codTipoRips,idRegistro,"","codcontrato3");
                }
                
                con.cerrarConexion();
            }
            catch(SQLException e)
            {
                con.cerrarConexion();
                System.err.println("Error ComprobadorDeDerechos - POBLACION: "+e);
            }
        }
    }
}
