/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

/**
 *
 * @author PCGASO
 */
public class estadosSQL {

    /**
     * Retorna Mensaje devuelvo por la Exception de Postgresql
     * de una manera mas entendible para el usuario.<br>
     *
     * <Strong>Formato ("+s+"): </Strong> [Clase Error][("+s+"):][Descripcion Mensaje(M)]{opcional[-][Message]}
     *
     * @author Gaso
     * @date 26/09/2011
     * @param s codigo del Error getSQLState()
     * @param Message Descripcion del Error Arojado getMessage()
     * @return m Mensaje en cristiano.
     */
    public static String getM(String s, String Message) {

        String m = Message;

        //Clase 00 - Successful Completion
        if (s.equals("00000")) {
            m = "Realizado con Exito(" + s + "): Operacion Completa";
        } //Clase 01 - Warning
        else if (s.equals("01000")) {
            m = "Advertencia(" + s + "): " + Message;
        } else if (s.equals("0100C")) {
            m = "Advertencia(" + s + "): Se han retornando resultados Dinamicos - " + Message;
        } else if (s.equals("01008")) {
            m = "Advertencia(" + s + "): Bit Cero Implicito - " + Message;
        } else if (s.equals("01003")) {
            m = "Advertencia(" + s + "): Valor nulo eliminado en funcion - " + Message;
        } else if (s.equals("01007")) {
            m = "Advertencia(" + s + "): Privilegio no concedido - " + Message;
        } else if (s.equals("01006")) {
            m = "Advertencia(" + s + "): Privilegio no revocado - " + Message;
        } else if (s.equals("01004")) {
            m = "Advertencia(" + s + "): El Dato introducido es más largo de la longitud maxima del campo - " + Message;
        } else if (s.equals("01P01")) {
            m = "Advertencia(" + s + "): Caracteristica Obsoleta - " + Message;
        } // Clase 02 -  No Data (this is also a warning class per the SQL standard)
        else if (s.equals("02000")) {
            m = "No hay datos(" + s + "): " + Message;
        } else if (s.equals("02001")) {
            m = "No hay datos(" + s + "): Resultados Dinamicos Adicionales no fueron asignados - " + Message + Message;
        } // Clase 03 -  SQL Statement Not Yet Complete
        else if (s.equals("03000")) {
            m = "Sentencia SQL no esta completa(" + s + "): " + Message;
        } // Clase 08 -  Connection Exception
        else if (s.equals("08000")) {
            m = "Excepción de Conectividad General (" + s + "): " + Message;
        } else if (s.equals("08003")) {
            m = "Excepción de Conectividad (" + s + "): Conexion no Existe - " + Message;
        } else if (s.equals("08006")) {
            m = "Excepción de Conectividad (" + s + "): Conexion Fallida - " + Message;
        } else if (s.equals("08001")) {
            m = "Excepción de Conectividad (" + s + "): SQLCliente no puede establecer conexion con SQLConnection - " + Message;
        } else if (s.equals("08004")) {
            m = "Excepción de Conectividad (" + s + "): SQLServer rechazó establecimiento de Conexion de SQLConnection - " + Message;
        } else if (s.equals("08007")) {
            m = "Excepción de Conectividad (" + s + "): Resolucion de Transaccion Desconocido - " + Message;
        } else if (s.equals("08P01")) {
            m = "Excepción de Conectividad (" + s + "): Violacion del Protocolo - " + Message;
        } // Clase 09 Triggered Action Exception
        else if (s.equals("09000")) {
            m = "Accion provoco Excepción (" + s + "): " + Message;
        } // Clase 0A Feature Not Supported
        else if (s.equals("0A000")) {
            m = "Caracteristica No Soportada (" + s + "): " + Message;
        } // Clase 0B Invalid Transaction Initiation
        else if (s.equals("0B000")) {
            m = "Iniciacion de Transaccion Invalida (" + s + "): " + Message;
        } // Clase 0F Locator Exception
        else if (s.equals("0F000")) {
            m = "Excepción de Localizador General (" + s + "): " + Message;
        } else if (s.equals("0F001")) {
            m = "Excepción de Localizador Especifico (" + s + "): " + Message;
        } // Clase 0L Invalid Grantor
        else if (s.equals("0L000")) {
            m = "Cedente Invalido (" + s + "): " + Message;
        } else if (s.equals("0LP01")) {
            m = "Operacion Cedente Invalida (" + s + "): " + Message;
        } // Clase 0P Invalid Role Specification
        else if (s.equals("0P000")) {
            m = "Especificacion de Rol invalido: (" + s + "): " + Message;
        } // Clase 20 Case Not Found
        else if (s.equals("20000")) {
            m = "Case no encontrado: (" + s + "): " + Message;
        } // Clase 21  Cardinality Violation
        else if (s.equals("21000")) {
            m = "Violacion de cardinalidad: (" + s + "): " + Message;
        } // Clase 22  Data Exception
        else if (s.equals("22000")) {
            m = "Exception General de Datos : (" + s + "): " + Message;
        } else if (s.equals("2202E")) {
            m = "Exception de Datos (" + s + "): Subindice Array Error - " + Message;
        } else if (s.equals("22021")) {
            m = "Exception de Datos (" + s + "): Caracter no incluido en el repertorio - " + Message;
        } else if (s.equals("22008")) {
            m = "Exception de Datos (" + s + "): Desbordamiento del campo DateTime - " + Message;
        } else if (s.equals("22012")) {
            m = "Exception de Datos (" + s + "): Divison por cero - " + Message;
        } else if (s.equals("22005")) {
            m = "Exception de Datos (" + s + "): Error en asignacion - " + Message;
        } else if (s.equals("2200B")) {
            m = "Exception de Datos (" + s + "): Conflicto con caracter de escape - " + Message;
        } else if (s.equals("22022")) {
            m = "Exception de Datos (" + s + "): Indicador desbordado - " + Message;
        } else if (s.equals("22015")) {
            m = "Exception de Datos (" + s + "): Intervalo de campo desborado - " + Message;
        } else if (s.equals("2201E")) {
            m = "Exception de Datos (" + s + "): Argumento invalido para algoritmo - " + Message;
        } else if (s.equals("22014")) {
            m = "Exception de Datos (" + s + "): Argumento invalido para funcion NTILDE - " + Message;
        } else if (s.equals("22016")) {
            m = "Exception de Datos (" + s + "): Argumento invalido para funcion NTH_VALUE - " + Message;
        } else if (s.equals("2201F")) {
            m = "Exception de Datos (" + s + "): Argumento invalido para funcion POWER - " + Message;
        } else if (s.equals("2201G")) {
            m = "Exception de Datos (" + s + "): Argumento invalido para el ancho de la funcion BUCKET - " + Message;
        } else if (s.equals("22018")) {
            m = "Exception de Datos (" + s + "): Valor de Caracter Invalido para CAST - " + Message;
        } else if (s.equals("22007")) {
            m = "Exception de Datos (" + s + "): Formato Invalido para DATETIME - " + Message;
        } else if (s.equals("22019")) {
            m = "Exception de Datos (" + s + "): Caracter de escape invalido - " + Message;
        } else if (s.equals("2200D")) {
            m = "Exception de Datos (" + s + "): Octeto de escape invalido - " + Message;
        } else if (s.equals("22025")) {
            m = "Exception de Datos (" + s + "): Sequencia de escape invalido - " + Message;
        } else if (s.equals("22P06")) {
            m = "Exception de Datos (" + s + "): No uso de estandar de Caracter Escape - " + Message;
        } else if (s.equals("22010")) {
            m = "Exception de Datos (" + s + "): Valor invalido para el parametro indicado- " + Message;
        } else if (s.equals("22023")) {
            m = "Exception de Datos (" + s + "): Valor del parametro invalido - " + Message;
        } else if (s.equals("2201B")) {
            m = "Exception de Datos (" + s + "): Expresion Regular invalida - " + Message;
        } else if (s.equals("2201W")) {
            m = "Exception de Datos (" + s + "): Inválido el número de filas en el punto límite - " + Message;
        } else if (s.equals("2201X")) {
            m = "Exception de Datos (" + s + "): cantidad invalida de filas en la clausula de resultado offset  - " + Message;
        } else if (s.equals("22009")) {
            m = "Exception de Datos (" + s + "): Valor invalido para desplazamiento ZONA HORARIA- " + Message;
        } else if (s.equals("2200C")) {
            m = "Exception de Datos (" + s + "): Uso invalido caracter de escape - " + Message;
        } else if (s.equals("2200G")) {
            m = "Exception de Datos (" + s + "): La mayoria de tipos especificos no coinciden - " + Message;
        } else if (s.equals("22004")) {
            m = "Exception de Datos (" + s + "): No es permitido un valor vacio - " + Message;
        } else if (s.equals("22002")) {
            m = "Exception de Datos (" + s + "): El valor Nulo no tiene un parametro indicado - " + Message;
        } else if (s.equals("22003")) {
            m = "Exception de Datos (" + s + "): Valor numerico fuera del Rango - " + Message;
        } else if (s.equals("22026")) {
            m = "Exception de Datos (" + s + "): La Longitud del valor de la cadena no coincide - " + Message;
        } else if (s.equals("22001")) {
            m = "Exception de Datos (" + s + "): Dato de cadena truncado a la derecha - " + Message;
        } else if (s.equals("22011")) {
            m = "Exception de Datos (" + s + "): Error en subcadena- " + Message;
        } else if (s.equals("22027")) {
            m = "Exception de Datos (" + s + "): Error quitando espacios en blanco - " + Message;
        } else if (s.equals("22024")) {
            m = "Exception de Datos (" + s + "): Cadena C sin terminacion - " + Message;
        } else if (s.equals("2200F")) {
            m = "Exception de Datos (" + s + "): Longitud cadena de caracteres Cero - " + Message;
        } else if (s.equals("22P01")) {
            m = "Exception de Datos (" + s + "): Excepcion Punto Flotante - " + Message;
        } else if (s.equals("22P02")) {
            m = "Exception de Datos (" + s + "): Representacion invalida de Texto - " + Message;
        } else if (s.equals("22P03")) {
            m = "Exception de Datos (" + s + "): Representacion invalida de Binario - " + Message;
        } else if (s.equals("22P04")) {
            m = "Exception de Datos (" + s + "): Mala copia formato Archivo - " + Message;
        } else if (s.equals("22P05")) {
            m = "Exception de Datos (" + s + "): Caracter intraducible - " + Message;
        } else if (s.equals("2200L")) {
            m = "Exception de Datos (" + s + "): No es un documento XML - " + Message;
        } else if (s.equals("2200M")) {
            m = "Exception de Datos (" + s + "): Documento XML Invalido- " + Message;
        } else if (s.equals("2200N")) {
            m = "Exception de Datos (" + s + "): Contenido XML Invalido- " + Message;
        } else if (s.equals("2200S")) {
            m = "Exception de Datos (" + s + "): Comentario XML Invalido- " + Message;
        } else if (s.equals("2200T")) {
            m = "Exception de Datos (" + s + "): Instruccion de Procesamiento XML Invalida- " + Message;
        } //Clase 23 - Integrity Constraint Violation
        else if (s.equals("23000")) {
            m = "Violación de Integridad (" + s + "): " + Message;
        } else if (s.equals("23001")) {
            m = "Violación de Integridad (" + s + "): Violacion de Restriccion - " + Message;
        } else if (s.equals("23502")) {
            m = "Violación de Integridad (" + s + "): Hay campos que no pueden estar vacios - " + Message;
        } else if (s.equals("23503")) {
            m = "Violación de Integridad (" + s + "): La Relacion entre los campos no coincide - Tabla " + Message ;//+ Message.substring(Message.lastIndexOf("<<"), Message.lastIndexOf(">>")) + " " + Message;
        } else if (s.equals("23505")) {
            m = "(" + s + "): El Registro que esta intentado introduccir ya Existe. Verifique el Campo Primario - " + Message;
        } else if (s.equals("23514")) {
            m = "Violación de Integridad (" + s + "): Violacion de Chequeo - " + Message;
        } else if (s.equals("23P01")) {
            m = "Violación de Integridad (" + s + "): Violacion de Exclusion - " + Message;
        } //Clase 24 -  Invalid Cursor State
        else if (s.equals("24000")) {
            m = "Estado no válido del cursor " + Message;
        } //Clase 25 -  Invalid Transaction State
        else if (s.equals("25000")) {
            m = "Estado de la Transaccion no Valido " + Message;
        } else if (s.equals("25001")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Transaccion SQL Activa - " + Message;
        } else if (s.equals("25002")) {
            m = "Estado de la Transaccion no Valido (" + s + "): La Rama de la transaccion ya esta activa - " + Message;
        } else if (s.equals("25008")) {
            m = "Estado de la Transaccion no Valido (" + s + "): El lugar del cursor requiere mismo nivel de aislamiento - " + Message;
        } else if (s.equals("25003")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Modo de acceso inapropiado para Rama de transacción - " + Message;
        } else if (s.equals("25004")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Inadecuado nivel de aislamiento para rama de transacción - " + Message;
        } else if (s.equals("25005")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Transaccion SQL no activa para la rama de transaccion - " + Message;
        } else if (s.equals("25006")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Transaccion SQL de Solo Lectura - " + Message;
        } else if (s.equals("25007")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Esquema y Dato de Declaracion Mixto no es compatible - " + Message;
        } else if (s.equals("25P01")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Transaccion SQL no esta activa - " + Message;
        } else if (s.equals("25P02")) {
            m = "Estado de la Transaccion no Valido (" + s + "): Error en transaccion SQL - " + Message;
        } //Clase 26 Invalid SQL Statement Name
        else if (s.equals("26000")) {
            m = "Nombre de Declaracion SQL no valida (" + s + ") - " + Message;
        } //Clase 27 Triggered Data Change Violation
        else if (s.equals("27000")) {
            m = "Violacion cambio Datos TRIGGERED (" + s + ") - " + Message;
        } //Clase 28 Invalid Authorization Specification
        else if (s.equals("28000")) {
            m = "Especificacion de Autorizacion no valido (" + s + ") - " + Message;
        } else if (s.equals("28P01")) {
            m = "Contrase?a Invalida (" + s + ") - " + Message;
        } //Clase 2B Dependent Privilege Descriptors Still Exist
        else if (s.equals("2B000")) {
            m = "Los descriptores dependientes de privilegios aún existen (" + s + ") - " + Message;
        } else if (s.equals("2BP01")) {
            m = "Todavía existen objetos dependientes (" + s + ") - " + Message;
        } //Clase 2D Invalid Transaction Termination
        else if (s.equals("2D000")) {
            m = "Terminación de transacción inválida (" + s + ") - " + Message;
        } //Clase 2F SQL Routine Exception
        else if (s.equals("2F000")) {
            m = "Excepcion en Rutina SQL (" + s + ") - " + Message;
        } else if (s.equals("2F005")) {
            m = "Excepcion en Rutina SQL(" + s + "): La Funcion ejecutada no retorno declaracion - " + Message;
        } else if (s.equals("2F002")) {
            m = "Excepcion en Rutina SQL(" + s + "): Modificacion de Datos SQL no es permitido - " + Message;
        } else if (s.equals("2F003")) {
            m = "Excepcion en Rutina SQL(" + s + "): Prohiba instruccion SQL interna - " + Message;
        } else if (s.equals("2F004")) {
            m = "Excepcion en Rutina SQL(" + s + "): Lectura de Datos SQL no permitida - " + Message;
        } //Clase 34  Invalid Cursor Name
        else if (s.equals("2F004")) {
            m = "Nombre del cursos invalido (" + s + "): " + Message;
        } //Clase 38 - External Routine Exception
        else if (s.equals("2F004")) {
            m = "Excepcion de Rutinas Externas (" + s + "): " + Message;
        } else if (s.equals("38001")) {
            m = "Contenido del SQL no permitido (" + s + "): " + Message;
        } else if (s.equals("38002")) {
            m = "Modificar datos SQL no permitido (" + s + "): " + Message;
        } else if (s.equals("38003")) {
            m = "Prohibida instrucción sql intento (" + s + "): " + Message;
        } else if (s.equals("38004")) {
            m = "Lectura de datos de SQL no permitida (" + s + "): " + Message;
        } //Clase 39 External Routine Invocation Exception
        else if (s.equals("39000")) {
            m = "Excepción en Invocación rutinas externas (" + s + "): " + Message;
        } else if (s.equals("39001")) {
            m = "Excepción en Invocación rutinas externas (" + s + "): Estado SQL retornado no valido - " + Message;
        } else if (s.equals("39004")) {
            m = "Excepción en Invocación rutinas externas (" + s + "): Valor nulo no permitido - " + Message;
        } else if (s.equals("39P01")) {
            m = "Excepción en Invocación rutinas externas (" + s + "): Violacion en protocolo TRIGGER - " + Message;
        } else if (s.equals("39P02")) {
            m = "Excepción en Invocación rutinas externas (" + s + "): Violacion en protocolo SRF - " + Message;
        } //Clase 3B  Savepoint Exception
        else if (s.equals("3B000")) {
            m = "Excepción en Punto de Retorno (" + s + "): " + Message;
        } else if (s.equals("3B001")) {
            m = "Excepción en Punto de Retorno (" + s + "): Especificacion en punto de acceso invalida - " + Message;
        } //Clase 3D  Invalid Catalog Name
        else if (s.equals("3D000")) {
            m = "Nombre Catalogo no valido (" + s + "): " + Message;
        } //Clase 3F  Invalid Catalog Name
        else if (s.equals("3F000")) {
            m = "Nombre Esquema no valido (" + s + "): " + Message;
        } //Clase 40  Transaction Rollback
        else if (s.equals("40000")) {
            m = "Transaccion Rollback (" + s + "): " + Message;
        } else if (s.equals("40002")) {
            m = "Transaccion Rollback (" + s + "): Relacion entre las tablas(campos) no es correcta - " + Message;
        } else if (s.equals("40001")) {
            m = "Transaccion Rollback (" + s + "): Serializacion Fallida - " + Message;
        } else if (s.equals("40003")) {
            m = "Transaccion Rollback (" + s + "): Finalización de instrucciones desconocido - " + Message;
        } else if (s.equals("40P01")) {
            m = "Transaccion Rollback (" + s + "): Punto Muerto detectado - " + Message;
        } //clase 42 - Syntax Error or Access Rule Violation
        else if (s.equals("42000")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): " + Message;
        } else if (s.equals("42601")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Error en Sintaxis - " + Message;
        } else if (s.equals("42501")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Privilegios insuficientes - " + Message;
        } else if (s.equals("42846")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): No se puede Forzar - " + Message;
        } else if (s.equals("42803")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Error de Agrupacion - " + Message;
        } else if (s.equals("42P20")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Error de Ventanas - " + Message;
        } else if (s.equals("42P19")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Recursividad no es valida - " + Message;
        } else if (s.equals("42830")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Llave foranea no es valida - " + Message;
        } else if (s.equals("42602")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Nombre no es valido - " + Message;
        } else if (s.equals("42622")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Nombre demaciado largo - " + Message;
        } else if (s.equals("42939")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Nombre reservado - " + Message;
        } else if (s.equals("42804")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Tipo de Fecha no coincide - " + Message;
        } else if (s.equals("42P18")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Tipo de Fecha indeterminada - " + Message;
        } else if (s.equals("42809")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Objeto de tipo incorrecto - " + Message;
        } else if (s.equals("42703")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Columna no ha sido definida- " + Message;
        } else if (s.equals("42883")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Funcion no ha sido definida- " + Message;
        } else if (s.equals("42P01")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Tabla no ha sido definida- " + Message;
        } else if (s.equals("42P02")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Parametro no ha sido definida- " + Message;
        } else if (s.equals("42704")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Objeto no ha sido definida- " + Message;
        } else if (s.equals("42701")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Columna ya existe - " + Message;
        } else if (s.equals("42P03")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Cursor ya existe - " + Message;
        } else if (s.equals("42P04")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Tabla ya existe - " + Message;
        } else if (s.equals("42723")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Funcion ya existe - " + Message;
        } else if (s.equals("42P05")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Preparacion de Declaracion ya existe - " + Message;
        } else if (s.equals("42P06")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Esquema ya existe - " + Message;
        } else if (s.equals("42P07")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Tabla ya existe - " + Message;
        } else if (s.equals("42712")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Alias ya existe - " + Message;
        } else if (s.equals("42710")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Objeto ya existe - " + Message;
        } else if (s.equals("42702")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Columna Ambigua - " + Message;
        } else if (s.equals("42725")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Funcion Ambigua - " + Message;
        } else if (s.equals("42P08")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Parametro Ambiguo - " + Message;
        } else if (s.equals("42P09")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Alias Ambiguo - " + Message;
        } else if (s.equals("42P10")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Referencia de columna no válida - " + Message;
        } else if (s.equals("42611")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de columna no válida - " + Message;
        } else if (s.equals("42P11")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de Cursor no válida - " + Message;
        } else if (s.equals("42P12")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de Base de Datos no válida - " + Message;
        } else if (s.equals("42P13")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de Funcion no válida - " + Message;
        } else if (s.equals("42P14")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de Preparacion de Declaracion no válida - " + Message;
        } else if (s.equals("42P15")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de Esquema no válida - " + Message;
        } else if (s.equals("42P16")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de Tabla no válida - " + Message;
        } else if (s.equals("42P17")) {
            m = "Error de Sintaxis o Violacion de Reglas de Acceso (" + s + "): Definicion de Objeto no válida - " + Message;
        } //Clase 44 - WITH CHECK OPTION Violation
        else if (s.equals("44000")) {
            m = "Violacion con checkeo de Opcion (" + s + "): " + Message;
        } //Clase 53 - Insufficient Resources
        else if (s.equals("53000")) {
            m = "Recursos insuficientes (" + s + "): " + Message;
        } else if (s.equals("53100")) {
            m = "Recursos insuficientes (" + s + "): No hay espacio en Disco Duro - " + Message;
        } else if (s.equals("53200")) {
            m = "Recursos insuficientes (" + s + "): Memoria RAM Agotada - " + Message;
        } else if (s.equals("53300")) {
            m = "Recursos insuficientes (" + s + "): Demasiadas Conexiones con Base de datos  - " + Message;
        } //Clase 54 - Program Limit Exceeded
        else if (s.equals("54000")) {
            m = "Excedido los limites del Programa (" + s + "): " + Message;
        } else if (s.equals("54001")) {
            m = "Excedido los limites del Programa (" + s + "): Instruccion demasiado compleja - " + Message;
        } else if (s.equals("54011")) {
            m = "Excedido los limites del Programa (" + s + "): Demasiadas columnas - " + Message;
        } else if (s.equals("54023")) {
            m = "Excedido los limites del Programa (" + s + "): Demasiadas Argumentos - " + Message;
        } //Clase 55 - Object Not In Prerequisite State
        else if (s.equals("55000")) {
            m = "Objeto no esta en Pre requisitos de Estado (" + s + "): " + Message;
        } else if (s.equals("55006")) {
            m = "Objeto en Uso (" + s + "): " + Message;
        } else if (s.equals("55P02")) {
            m = "No se puede cambiar el parametro en ejecucion (" + s + "): " + Message;
        } else if (s.equals("55P03")) {
            m = "Bloqueo no disponible (" + s + "): " + Message;
        } //Clase 57 - Operator Intervention
        else if (s.equals("57000")) {
            m = "Intervencion del Operador (" + s + "): " + Message;
        } else if (s.equals("57014")) {
            m = "Intervencion del Operador (" + s + "): Query Cancelada - " + Message;
        } else if (s.equals("57P01")) {
            m = "Intervencion del Operador (" + s + "): Administrador Apago Servicio - " + Message;
        } else if (s.equals("57P02")) {
            m = "Intervencion del Operador (" + s + "): Fallo Apago Servicio - " + Message;
        } else if (s.equals("57P03")) {
            m = "Intervencion del Operador (" + s + "): No se puede conectar ahora al Servicio - " + Message;
        } else if (s.equals("57P03")) {
            m = "Intervencion del Operador (" + s + "): Base de Datos Eliminada! - " + Message;
        }

        //Clase 58 System Error (errors external to PostgreSQL itself)
        else if (s.equals("58030")) {
            m = "Fallo Externo a PostgreSQL es si mismo (" + s + "): Error de Entrada y Salida - " + Message;
        } else if (s.equals("58P01")) {
            m = "Fallo Externo a PostgreSQL es si mismo (" + s + "): Archivo indefinido - " + Message;
        } else if (s.equals("58P02")) {
            m = "Fallo Externo a PostgreSQL es si mismo (" + s + "): Archivo duplicado - " + Message;
        }

        //Clase F0 Configuration File Error
        else if (s.equals("F0000")) {
            m = "Error archivo configuracion (" + s + "): " + Message;
        }else if (s.equals("F0001")) {
            m = "Error archivo configuracion (" + s + "): Archivo de Cerrojo Existe -  " + Message;
        }

        //Clase P0  PL/pgSQL Error
        else if (s.equals("P0000")) {
            m = "Error PL/pgSQL (" + s + "): " + Message;
        }else if (s.equals("P0001")) {
            m = "RAISE EXCEPTION (" + s + "): " + Message;
        }else if (s.equals("P0002")) {
            m = "No se encontraron datos (" + s + "): " + Message;
        }else if (s.equals("P0003")) {
            m = "Demaciadas Filas (" + s + "): " + Message;
        }

        // Clase XX - Internal Error
        else if (s.equals("XX000")) {
            m = "Error Interno (" + s + "): " + Message;
        }else if (s.equals("XX001")) {
            m = "Error Interno (" + s + "): Dato Corrupto" + Message;
        }else if (s.equals("XX002")) {
            m = "Error Interno (" + s + "): Index Corrupto" + Message;
        }
        return m;
    }
}
