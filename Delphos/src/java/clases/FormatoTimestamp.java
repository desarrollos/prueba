/*
 * FormatoTimestamp.java
 *
 * Created on 23 de julio de 2009, 07:01 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package clases;

import java.sql.Time;

/**
 *
 * @author Administrador
 */
public class FormatoTimestamp {
    
    /** Creates a new instance of FormatoTimestamp */
    public FormatoTimestamp() {
    }
    
    public static String fechaToDate2(String string) {
        
        
        String nuevaF = string.substring(6,10)+"-"+string.substring(3,5)+"-"+string.substring(0,2)+" "+string.substring(11,19);
        return nuevaF;
    }
    
    //fn:substring(string, begin, end)
    
    public static Time fechaToTime(String h, String m) {
        
        Time hora = Time.valueOf(h+":"+m+":00");
        //String nuevaF = string.substring(6,10)+"-"+string.substring(3,5)+"-"+string.substring(0,2)+":00";
        return hora;
    }
    
    public static String obtenerFechaActual()
    {
        java.util.Calendar FECHA = java.util.Calendar.getInstance();
        
        int d,m,a;
        String mes="",dia="",fechaActual="";
        
        d=FECHA.get(java.util.Calendar.DATE);
	m=FECHA.get(java.util.Calendar.MONTH);
	a=FECHA.get(java.util.Calendar.YEAR);

        switch (m)
        {
            case 0: mes="01";
            break;
            case 1: mes="02";
            break;
            case 2: mes="03";
            break;
            case 3: mes="04";
            break;
            case 4: mes="05";
            break;
            case 5: mes="06";
            break;
            case 6: mes="07";
            break;
            case 7: mes="08";
            break;
            case 8: mes="09";
            break;
            case 9: mes="10";
            break;
            case 10: mes="11";
            break;
            case 11: mes="12";
            break;
        }
        
        switch (d)
        {
            case 1: dia="01";
            break;
            case 2: dia="02";
            break;
            case 3: dia="03";
            break;
            case 4: dia="04";
            break;
            case 5: dia="05";
            break;
            case 6: dia="06";
            break;
            case 7: dia="07";
            break;
            case 8: dia="08";
            break;
            case 9: dia="09";
            break;
            default: dia = String.valueOf(d);
            break;
        }
        fechaActual=dia+"-"+mes+"-"+String.valueOf(a);
        return fechaActual;
    }
    
    public static String obtenerHoraActual()
    {
        java.util.Calendar FECHA = java.util.Calendar.getInstance();
        
        int h,min,sec;
        
        String hor,minut,segund,hora;
        
        h=FECHA.get(java.util.Calendar.HOUR_OF_DAY);
        min=FECHA.get(java.util.Calendar.MINUTE);
        sec=FECHA.get(java.util.Calendar.SECOND);

        switch (h)
        {
            case 0: hor="00";
            break;
            case 1: hor="01";
            break;
            case 2: hor="02";
            break;
            case 3: hor="03";
            break;
            case 4: hor="04";
            break;
            case 5: hor="05";
            break;
            case 6: hor="06";
            break;
            case 7: hor="07";
            break;
            case 8: hor="08";
            break;
            case 9: hor="09";
            break;
            default: hor = String.valueOf(h);
            break;
        }

        switch (min)
        {
            case 1: minut="01";
            break;
            case 2: minut="02";
            break;
            case 3: minut="03";
            break;
            case 4: minut="04";
            break;
            case 5: minut="05";
            break;
            case 6: minut="06";
            break;
            case 7: minut="07";
            break;
            case 8: minut="08";
            break;
            case 9: minut="09";
            break;
            default: minut = String.valueOf(min);
            break;
        }
        
        switch (sec)
        {
            case 1: segund="01";
            break;
            case 2: segund="02";
            break;
            case 3: segund="03";
            break;
            case 4: segund="04";
            break;
            case 5: segund="05";
            break;
            case 6: segund="06";
            break;
            case 7: segund="07";
            break;
            case 8: segund="08";
            break;
            case 9: segund="09";
            break;
            default: segund = String.valueOf(sec);
            break;
        }
        
         hora = hor+":"+minut+":"+segund; 
         return hora;
    }
    
}
