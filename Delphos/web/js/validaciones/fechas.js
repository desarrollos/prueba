function calcular_edad(nfecha){

                fecha = new Date(nfecha);
                hoy = new Date();
                ed = parseInt((hoy -fecha)/365/24/60/60/1000);
                document.getElementById("edad").value = ed;    
    
}