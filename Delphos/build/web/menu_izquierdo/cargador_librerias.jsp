<%--
    Document   : cargador_librerias
    Created on : 09/06/2010, 11:29:03 PM
    Author     : Gustavo, Sebastian

    Permite cargar las librerias javascript que el menu usara.
--%>
<style type="text/css">
    .jstree li {
        margin-left:10px;
    }
    .jstree li a{
        font-size:10px;
        text-trasform:capitalize !important;

    }
</style>
<link rel="stylesheet" href="../menu_izquierdo/menu2/demo/screen.css" type="text/css" />
<link rel="stylesheet" href="../menu_izquierdo/menu2/jquery.treeview.css" type="text/css" />
<script type="text/javascript" src="../menu_izquierdo/menu2/jquery.treeview.js"></script>
<script type="text/javascript" src="../menu_izquierdo/menu2/lib/jquery.cookie.js"></script>
<style type="text/css">
    .treeview ul{
        background: none;
}
.treeview a.selected{
    background: #c1d842;
}


</style>

<script type="text/javascript">
    var traer = function( url  ) {
        $.post('../ComunFS/' + url, {
        }, function( data ) {
            //alert( data );
            $("#contenidoAjax").html( data );
        })
    }
    $( document ).ready( function() {


        $("#salud, #familias").treeview({
             animated: "fast",
             persist: "location",
             collapsed: true
        });

    });


</script>


