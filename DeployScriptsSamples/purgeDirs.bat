rem del /f /s /q E:\Web\MyApp\MyAppService\bin\*
rem del /f /s /q E:\Web\MyApp\MyAppServeur\bin\*


del /q /s E:\Web\MyApp\MyAppService\bin\*
for /d %%x in (E:\Web\MyApp\MyAppService\bin\*) do @rd /s /q "%%x"

del /q /s E:\Web\MyApp\MyAppServeur\bin\*
for /d %%x in (E:\Web\MyApp\MyAppServeur\bin\*) do @rd /s /q "%%x"

