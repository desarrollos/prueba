/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ed_ValidacionCampos {

    /** Lista de Objetos que contedra las Extensiones que no son permitidas subir al servidor */
    ArrayList ed_ExtensionesBan;

    public boolean validacion(int tipo, String txt) {

        boolean result = false;

        if (tipo == 1) {
            result = moneda(txt);
        } else if (tipo == 2) {
            result = caracteres(txt);
        } else if (tipo == 3) {
            result = fecha(txt);
        }


        return result;

    }

    /**
     *  Este metodo valida que el string que
     *  se haya ingresado contenga solo numeros.
     *  <strong>Se Permiten los signos de $ y los puntos (.)</strong>
     *
     * @param text String que ser? validado.
     * @return Boolean indicado si cumple o no con la validacion.
     */
    public boolean moneda(String text) {
        // validacion texto /^([a-záéíóú?A-Z]+\s*)+$/ ("^[0-9]+\\.{1,}$");
        //^[0-9-\.\$]+$
        Pattern pc = Pattern.compile("^[0-9-\\.\\$]+$");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();

        return valido;
    }

    /**
     * Este metodo evalua si un string cumple con la condicion dada
     * en la ER. Que solo sean Texto.
     * <strong>Se Permiten los espacios entre caracteres</strong>
     * @param text String que ser? validado.
     * @return Boolean indicado si cumple o no con la validacion.
     */
    public boolean caracteres(String text) {
        // Pattern pc = Pattern.compile("^([a-záéíóú??A-Z]+\\s*)+$");
        Pattern pc = Pattern.compile("^([a-záéíóúÁÉÍÓÚ\u00f1\u00d1A-Z]+\\s*)+$");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();
        return valido;
    }

    /**
     * Este metodo evalua si un string cumple con la condicion dada
     * en la ER. Solo numeros
     * <strong>NO SE Permiten los espacios entre numeros</strong>
     * <p>Permite numeros Negativos</p>
     * @param text String que ser? validado.
     * @return Boolean indicado si cumple o no con la validacion.
     */
    public boolean numeros(String text) {
        Pattern pc = Pattern.compile("(-?\\d+)");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();

        return valido;
    }

    public boolean alfaNumericos(String text) {
        // Pattern pc = Pattern.compile("((?:[a-zA-Z][a-zA-Z]*[0-9]+[a-zA-Z0-9]*))");
        Pattern pc = Pattern.compile("^[A-Z0-9 a-z]*$");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();

        return valido;
    }

     public boolean hora(String text) {
        Pattern pc = Pattern.compile("((?:(?:[0-1][0-9])|(?:[2][0-3])|(?:[0-9])):(?:[0-5][0-9])(?::[0-5][0-9])?(?:\\s?(?:am|AM|pm|PM))?)");
        Matcher m = pc.matcher(text);
        return m.matches();
    }

    /**
     * G    Guión, -        => aNTES DE LA A
     * Gb   Guión bajo, _
     * S    Slash, \\/
     * E    Espacio, \\s+
     * Pa   Parentesis, \\(  \\) 
     * L    Llaves, \\{ \\}
     * C    Corchetes, \\[ \\]
     * Pu   Puntos, \\.
     * Por  Porcentajes, %
     * Pc   Punto y Coma, ;
     * Dp   Dos Puntos :
     * 
     * repetir de 0 a 1 vez => %?
     * 
     */
    
    
    /**
     * Permitir Guión, Guión bajo, Slash, Espacio, 
     * Parentesis, Llaves, Corchetes, 
     * Puntos, Porcentajes, Punto y Coma, Dos Puntos
     * @param text
     * @return 
     */
    
    public boolean CDpEGGbLPPorPcPuS(String text) {
        Pattern pc = Pattern.compile("^[-_A-Z0-9:\\[ \\]\\s+\\{ \\}\\(  \\);\\.\\/áéíóúÁÉÍÓÚ\u00f1\u00d1a-z]*$");
        Matcher m = pc.matcher(text);
        return m.matches();
    }
    
     /**
     * Permitir Guión, Guión bajo,
     * Slash, Espacio, Parentesis, 
     * Llaves, Corchetes, Puntos,  
     * Punto y Coma, Dos Puntos
     * @param text
     * @return 
     */
    
    public boolean CDpEGGbLPPcPuS(String text) {
        Pattern pc = Pattern.compile("^[-A-Z0-9 \\[ \\] : \\s+  _ \\{ \\}  \\(  \\) ; \\.  \\/ áéíóúÁÉÍÓÚ\u00f1\u00d1a-z]*$");
        Matcher m = pc.matcher(text);
        return m.matches();
    }
    
    /**
     * Permitir Guión, Guión bajo,
     * Slash, Espacio, 
     * Parentesis, Llaves, 
     * Corchetes, Punto y 
     * Punto y Coma
     * @param text
     * @return 
     */
    
    public boolean CEGGbLPPcPuS(String text) {
        Pattern pc = Pattern.compile("^[-A-Z0-9 \\[ \\] \\s+ _ \\{ \\} \\(  \\) ; \\. \\/ áéíóúÁÉÍÓÚ\u00f1\u00d1a-z]*$");
        Matcher m = pc.matcher(text);
        return m.matches();
    }
    
    
     /**
     * Permitir Guión, Guión bajo,
     * Slash, Espacio, 
     * Parentesis, Llaves, 
     * Corchetes y Puntos
     * @param text
     * @return 
     */
    
    public boolean CEGGbLPPuS(String text) {
        Pattern pc = Pattern.compile("^[-A-Z0-9 \\[ \\] \\s+ _ \\{ \\} \\(  \\) \\. \\/ áéíóúÁÉÍÓÚ\u00f1\u00d1a-z]*$");
        Matcher m = pc.matcher(text);
        return m.matches();
    }
    
    /**
     * Permitir Guión,Slash
     * @param text
     * @return
     * @deprecated 
     */
    
    public boolean GS(String text) {
        Pattern pc = Pattern.compile("^[-A-Z0-9áéíóúÁÉÍÓÚ\u00f1\u00d1a-z\\/]*$");
        Matcher m = pc.matcher(text);
        return m.matches();
    }
    
    /**
     * Permitir Guión,Espacio
     * @param text
     * @return
     * @deprecated 
     */
    
    public boolean EG(String text) {
        Pattern pc = Pattern.compile("^[-A-Z0-9 áéíóúÁÉÍÓÚ\u00f1\u00d1a-z]*$");
        Matcher m = pc.matcher(text);
        return m.matches();
    }
    
    /**
     * Permitir Guión y Numeros
     * @param text
     * @return
     *  
     */
    
    public boolean G(String text) {
        Pattern pc = Pattern.compile("(^[0-9]*)(-{0,1})([0-9])$");
        Matcher m = pc.matcher(text);
        return m.matches();
    }

    public boolean numDecimal(String text) {
        Pattern pc = Pattern.compile("^(\\d|-)?(\\d|,)*\\.?\\d*$");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();

        return valido;
    }

    public String NomApe(String text) {

        String texto = text;

        ArrayList caracteres = new ArrayList();

        caracteres.add("_");
        caracteres.add(" ");
        caracteres.add("!");
        caracteres.add("?");
        caracteres.add("-");
        caracteres.add("0");
        caracteres.add("1");
        caracteres.add("2");
        caracteres.add("3");
        caracteres.add("4");
        caracteres.add("5");
        caracteres.add("6");
        caracteres.add("7");
        caracteres.add("8");
        caracteres.add("9");

        caracteres.add("|");
        caracteres.add("'");
        caracteres.add("#");
        caracteres.add("$");
        caracteres.add("&");
        caracteres.add("/");
        caracteres.add("(");
        caracteres.add(")");
        caracteres.add("=");

        for (int i = 0; i < caracteres.size(); i++) {
            if (texto.contains(caracteres.get(i).toString())) {
                texto = texto.replace(caracteres.get(i).toString(), "");
            }
        }

        return texto;
    }

    public boolean correo(String text) {

        //practical implementation of RFC 2822

        //Pattern pc = Pattern.compile("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
        Pattern pc = Pattern.compile("^[^0-9][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();

        return valido;
    }

    public boolean url(String text) {

        //practical implementation of RFC 2822

        //Pattern pc = Pattern.compile("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
        Pattern pc = Pattern.compile("^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\?=.-]*)*\\/?$");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();

        return valido;
    }

    /**
     * Fecha DIA - MES - A?O
     * @param text
     * @return
     */
    public boolean fecha_DMA(String text) {
        String separador = "";
        boolean valido = false;
        if (text.contains("/")) {
            separador = "/";
        }
        if (text.contains("-")) {
            separador = "-";
        }

        if (!"".equals(separador)) {
            Pattern pc = Pattern.compile("((?:(?:[0-2]?\\d{1})|(?:[3][01]{1}))[-:\\" + separador + ".](?:[0]?[1-9]|[1][012])[-:\\" + separador + ".](?:(?:[1]{1}\\d{1}\\d{1}\\d{1})|(?:[2]{1}\\d{3})))(?![\\d])");
            Matcher m = pc.matcher(text);
            valido = m.matches();
            return valido;
        } else {
            return valido;
        }
    }

    /**
     * Fecha  MES -  DIA - A?O
     * @param text
     * @return
     */
    public boolean fecha_MDA(String text) {
        String separador = "";
        boolean valido = false;
        if (text.contains("/")) {
            separador = "/";
        }
        if (text.contains("-")) {
            separador = "-";
        }

        if (!"".equals(separador)) {
            Pattern pc = Pattern.compile("((?:[0]?[1-9]|[1][012])[-:\\" + separador + ".](?:(?:[0-2]?\\d{1})|(?:[3][01]{1}))[-:\\" + separador + ".](?:(?:[1]{1}\\d{1}\\d{1}\\d{1})|(?:[2]{1}\\d{3})))(?![\\d])");
            Matcher m = pc.matcher(text);
            valido = m.matches();
            return valido;
        } else {
            return valido;
        }
    }

    /**
     * Fecha   A?O - MES -  DIA 
     * @param text
     * @return
     */
    public boolean fecha_AMD(String text) {
        String separador = "";
        boolean valido = false;
        if (text.contains("/")) {
            separador = "/";
        }
        if (text.contains("-")) {
            separador = "-";
        }

        if (!"".equals(separador)) {
            Pattern pc = Pattern.compile("((?:(?:[1]{1}\\d{1}\\d{1}\\d{1})|(?:[2]{1}\\d{3}))[-:\\" + separador + ".](?:[0]?[1-9]|[1][012])[-:\\" + separador + ".](?:(?:[0-2]?\\d{1})|(?:[3][01]{1})))(?![\\d])");
            Matcher m = pc.matcher(text);
            valido = m.matches();
            return valido;
        } else {
            return valido;
        }
    }

    public boolean fecha(String text) {
        Pattern pc = Pattern.compile("[0-9]+");
        Matcher m = pc.matcher(text);
        boolean valido = m.matches();

        return valido;
    }

    /**
     * Este metodo extrae los numeros de una cadena de
     * caracteres ; quitando los puntos y caracteres.
     * @param text
     * @return
     * @deprecated En Desarrollo
     */
    public String numerosExtraer(String text) {
        String aRemplazar = text;

        String re1 = "(\\d+)";	// Integer Number 1
        String re2 = ".*?";	// Non-greedy match on filler
        String re3 = "(\\d+)";	// Integer Number 2

        Pattern p = Pattern.compile(re1 + re2 + re3, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
        Matcher m = p.matcher(aRemplazar);
        if (m.find()) {
            String int1 = m.group(1);
            String int2 = m.group(2);
            System.out.print("(" + int1.toString() + ")" + "\n");

            aRemplazar = m.group(1) + m.group(2);
        } else {
            aRemplazar = "";
        }


        return aRemplazar;
    }

    /**
     * Esta funcion convierte una frase a "Tipo Titulo"
     * @param s String que sera convertido
     * @return s String Convertido
     */
    public String textotipotitulo(String s) {
        for (int i = 0; i < s.length(); i++) {

            if (i == 0) {
                // Mayuscula de la primera letra de la cadena.
                s = String.format("%s%s",
                        Character.toUpperCase(s.charAt(0)),
                        s.substring(1));
            }

            // Is this character a non-letter or non-digit?  If so
            // Entonces esto es probablemente un límite de palabra así que vamos a aprovechar
            // the next character in the sequence.
            if (!Character.isLetterOrDigit(s.charAt(i))) {
                if (i + 1 < s.length()) {
                    s = String.format("%s%s%s",
                            s.subSequence(0, i + 1),
                            Character.toUpperCase(s.charAt(i + 1)),
                            s.substring(i + 2));
                }
            }

        }

        return s;

    }

    public String parteString(String s) {
        String txt = s;

        String re1 = "(\\d+)";	// Integer Number 1
        String re2 = "((?:[a-z][a-z0-9_]*))";	// Variable Name 1

        Pattern p = Pattern.compile(re1 + re2, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
        Matcher m = p.matcher(txt);
        if (m.find()) {
            String int1 = m.group(1);
            String var1 = m.group(2);
            System.out.print(int1.toString() + "" + var1.toString());
        }
        return s;
    }
    /*
    
     * Quitar elementos de una cadena con expresiones regulares.
     *
     *
    String aRemplazar="hola como estas";
    Pattern p= Pattern.compile("[ao]");
    Matcher m= p.matcher(aRemplazar);
    if(m.find())
    {
    String remplazado=m.replaceAll("");
    System.out.println(remplazado); //imprime hl cm ests
    }
     */
    /* Quitar elementos de un String sin expresiones regulares
     *
     *  String aRemplazar="hola como estas";
    String remplazado=aRemplazar.replace("a", "");
    System.out.println(remplazado);//imprime hol como ests
     *
     * */

    /**
     * Comprueba que la extension del archivo no sea "peligrosa" para subirla al servidor.
     * @param ed_nombreArchivo Nombre del Archivo que sera comprobada la Extension. 
     * @return true si no es permitda la Extension , false si no contiene ningun peligro
     */
    public boolean extensionInvalida(String ed_nombreArchivo) {

        if (ed_nombreArchivo.length() - 5 > 0) {

            ArrayList ed_ExtensionesBan = new ArrayList();

            ed_ExtensionesBan.add("sh");
            ed_ExtensionesBan.add("exe");
            ed_ExtensionesBan.add("bat");
            ed_ExtensionesBan.add("cmd");
            ed_ExtensionesBan.add("msi");
            ed_ExtensionesBan.add("dll");
            ed_ExtensionesBan.add("bin");
            ed_ExtensionesBan.add("rpm");
            ed_ExtensionesBan.add("lnk");

            String ext = ed_nombreArchivo.substring(ed_nombreArchivo.length() - 5);
            String[] ed_extension = new String[2];
            ed_extension = ext.split("\\.");

            return (ed_ExtensionesBan.contains(ed_extension[1])) ? true : false;
        }

        return true;
    }


    /*
     * AF  Archivo de Transacciones
     * US Archivo de Usuarios
     */
    public static boolean archivoRips(String ed_prefijo, String ed_nombreArchivo) {
        // String ed_pre = ed_prefijo;
        // String ed_archivo = ed_nombreArchivo.substring(0, 2).toUpperCase();
        // return ( ed_pre.equals(ed_archivo) ) ? true : false;
//        System.out.println( ed_nombreArchivo.substring(0, 2).toUpperCase() );
//        System.out.println( ed_prefijo.toUpperCase() );

        if (ed_nombreArchivo.length() != 0 || ed_nombreArchivo == null) {
            return (ed_prefijo.toUpperCase().equals(ed_nombreArchivo.substring(0, 2).toUpperCase())) ? true : false;
        }
        return false;
    }

    public String archivoRenombrar(String ed_nombreArchivo, String tipoArchivo) {
        return tipoArchivo + "_" + ed_nombreArchivo;
    }

    public String getPrefijoRips(String archivo) {
        return archivo.substring(0, 2).toUpperCase();
    }
}
