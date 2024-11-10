@echo off
chcp 65001 >nul
title Curfew V1.0
goto banner

:banner
cls
echo.
echo            dP""b8 88   88 88""Yb 888888 888888 Yb        dP 
echo           dP   `" 88   88 88__dP 88__   88__    Yb  db  dP  
echo           Yb      Y8   8P 88"Yb  88""   88""     YbdPYbdP   
echo            YboodP `YbodP' 88  Yb 88     888888    YP  YP    V1.0  
echo.
goto commands

:commands
echo.
echo           Dev note:
echo    Feel free to modify this version so you dont damage the real copy.
echo    Press "ctrl+c" to terminate the task.                    
echo.
echo             options: 
echo     "$ms" - "(ms = main start)" start Ddos.                   !WARNING, DO NOT USE FOR ILLEGAL PURPOSES!
echo     "$e" - "(e = exit)" exit Curfew tool.
echo     "$p" - "(p = ping)" Pings a server, used to find if server is up.
echo     "$t" - "(t = tracert)" helps you trace the route packets take from your computer to a destination
echo     "$ns" - "(ns = netstat)" powerful tool that provides information about network connections, routing tables, etc.   
echo     "?help" - shows this prompt again.   0
echo.
echo.
echo     example: 
echo     www.example.com/admin
echo.
echo     ! AWARE THAT THERE ARE NOT MANY COMMANDS !                                                       curfew v1   
echo.
goto prompt

:prompt
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A

set /p input="[INPUT]:$   %BS%"

if /I %input% EQU T goto banner
if /I %input% EQU $ms goto continue
if /I %input% EQU $e goto exit
if /I %input% EQU ?help goto help
if /I %input% EQU $t goto t
if /I %input% EQU $p goto p
if /I %input% EQU $ns goto ns

:continue
set /p m= "[IP OR DOMAIN]:$"
echo.
set /p p="[PORT]:$"
echo.
set /p n="[PACKET SIZE]:$"
echo.
goto confirmation

:confirmation
set /p confirmation=[40;32mAre you sure you want to continue [40;34m([40;32mY[40;34m/[40;32mN[40;34m) [40;32m?
goto DDOS

:exit
exit

:DDOS
@REM ping -n 1 %m% -l %n% | FIND "TTL="
@REM IF ERRORLEVEL 1 (SET in=c & echo No connection, server maybe down.)
@REM color %in%
@REM ping -t 2 0 10 127.0.0.1 >nul
ping %m% -l %n% -n 1 >nul
if errorlevel 1 (
    echo [40;31mNo Connection, Server maybe down
) else (
   echo [40;32m[%date%] [%time%] Attacking Server %m% {sent %n%}           [40;34m{--sent %n% #success--}
)
cls
goto banner

:help
cls
goto banner

:t 
set /p input="[DOMAIN/IP FOR TRACERT]:$   %BS%"

tracert %input%
pause >nul
goto banner

:p
echo.
echo Instructions:
echo.
echo           If it cant find the server then server is probally down.
echo           If it can then the server is working fine.
echo.
set /p input="[DOMAIN/IP TO PING]:$   %BS%"

ping %input% -n 1
pause >nul
goto banner

:ns
netstat - an
goto nsm

:nsm
echo      note:
echo    Do ctrl+c to quit 
set /p x="[NETSTAT COMMAND]:$   %BS%"
netstat %x%
pause