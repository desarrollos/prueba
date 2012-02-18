<style type="text/css">
    #empresa{
    background-image: url('../images/fondo_panel_derecho.png');
    background-repeat:repeat-y;
}
    #empresa:hover{
    background-image: url('../images/fondo_panel_derecho_2.png');
    }
</style>

<script type="text/javascript" src="../../jquery/jquery.js"></script>
<script type="text/javascript">
            $(document).ready( function() {
                      $("#empresa").hover( function() {
                          
                        // Primera accion
                        $(this).css("width", 156);
                        // Muestro el contenido, apenas se da clic
                        $("#empresa_contenedor").css("display", "block");
                      }, function() {
                        // Segunda
                        $(this).css("width", 50);
                        $("#empresa_contenedor").css("display", "none");
                      } );
            } );

</script>

<td align="right" id="empresa" valign="top" height="500" width="50" >
    <!-- Por defecto no se muestra, solo si se pasa el clic por encima ... -->
    <div id="empresa_contenedor" style="display:none">
    <jsp:include page="../menu_derecho/menu.jsp" />
    </div>
</td>