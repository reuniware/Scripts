net stop MyAppMyDotNetService
timeout /t 1
cd C:\Windows\Microsoft.NET\Framework\v4.0.30319
InstallUtil.exe -u E:\Products\MyAppMyDotNetService01\MyAppMyDotNetService.exe
timeout /t 1

del /s /q c:\tmp\MyApp-httpmodule.log
del /s /q c:\tmp\MyAppserveur_nhsql_16028.log
del /s /q c:\tmp\trace.log
del /s /q c:\tmp\trace012.log

del /s /q E:\Products\MyAppMyDotNetService01\*
timeout /t 1
xcopy "\\tsclient\C\Users\Username\source\repos\PAVE\MyAppServeur\Services\MyApp.Services.Traitement\bin\Debug\*" "E:\Products\MyAppMyDotNetService01\" /D /Y

cd C:\Windows\Microsoft.NET\Framework\v4.0.30319
InstallUtil.exe E:\Products\MyAppMyDotNetService01\MyAppMyDotNetService.exe
timeout /t 1
net start MyAppMyDotNetService
timeout /t 1

C:\Windows\System32\inetsrv\appcmd stop site "Default Web Site"
timeout /t 1
taskkill /F /IM w3wp.exe
timeout /t 1
C:\Windows\System32\inetsrv\appcmd start site "Default Web Site"

pause
