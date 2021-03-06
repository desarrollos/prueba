flexiUsuarios = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=usuariosistema-principal=ususisusuario-seleccion=ususisnombre-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    
    usepager : true,
    rp : 30,
    sortname: 'ususisnombre',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Usuario Sistema',
        bclass : 'anadir'
    }
        
        
    ]
}
function tablaSinDialog( flexiParametros, objeto ) {
    datos = urlDecodificar( flexiParametros.url, "-" );
    $.post('../edinstancias', {
        'parametros' : 'opcion=campos-tabla='+ datos['tabla'] + '-columnas=' + objeto.columnas
    }, function( data ) {
        mapaDatos = mapa(data);
        var columnas = $.parseJSON( mapaDatos['info'] );
        var  searchitems = $.parseJSON( mapaDatos['info'] );
    
        //flexiParametros
    
        $('#' + objeto.capa).flexigrid($.extend({}, flexiParametros, { 
            colModel        : columnas, 
            width : objeto.ancho,
            singleSelect : ( datos['tipo'] == 'modificar' ? true : false ),
            searchitems : searchitems,
            onSubmit        : function(){ 
                $('#tabla').flexOptions({
                    params: [ 

                    {
                        name:'colls', 
                        value: $.param({
                            colls: $.map(columnas, 
                                function(elem,id){
                                    return elem.name
                                })
                        })
                    } 
                    ]
                }); 
                return true; 
            } 
        })); 
    
    });
    return false;
    
}

Permisos = {
   
    
    usuario : '',
    pagina : '',
    perfil : '',
    paginaActual : '',
    paginaGuardarActualizar : '',
    pro : {
        usuariosCapa : 'usuarios_permisos',
        paginasCapa : 'paginas_permisos',
        perfiles  : 'perfiles_permisos'
    },
    usuarios : function() {
        $.post('../edinstancias', {
            'parametros' : 'opcion=usuarios'
        }, function( data ) {
            $( "#" + Permisos.pro['usuariosCapa'] ).html( data );
            
            $("li[id*='ususiscodigo_']").live( {
                click : function() {
                    Permisos.perfilesCerrar();
                    Permisos.usuario = this.id;
                    Permisos.usuario = Permisos.usuario.substr( 13 ); 
                    Permisos.paginas( Permisos.usuario );
                    $("li[id*='ususiscodigo_']").removeClass('usuarios ui-selected')
                    $('#' + this.id).addClass('usuarios ui-selected');
                    Permisos.paginaActual = '';
                }
                
            } );

            aplicarTemaBotones();
        })
    },
    paginas : function( usuario ) {
        $.post('../edinstancias', {
            'parametros' : 'opcion=paginas-usuario=' + usuario
        } , function(  data) {
            
            $( "#" + Permisos.pro['paginasCapa'] ).html( data );
            $("li[id*='lisopccodigo_']").live( {
                click : function( ){
                    if( Permisos.paginaActual == this.id ) return false;
                    Permisos.paginaActual = this.id;
                    
                    /*
                    if( Permisos.pagina != '') {
                        console.log("li[id='lisopccodigo_"+ Permisos.pagina +"']");
                        $("li[id='lisopccodigo_"+ Permisos.pagina +"']").removeClass('paginas ui-selected')
                    }
                    */
                    
                    Permisos.pagina = this.id;
                    Permisos.pagina = Permisos.pagina.substr( 13 ); 
                    Permisos.paginaGuardarActualizar = Permisos.pagina;
                
                    $('#' + this.id).addClass('paginas ui-selected');
                
                
                    Permisos.perfiles();
                },
                dblclick : function() {
                    $('#' + this.id).removeClass('ui-selected');
                    
                    Permisos.paginaActual = '';
                }
                
            } );
            aplicarTemaBotones();
        })
    },
    perfiles : function(  ) {
        $.post('../edinstancias', {
            'parametros' : 'opcion=perfiles-usuario=' + Permisos.usuario + '-pagina=' +  Permisos.pagina
             
        },function( data ) {
            $( "#" + Permisos.pro['perfiles'] ).html( data );
           
            $("li[id*='nivelsegopcion_']").click( function() {
                 
                
                $("li[id*='nivelsegopcion_']").removeClass('perfiles ui-selected')
                $('#' + this.id).attr('class', 'ui-widget-content ui-selectee ui-selected');
                Permisos.perfil = this.id;
                Permisos.perfil = Permisos.perfil.substr( 15 ); 
                 
                Permisos.guardar();
                   
                
                    
                    
                
                
            } );
           
            aplicarTemaBotones();
           
           
           
        });
    },
    eliminar : function() {
        alert( Permisos.usuario + "  " + Permisos.pagina + "  " + Permisos.perfil );
    },
    guardar : function(  ) {
        $.post('../edinstancias', {
            'parametros' : 'opcion=guardarPermiso-usuario=' + Permisos.usuario + '-pagina=' +  Permisos.paginaGuardarActualizar + '-perfil=' + Permisos.perfil 
        }, function( data ) {
            //alert( Permisos.usuario + "  " + Permisos.pagina + "  " + Permisos.perfil );
            $( '#lisopccodigo_'  + Permisos.pagina ).attr('class', 'ui-widget-content ui-selectee ui-selected');
            Permisos.pagina = '';
        }) 
        
    },
    perfilesCerrar : function() {
        $( "#" + Permisos.pro['perfiles'] ).html('');
    },
    config : function( objeto ) {
        if( objeto ) {
            config =  $.extend( Permisos.pro, objeto);
        }
        return config;
    }
}

