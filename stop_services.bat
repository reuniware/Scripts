rem Stop a maximum number of Windows Services to speed-up the system

sc stop wscsvc

sc stop WSearch

sc stop AdobeARMservice

sc stop AeLookupSvc

rem Stopping Appinfo disable possibility to launch any program as Administrator
rem sc stop Appinfo

sc stop BFE

sc stop BITS

sc stop CryptSvc

sc stop DcomLaunch

sc stop DPS

sc stop eventlog

sc stop EventSystem

sc stop FDResPub

sc stop FontCache

sc stop gpsvc

sc stop IKEEXT

sc stop KeyIso

sc stop MMCSS

sc stop PcaSvc

sc stop PolicyAgent

sc stop ProfSvc

sc stop RasAuto

sc stop RasMan

sc stop RpcEptMapper

sc stop RpcSs

sc stop SamSs

sc stop Schedule

sc stop SENS

sc stop sppsvc

sc stop sppuinotify

sc stop SSDPSRV

sc stop SstpSvc

sc stop StiSvc

sc stop SysMain

sc stop TapiSrv

sc stop Themes

sc stop TrkWks

sc stop UxSms

sc stop WdiServiceHost

sc stop WinDefend

sc stop Winmgmt

sc stop wudfsvc

pause
