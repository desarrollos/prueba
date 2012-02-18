for /f "tokens=*" %%_ in ('dir /b E:\Desarrollos\Delphos\Delphos\web\js\formularios\*.js') do (
   jsmin < E:/Desarrollos/Delphos/Delphos/web/js/formularios/%%_ > E:/Desarrollos/Delphos/Delphos/web/js/formularios/%%_".min."
   
)