$(document).ready( function(  ){

    
    Permisos.usuarios();
    
    //alert( $("#tabs").tabs("option", 'selected') );
    
    // Configuro la fecha de registro...
    var f = new Date();
    $("#ususisfechacrea_usuarios").val(  f.getFullYear() +"-" + ( f.getMonth()  <= 9 ? "0"  + f.getMonth() : f.getMonth() ) + "-" + 
        ( f.getDate() <= 9 ? "0" + f.getDate() : f.getDate() ) );
    // Foco 
    
    
    $("#ajax").ajaxStop( function() {
        datos = $("#respuestaAjax").val();
        mapaDatos = mapa(datos);
        
        op = mapaDatos['opcion'];
        es = mapaDatos['estado'];
        er = mapaDatos['error'];
        ed = mapaDatos['errorDes'];
        io = mapaDatos['info'];

        if( op == 'registrar_permisos' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El permiso se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El permiso no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_permisos' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El permiso no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_permisos' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El permiso se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El permiso no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        //
        if( op == 'registrar_estados' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El estado se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El estado no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_estados' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El estado no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_estados' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El estado se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El estado no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        //
        if( op == 'registrar_perfiles' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El perfil se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El perfil no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_perfiles' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El perfil no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_perfiles' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El perfil se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El perfil no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }        
        //
        if( op == 'registrar_paginas' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La pagina se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La pagina no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_paginas' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('La pagina no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_paginas' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('La pagina se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('La pagina no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        //
        if( op == 'registrar_grupos' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El grupo se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El grupo no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        if( op == 'obtener_grupos' ) {
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El grupo no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                
            }
        }
        if( op == 'actualizar_grupos' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El grupo se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El grupo no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        if( op == 'registrar_usuarios' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El usuario se registro correctamente','Estado registro', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El usuario no se registro correctamente: <br /><br /><span class="error"> ' + ed + "</span>", 'Algunos elementos del formulario se encuentran vacios', 'e', 'n');
        }
        
        if( op == 'obtener_usuarios' ) {
            
            if( es == 'no' && er == 'si' ){
                bottomMensaje('El usuario no se puede mostrar: <br /><br /><span class="error"> ' + ed + "</span>", 'Error el obtener el registro de la base de datos', 'e');
            }else {
                
                leerDatos( io );
                $("#tablaContenedor").dialog("close");
                configurarBotones('Actualizar');
                $("#codigo").val( mapaDatos['codigo'] );
                $("#codregimentabla").val( mapaDatos['codregimentabla'] );
            }
        }
        if( op == 'actualizar_usuarios' ) {
            if( es == 'si' && er == 'no' ) bottomMensaje('El usuario se actualizo correctamente','Estado actualizacion', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El usuario no registro correctamente: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error al actualizar el registro', 'e', 'n');
        }
        
        if( op == 'eliminar_usuarios' ) {
            
            if( es == 'si' && er == 'no' ) bottomMensaje('El usuario se borro correctamente', 'Estado borrado', 'ex', 's');
            if( es == 'no' && er == 'si' ) bottomMensaje('El usuario no se borro: <br /><br /><span class="error"> ' 
                + ed + "</span>", 'Error borrando el registro(s)', 'e', 'n');
            
            $("#tabla").flexReload();
        }
        if( op == 'validacion' ) {
            bottomMensaje('Validacion de campos: <br /><br /><span class="error"> ' + ed + "</span>", 'Validacion de campos', 'e', 'n');
            
        }
        
        borrarRespuesta();       
    } );
} )