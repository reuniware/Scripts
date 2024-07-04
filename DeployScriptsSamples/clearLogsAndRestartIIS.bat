net stop MyWindowsService
timeout /t 1

del /s /q c:\tmp\MyApp-httpmodule.log
del /s /q c:\tmp\MyAppserveur_nhsql_12345.log
del /s /q c:\tmp\trace.log
del /s /q c:\tmp\traceMyApp2.log

timeout /t 1

net start MyWindowsService
timeout /t 1

C:\Windows\System32\inetsrv\appcmd stop site "Default Web Site"
timeout /t 1
taskkill /F /IM w3wp.exe
timeout /t 1
C:\Windows\System32\inetsrv\appcmd start site "Default Web Site"

pause
