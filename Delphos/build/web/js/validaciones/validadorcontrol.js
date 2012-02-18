function borrarMensaje(elementoInicial)
{
    document.getElementById(elementoInicial).focus();
    setTimeout("document.getElementById('mensajeControlador').innerHTML=''",5000);
}

function validarLlave(tabla, llaves)
{
   var url = "../ServletValidarPK?tabla="+tabla+"&llaves="+llaves;
   if (typeof XMLHttpRequest != "undefined") 
       req = new XMLHttpRequest();
   else if (window.ActiveXObject) 
       req = new ActiveXObject("Microsoft.XMLHTTP");
   req.open("GET", url, true);
   req.onreadystatechange = callbackValidarPK;
   req.send(null);
}

function callbackValidarPK()
{
    if (req.readyState == 4) 
        if (req.status == 200) 
            obtenerResultado();
}

function obtenerResultado()
{
    var v = document.getElementById('valpk').value;

    if(req.responseText == 'SI')
    {
        if(v == 1)
        {
            alert("Error. El registro ya existe.");
        }
        else if(v == 2 || v == 3)
        {
            if(v==2)
            {
                if(confirm("Está seguro de modificar el registro?"))
                {
                    document.getElementById('hacerSubmit').value = 2;
                    document.formulario.submit();
                }
            }
            if(v==3)
            {
                if(confirm("Está seguro de eliminar el registro?"))
                {
                    document.getElementById('hacerSubmit').value = 3;
                    document.formulario.submit();
                }
            }
        }
    }
    if(req.responseText == 'NO')
    {
        if(v == 1)
        {
            document.getElementById('hacerSubmit').value = 1;
            document.formulario.submit();
        }
        else if(v == 2 || v == 3)
        {
            if(v==2)
            {
                alert("Error. El registro no existe.");
            }
            if(v==3)
            {
                alert("Error. El registro no existe.");
            }
        }
    }
}