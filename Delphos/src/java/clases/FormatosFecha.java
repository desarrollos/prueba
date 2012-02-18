package clases;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;

public class FormatosFecha {
    
    public FormatosFecha() 
    {
    }
    
   public static String formatoFecha(Date fecha)
   {
        try
        {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return dateFormat.format(fecha);
        }
        catch(Exception e)
        {
            System.out.println("Excepcion: "+e);
            return "";
        }
   }
    
   public static String formatoFecha2(Date fecha)
   {
        try
        {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MMM/yyyy");
            return dateFormat.format(fecha);
        }
        catch(Exception e)
        {
            System.out.println("Excepcion: "+e);
            return "";
        }
   }
    
   public static String formatoDecimal(String parametros, double valor ) 
   {
        DecimalFormat Formato = new DecimalFormat(parametros);
        String salida = Formato.format(valor);
        return salida;
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
    
    public static String obtenerFechaActual2()
    {
        java.util.Calendar FECHA = java.util.Calendar.getInstance();
        
        int d,m,a;
        String mes="",dia="",fechaActual="";
        
        d=FECHA.get(java.util.Calendar.DATE);
	m=FECHA.get(java.util.Calendar.MONTH);
	a=FECHA.get(java.util.Calendar.YEAR);

        switch (m)
        {
            case 0: mes="Ene";
            break;
            case 1: mes="Feb";
            break;
            case 2: mes="Mar";
            break;
            case 3: mes="Abr";
            break;
            case 4: mes="May";
            break;
            case 5: mes="Jun";
            break;
            case 6: mes="Jul";
            break;
            case 7: mes="Ago";
            break;
            case 8: mes="Sep";
            break;
            case 9: mes="Oct";
            break;
            case 10: mes="Nov";
            break;
            case 11: mes="Dic";
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
        
        int h,min;
        
        String hor,minut,hora;
        
        h=FECHA.get(java.util.Calendar.HOUR_OF_DAY);
        min=FECHA.get(java.util.Calendar.MINUTE);

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
        
         hora = hor+":"+minut+":00"; 
         return hora;
    }
    
    
    public static long diasEntreFechas31Dias(Calendar fechaVieja, Calendar fechaActual)
    {
        int diaInicial,mesInicial,anoInicial,diaFinal,mesFinal,anoFinal,dias;
        
        final long msPerDay = 1000 * 60 * 60 * 24;

        final long date1Milliseconds = fechaVieja.getTime().getTime();
        final long date2Milliseconds = fechaActual.getTime().getTime();
        final long result = (date2Milliseconds - date1Milliseconds) / msPerDay;
        return result;
    }    
    
   public static java.sql.Date fechaToDate(String fecha)
    {
        java.sql.Date date;
        date = java.sql.Date.valueOf(fecha.substring(6,10)+"-"+fecha.substring(3,5)+"-"+fecha.substring(0,2));
        return date;
    }
      
    
    public static int edad(String fecha_nac) {     //fecha_nac debe tener el formato dd/MM/yyyy
   
        Date fechaActual = new Date();
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        String hoy = formato.format(fechaActual);
        String[] dat1 = fecha_nac.split("/");
        String[] dat2 = hoy.split("/");
        int anos = Integer.parseInt(dat2[2]) - Integer.parseInt(dat1[2]);
        int mes = Integer.parseInt(dat2[1]) - Integer.parseInt(dat1[1]);
        if (mes < 0) {
          anos = anos - 1;
        } else if (mes == 0) {
          int dia = Integer.parseInt(dat2[0]) - Integer.parseInt(dat1[0]);
          if (dia > 0) {
            anos = anos - 1;
          }
        }
        return anos;
    }

    public static String fechaToDate2(String string) {
        
        
        String nuevaF = string.substring(6,10)+"-"+string.substring(3,5)+"-"+string.substring(0,2)+" "+string.substring(11,19);
        return nuevaF;
    }
    
    
    
}
