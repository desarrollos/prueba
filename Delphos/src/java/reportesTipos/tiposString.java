/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package reportesTipos;

/**
 *
 * @author Administrador
 */
public class tiposString
{
    public String tipoCampo( String tabla, int pos, int tam ){
        return tipos(tabla, pos, tam);
    }

    public String tipos( String tabla, int pos, int tam )
    {
        String tipos[] = new String[ tam ];
       
        if( tabla.equals("encuentroreunion") ) {
            tipos[ 0 ] = "java.lang.String";
            tipos[ 1 ] = "java.lang.String";
            tipos[ 2 ] = "java.lang.String";
            tipos[ 3 ] = "java.lang.Integer";

        }
        return tipos[ pos ];
    }
    
}