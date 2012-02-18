<html>
    <head>
        <title>Cargar Archivo</title>
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
    </head>
    <body>
        ${msj}
        <table>
            <tr>
                <td valign="top">
                    <img src="../images/Logo.png">
                </td>
                <td>
                    <form name="formulario" id="formulario" method="post" action="PopUpCargaArchivo.jsp" enctype="multipart/form-data">
                        <input type="hidden" name="hacerSubmit" value="1">
                        <input type="hidden" name="campo" value="${param.campo}">
                        <table>
                            <tr>
                                <td>
                                    <span class="textoPequeno">Seleccione el archivo</span> <input type="file" size="30" name="archivo">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <input type="submit" value="Aceptar">
                                    <input type="button" value="Cancelar" onclick="window.close();">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <p align="justify" class="textoPequeno">
                                        Este proceso puede tardar varios minutos dependiendo del tamaño del archivo y de la velocidad de su conexi&oacute;n a internet.
                                        No cierre la ventana, esta se cerrar&aacute; sola al terminar el proceso de carga del archivo.
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
    </body>
</html>