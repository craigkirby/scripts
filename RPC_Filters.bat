@echo off
cls
setlocal

:: List of UUIDs
:: https://vulners.com/openvas/OPENVAS:1361412562310108044
:: https://github.com/p33kab00/dcerpc-pipe-scan/blob/master/dcerpc-pipe-scan.py

if "%1"=="disable" call :DISABLERPCFILTERS
if "%1"=="enable" call :ENABLERPCFILTERS
goto :EOF

:DISABLERPCFILTERS
for /f "tokens=2" %%a in ('netsh rpc filter show filter ^| find /i "filterKey"') do netsh rpc filter delete filter %%a
goto :EOF

:ENABLERPCFILTERS
call :DISABLERPCFILTERS
set netsh_scr=netsh.txt

echo rpc>%netsh_scr%
echo filter>>%netsh_scr%

:: Services
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=367abb81-9844-35f1-ad32-98f038001003>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Also Services as listed on Internet but might be a typo
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=367aeb81-9844-35f1-ad32-98f038001003>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Task Scheduler
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=378e52b0-c0a9-11cf-822d-00aa0051e40f>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Task Scheduler
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=0a74ef1c-41a4-4e06-83ae-dc74fb1cdd53>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Task Scheduler
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=86d35949-83c9-4044-b424-db363231fd0c>>%netsh_scr%
echo add filter>>%netsh_scr%

:: AT Scheduler
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=1ff70682-0a51-30e8-076d-740be8cee98b>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Security Configuration Editor Engine
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=93149ca2-973b-11d1-8c39-00c04fb984f9>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Remote Registry
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=338cd001-2244-31f1-aaaa-900038001003>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Encrypting File System Remote (EFSRPC) Protocol
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=c681d488-d850-11d0-8c52-00c04fd90f7e>>%netsh_scr%
echo add filter>>%netsh_scr%

:: Encrypting File System Remote (EFSRPC) Protocol
echo add rule layer=um actiontype=block>>%netsh_scr%
echo add condition field=if_uuid matchtype=equal data=df1941c5-fe89-4e79-bf10-463657acf44d>>%netsh_scr%
echo add filter>>%netsh_scr%

echo quit>>%netsh_scr%

type %netsh_scr% | netsh

del %netsh_scr%

goto :EOF
