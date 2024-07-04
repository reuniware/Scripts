@echo off

set directory=E:\Web\MyAppCopy
echo Suppression du répertoire MyAppCopy et de son contenu...
rmdir /S /Q "%directory%"
echo Répertoire MyAppCopy et son contenu supprimés.

--pause

set source=E:\Web\MyApp
set destination=E:\Web\MyAppCopy
xcopy "%source%" "%destination%" /E /I /Y
echo Copie du répertoire MyApp vers MyAppCopy terminée.

--pause

set source=\\tsclient\C\Users\USERNAME\source\repos\MyApp\MyApp.RestApi\bin\app.publish
set destination=E:\Web\MyApp
@echo off

echo Copie du contenu du répertoire distant vers MyApp...
robocopy "%source%" "%destination%" /E /XF *.config

echo Copie vers MyApp terminée.
--pause

set source=E:\Web\MyAppCopy\wwwroot\app\config
set destination=E:\Web\MyApp\wwwroot\app\config
set filename=_root.js

echo Copie du fichier _root.js de MyAppCopy vers MyApp...
copy "%source%\%filename%" "%destination%"

echo Copie du fichier terminée.
pause
