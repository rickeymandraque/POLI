@ECHO off
cls
color 9f
Echo Ce script doit etre lancer en tant qu'administrateur
ECHO sur un ORDINATEUR avec un systeme Windows de 95 (4.0) à Windows10 (10.0.10)
ECHO Pour les versions de Windows Vista Veuillez procéder aux mise à jour.
ECHO si ce n'est pas le cas faites CTRL+C et relancez le script.
set currentver=2.3
pause
%windir%\system32\reg.exe query "HKU\S-1-5-19" >nul 2>&1 || (
	cls
	echo.
	echo. _____________________________________________________________________________
	echo. Š===========================================================================Š
	echo. Š                           *** A T T E N T I O N ***                       Š
	echo. Š===========================================================================Š
	echo. Š                                                                           Š
	echo. Š                     DROITS ADMINISTRATEUR NON DETECTE                     Š
	echo. Š                   =====================================                   Š
	echo. Š                                                                           Š
	echo. Š              Ce script Requieres les Privileges Administrateur.           Š
	echo. Š   Faite clic droit ^& Select 'executer en tant que Administrateur'         Š
	echo. Š                                                                           Š
	echo. Š___________________________________________________________________________Š
	echo. =============================================================================
	echo.
	echo.pressez une touche pour sortir...
	pause >nul

	goto :EEXIT
)

cls
echo.
echo                    Bienvenue Sur Phoenix OffLine Installer          v%currentver%
echo                           What do you wish to do?
echo                     __________________________________

IF EXIST %TEMP%\PACK_LOG-OK.txt (GOTO INSTALLOK) ELSE (GOTO DEBUT)


:debut
REM Variable pour alléger le code

set =echo le systeme d'exploitation est Windows 
set =echo OS détecté: Windows 
set =echo ATTENTION CETTE VERSION DE WINDOWS EST OBSOLÉTE!!!
set =echo ATTENTION CECI EST UNE VERSION BETA DE WINDOWS!!!
set =echo ATTENTION CETTE VERSION EST DE WINDOWS INSTABLE!!!
set =echo ATTENTION CECI EST UNE VERSION ALPHA DE WINDOWS!!!


set TECHNAME=BETA TEST
set SETUP="%TEMP%\Phoenix\Setups"
set LOG="%TEMP%\Phoenix.log"
set APPLOG="%TEMP%\Applications.log"
set LMD="%SETUP%\LManager-mod\Setup.exe" /S /NoReboot /L:%APPLOG%
REM set MSO=%SETUP%\Office\setup.exe /adminfile %SETUP%\Office\phoenix.MSP
set PPV=%SETUP%\PowerPointViewer\ppviewer.msi /passive /norestart
set DAZ="%SETUP%\Windows Loader\Windows Loader.exe" /silent /preactivate /noreboot
set ADWC="%SETUP%\ADWCleaner.exe"
set BDAV="%SETUP%\Bitdefender.exe" /silent /norestart
set CC="%SETUP%\CCleaner.exe" /S /L=1036
set CDBXP="%SETUP%\CDBurnerxp.exe" /nocandy /silent
set DOTNET="%SETUP%\dotnet.exe" /r /norestart /log %TEMP%\dotnet.htm
set MFF="%SETUP%\Firefox.exe" /s /log=%APPLOG%
set KLCP="%SETUP%\K-Lite.exe" /silent /log=%APPLOG%
set MBAM="%SETUP%\Malwarebytes.exe" /silent /log=%APPLOG%
set ADR="%SETUP%\Reader.exe" /sPB /rs /sl 1036 /msi /norestart /l+v %APPLOG%
set JAVA="%SETUP%\java.exe" /s
set MTB="%SETUP%\Thunderbird.exe" /s
set OOO="%SETUP%\OOO\setup.exe" /q
GOTO OSTYPE


:OSTYPE
ECHO installation du pack logiciel "Phoenix Informatique" sur le poste %COMPUTERNAME% le %DATE% à %TIME% par %TECHNAME% >> %LOG%
ECHO Deploiment de Phoenix OffLine Installer (POLI) sur le poste %COMPUTERNAME% le %DATE% à %TIME% par %TECHNAME% 
ECHO l'architecture du poste est un %PROCESSOR_ARCHITECTURE% >> %LOG%
ECHO l'architecture du poste est un %PROCESSOR_ARCHITECTURE%
REM script de détermination de l'OS
REM Detection de l'OS
ECHO Detection de l'OS

ver | find /i "version 10.0.10565" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10IP
if %ERRORLEVEL% == 0 goto ver_W10IP3

ver | find /i "version 10.0.10240" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10RTM
if %ERRORLEVEL% == 0 goto ver_W10RTM

ver | find /i "version 10.0.10225" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10IP
if %ERRORLEVEL% == 0 goto ver_W10IP2

ver | find /i "version 10.0.10166" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10IP1
if %ERRORLEVEL% == 0 goto ver_W10IP1

ver | find /i "version 10.0.10049" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10TP6
if %ERRORLEVEL% == 0 goto ver_W10TP6

ver | find /i "version 10.0.10041" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10TP5
if %ERRORLEVEL% == 0 goto ver_W10TP5

ver | find /i "version 10.0.9926" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10TP4
if %ERRORLEVEL% == 0 goto ver_W10TP4

ver | find /i "version 10.0.9879" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10TP3
if %ERRORLEVEL% == 0 goto ver_W10TP3

ver | find /i "version 10.0.9860" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10TP2
if %ERRORLEVEL% == 0 goto ver_W10TP2

ver | find /i "version 10.0.9841" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=W10TP1
if %ERRORLEVEL% == 0 goto ver_W10TP1

ver | find /i "version 6.3.9600" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 8.1-2012R2
if %ERRORLEVEL% == 0 goto ver_heightoneU1

ver | find /i "version 6.3.9200" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 8.1-2012R2
if %ERRORLEVEL% == 0 goto ver_heightone

ver | find /i "version 6.2.10211" > nul
if %ERRORLEVEL% == 0 goto ver_winphone
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Phone

ver | find /i "version 6.2.9200.16384" > nul
if %ERRORLEVEL% == 0 goto ver_heightRTM
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 8-2012

ver | find /i "version 6.2.9200" > nul
if %ERRORLEVEL% == 0 goto ver_height
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 8-2012

ver | find /i "version 6.1.8400" > nul
if %ERRORLEVEL% == 0 goto ver_HS2011
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Home Server 2011

ver | find /i "version 6.2.8102" > nul
if %ERRORLEVEL% == 0 goto ver_2012DP
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Server 2012 Developer Preview

ver | find /i "version 6.1.7601" > nul
if %ERRORLEVEL% == 0 goto ver_7SP1
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 7SP1-2008R2SP1

ver | find /i "version 6.1.7600" > nul
if %ERRORLEVEL% == 0 goto ver_7
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 7-2008R2

ver | find /i "version 6.0.6002" > nul
if %ERRORLEVEL% == 0 goto ver_vistaSP2
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista SP2-2008

ver | find /i "version 6.0.6001" > nul
if %ERRORLEVEL% == 0 goto ver_vistaSP1
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista SP1-2008

ver | find /i "version 6.0.6000.16386" > nul
if %ERRORLEVEL% == 0 goto ver_vistaRTM
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista RTM-2008

ver | find /i "version 6.0.6000" > nul
if %ERRORLEVEL% == 0 goto ver_vista
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista-2008

ver | find /i "version 6.0.5840" > nul
if %ERRORLEVEL% == 0 goto ver_vista5840
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre RTM build 5840

ver | find /i "version 6.0.5824" > nul
if %ERRORLEVEL% == 0 goto ver_vista5824
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre RTM build 5824

ver | find /i "version 6.0.5808" > nul
if %ERRORLEVEL% == 0 goto ver_vista5808
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre RTM build 5808

ver | find /i "version 6.0.5744.16384" > nul
if %ERRORLEVEL% == 0 goto ver_vistaRC2
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista RC2

ver | find /i "version 6.0.5728" > nul
if %ERRORLEVEL% == 0 goto ver_vista5728
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre-RC2 Build 5728

ver | find /i "version 6.0.5700" > nul
if %ERRORLEVEL% == 0 goto ver_vista5700
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre-RC2

ver | find /i "version 6.0.5600.16384" > nul
if %ERRORLEVEL% == 0 goto ver_vistaRC1
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista RC1

ver | find /i "version 6.0.5536" > nul
if %ERRORLEVEL% == 0 goto ver_vista5536
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre-RC1 Build 5536

ver | find /i "version 6.0.5472" > nul
if %ERRORLEVEL% == 0 goto ver_vista5472
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre-RC1 Build 5472

ver | find /i "version 6.0.5456" > nul
if %ERRORLEVEL% == 0 goto ver_vista5456
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Pre-RC1

ver | find /i "version 6.0.5384" > nul
if %ERRORLEVEL% == 0 goto ver_vistaB2
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Beta 2

ver | find /i "version 6.0.5381" > nul
if %ERRORLEVEL% == 0 goto ver_vistaB2P
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista Beta 2 Preview

ver | find /i "version 6.0.5365" > nul
if %ERRORLEVEL% == 0 goto ver_vista5365
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista April EWD

ver | find /i "version 6.0.5342" > nul
if %ERRORLEVEL% == 0 goto ver_vista5342
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista CTP Refresh

ver | find /i "version 6.0.5308" > nul
if %ERRORLEVEL% == 0 goto ver_vista5308
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista CTP February

ver | find /i "version 6.0.5270" > nul
if %ERRORLEVEL% == 0 goto ver_vista5270
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista CTP December

ver | find /i "version 6.0.5259" > nul
if %ERRORLEVEL% == 0 goto ver_vista5259
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista TAP Preview

ver | find /i "version 6.0.5219" > nul
if %ERRORLEVEL% == 0 goto ver_vistaCTP
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista CTP

ver | find /i "version 6.0.5112" > nul
if %ERRORLEVEL% == 0 goto ver_vistaB1
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista-2008

ver | find /i "version 6.0.5048" > nul
if %ERRORLEVEL% == 0 goto ver_Longhorn
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Longhorn

ver | find /i "version 5.2.3790.1218" > nul
if %ERRORLEVEL% == 0 goto ver_server2003

ver | find /i "version 5.2.3790.1180" > nul
if %ERRORLEVEL% == 0 goto ver_server2003SP1

ver | find /i "version 5.2.3790" > nul
if %ERRORLEVEL% == 0 goto ver_xppro64

ver | find /i "version 5.2.3763" > nul
if %ERRORLEVEL% == 0 goto ver_2003B

ver | find /i "version 5.2.3718" > nul
if %ERRORLEVEL% == 0 goto ver_NETserverRC2

ver | find /i "version 5.2.3660" > nul
if %ERRORLEVEL% == 0 goto ver_NETserverRC1

ver | find /i "version 5.2.3590" > nul
if %ERRORLEVEL% == 0 goto ver_NETserverB3

ver | find /i "version 5.2.3541" > nul
if %ERRORLEVEL% == 0 goto ver_NETserverinterim

ver | find /i "version 5.1.2600.2180" > nul
if %ERRORLEVEL% == 0 goto ver_XPSP2

ver | find /i "version 5.1.2600.1105-1106" > nul
if %ERRORLEVEL% == 0 goto ver_XPSP1

ver | find /i "version 5.1.2600" > nul
if %ERRORLEVEL% == 0 goto ver_XP

ver | find /i "version 5.1.2505" > nul
if %ERRORLEVEL% == 0 goto ver_XPRC1

ver | find /i "version 5.0.2195" > nul
if %ERRORLEVEL% == 0 goto ver_2000PRO

ver | find /i "version 5.00.2195" > nul
if %ERRORLEVEL% == 0 goto ver_2000

ver | find /i "version 5.00.2183" > nul
if %ERRORLEVEL% == 0 goto ver_2000B3

ver | find /i "version 5.00.2128" > nul
if %ERRORLEVEL% == 0 goto ver_2000B3RC2

ver | find /i "version 5.00.2031" > nul
if %ERRORLEVEL% == 0 goto ver_2000B3RC1

ver | find /i "version 5.00.1515" > nul
if %ERRORLEVEL% == 0 goto ver_NT5B2

ver | find /i "version 4.90.3000" > nul
if %ERRORLEVEL% == 0 goto ver_ME

ver | find /i "version 4.90.2419" > nul
if %ERRORLEVEL% == 0 goto ver_MEB2

ver | find /i "version 4.90.2476" > nul
if %ERRORLEVEL% == 0 goto ver_MEB

ver | find /i "version 4.10.2222" > nul
if %ERRORLEVEL% == 0 goto ver_98SE

ver | find /i "version 4.10.1998" > nul
if %ERRORLEVEL% == 0 goto ver_98

ver | find /i "version 4.00.1381" > nul
if %ERRORLEVEL% == 0 goto ver_NT4

ver | find /i "version 4.03.1214" > nul
if %ERRORLEVEL% == 0 goto ver_95OSR25

ver | find /i "version 4.03.1212-1214" > nul
if %ERRORLEVEL% == 0 goto ver_95OSR21

ver | find /i "version 4.03.1111" > nul
if %ERRORLEVEL% == 0 goto ver_95OSR2

ver | find /i "version 4.00.950" > nul
if %ERRORLEVEL% == 0 goto ver_95

if not exist %SystemRoot%\system32\systeminfo.exe goto osinconnu
goto osinconnu

:ver_W10IP3
ECHO le systeme d'exploitation est Windows 10 Insider Preview V3 >> %LOG%
ECHO OS détecté: Windows 10 Insider Preview 3
goto INSTALL

:ver_W10IP2
ECHO le systeme d'exploitation est Windows 10 Insider Preview V2 >> %LOG%
ECHO OS détecté: Windows 10 Insider Preview 2
goto INSTALL

:ver_W10IP1
ECHO le systeme d'exploitation est Windows 10 Insider Preview V1 >> %LOG%
ECHO OS détecté: Windows 10 Insider Preview
goto INSTALL

:ver_W10RTM
ECHO le systeme d'exploitation est Windows 10 RTM >> %LOG%
ECHO OS détecté: Windows 
goto INSTALL

:ver_W10TP6
ECHO le systeme d'exploitation est Windows 10 Technical Preview V6  >> %LOG%
ECHO OS détecté: Windows 10 Technical Preview 6eme version
goto INSTALL

:ver_W10TP5
ECHO le systeme d'exploitation est Windows 10 Technical Preview  V5 >> %LOG%
ECHO OS détecté: Windows 10 Technical Preview 5eme version
goto INSTALL

:ver_W10TP4
ECHO le systeme d'exploitation est Windows 10 Technical Preview V4 >> %LOG%
ECHO OS détecté: Windows 10 Technical Preview 4eme version
goto INSTALL

:ver_W10TP3
ECHO le systeme d'exploitation est Windows 10 Technical Preview V3 >> %LOG%
ECHO OS détecté: Windows 10 Technical Preview 3eme version
goto INSTALL

:ver_W10TP2
ECHO le systeme d'exploitation est Windows 10 Technical Preview V2 >> %LOG%
ECHO OS détecté: Windows 10 Technical Preview 2eme version
goto INSTALL

:ver_W10TP1
ECHO le systeme d'exploitation est Windows 10 Technical Preview V1 >> %LOG%
ECHO OS détecté: Windows 10 Technical Preview 1ere version
goto INSTALL

:ver_heightoneU1
ECHO le systeme d'exploitation est Windows 8.1 Update 1 ou 2012 R2 >> %LOG%
ECHO OS détecté: Windows 8.1 Update 1  ou Server 2012 R2
goto INSTALL

:ver_heightone
ECHO le systeme d'exploitation est Windows 8.1 ou 2012 R2 >> %LOG%
goto INSTALL

:ver_winphone
ECHO Il semblerait que vous essayez d'executer le script depuis un téléphone windows
ECHO Soit il y à un souci sois vous êtes un peu très distrait!!!
GOTO INCOMPATIBLE

:ver_height
ECHO le systeme d'exploitation est Windows 8 ou 2012 >> %LOG%
goto INSTALL

:ver_HS2011
ECHO le systeme d'exploitation est Windows Home Server 2011 >> %LOG%
ECHO OS détecté: Windows Home Server 2011 
goto INSTALL

:ver_2012DP
ECHO le systeme d'exploitation est Windows Server 2012 DP >> %LOG%
ECHO OS Détecté: Windows Server 2012 Developer Preview
GOTO INSTALL

:ver_7SP1
ECHO le systeme d'exploitation est Windows 7 SP1 ou 2008 R2 SP1. >> %LOG%
ECHO OS Détecté: Windows 7 SP1 ou Windows Server 2008 R2 SP1
goto checkactivation

:ver_7
ECHO le systeme d'exploitation est Windows 7 ou 2008 R2. >> %LOG%
ECHO OS Détecté: Windows 7 ou Windows Server 2008 R2 SANS le SP1
goto checkactivation


:ver_vistaSP2
ECHO le systeme d'exploitation est Windows Vista ou Server 2008 SP2. >> %LOG%
ECHO OS Détecté: Windows Windows Vista SP2 ou Windows Server 2008 SP2
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO Proposez au client de faire la mise à niveau vers Windows 10
goto checkactivation

:ver_vistaSP1
ECHO le systeme d'exploitation est Windows Vista SP1 ou Server 2008 SP1. >> %LOG%
ECHO OS Détecté: Windows Vista SP1 ou Server 2008 SP1 SANS SP2.
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto checkactivation

:ver_vistaRTM
ECHO le systeme d'exploitation est Windows Vista RTM. >> %LOG%
ECHO OS Détecté: Windows Vista RTM SANS SP1 ni SP2
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto checkactivation

:ver_vista
ECHO le systeme d'exploitation est Windows Vista . >> %LOG%
ECHO OS Détecté: Windows Vista SANS SP1 ni SP2
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto checkactivation


:ver_vista5840
ECHO le systeme d'exploitation est Windows Vista Pre-RTM Build 5840. >> %LOG%
ECHO OS Détecté: Windows Vista  Pre-RTM Build 5840
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vista5824
ECHO le systeme d'exploitation est Windows Vista Pre-RTM Build 5824. >> %LOG%
ECHO OS Détecté: Windows Vista Pre-RTM Build 5824
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vista5808
ECHO le systeme d'exploitation est Windows Vista Pre-RTM Build 5808. >> %LOG%
ECHO OS Détecté: Windows Vista Pre-RTM Build 5808
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vistaRC2
ECHO le systeme d'exploitation est Windows Vista RC2. >> %LOG%
ECHO OS Détecté: Windows Vista Release Candidate 2
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vista5728
ECHO le systeme d'exploitation est Windows Vista Pre-RC2 Build 5728. >> %LOG%
ECHO OS Détecté: Windows Vista Pre-RC2 (Release Candidate) Build 5728
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vista5700
ECHO le systeme d'exploitation est Windows Vista Pre-RC2. >> %LOG%
ECHO OS Détecté: Windows Vista Pre-RC2 (Release Candidate)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vistaRC1
ECHO le systeme d'exploitation est Windows Vista RC1. >> %LOG%
ECHO OS Détecté: Windows Vista Release Candidate 1
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vista5536
ECHO le systeme d'exploitation est Windows Vista Pre-RC1 Build 5536. >> %LOG%
ECHO OS Détecté: Windows Vista Pre-RC1 Build 5536
goto vistainstable

:ver_vista5472
ECHO le systeme d'exploitation est Windows Vista Pre-RC1 Build 5472. >> %LOG%
ECHO OS Détecté: Windows Vista Pre-RC1 Build 5472
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vista5456
ECHO le systeme d'exploitation est Windows Vista Pre-RC1. >> %LOG%
ECHO OS Détecté: Windows Vista  Pre-RC1
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
goto vistainstable

:ver_vistaB2
ECHO le systeme d'exploitation est Windows Vista Beta2. >> %LOG%
ECHO OS Détecté: Windows Vista Beta2
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_vistaB2P
ECHO le systeme d'exploitation est Windows Vista Beta 2 Preview. >> %LOG%
ECHO OS Détecté: Windows Vista Beta 2 Preview
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_vista5365
ECHO le systeme d'exploitation est Windows Vista EWD. >> %LOG%
ECHO OS Détecté: Windows Vista April EWD (inconnue)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_vista5342
ECHO le systeme d'exploitation est Windows Vista CTP Refresh. >> %LOG%
ECHO OS Détecté: Windows Vista CTP Refresh (inconnue)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_vista5308
ECHO le systeme d'exploitation est Windows Vista CTP February. >> %LOG%
ECHO OS Détecté: Windows Vista CTP February (inconnue)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

: ver_vista5270
ECHO le systeme d'exploitation est Windows Vista CTP December. >> %LOG%
ECHO OS Détecté: Windows Vista CTP December (inconnue)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_vista5259
ECHO le systeme d'exploitation est Windows Vista TAP Preview. >> %LOG%
ECHO OS Détecté: Windows Vista TAP Preview (inconnue)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_vistaCTP
ECHO le systeme d'exploitation est Windows Vista CTP. >> %LOG%
ECHO OS Détecté: Windows Vista CTP (inconnue)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_vistaB1
ECHO le systeme d'exploitation est Windows Vista Beta 1. >> %LOG%
ECHO OS Détecté: Windows Vista Beta 1
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CECI EST UNE VERSION BETA!!!
goto vistainstable

:ver_Longhorn
ECHO le systeme d'exploitation est Windows Longhorn ou Windows Vista Alpha. >> %LOG%
ECHO OS Détecté: Windows Longhorn (Windows Vista Alpha)
ECHO ATTENTION CETTE VERSION EST OBSOLÉTE!!!
ECHO ATTENTION CETTE VERSION EST INSTABLE
ECHO ATTENTION CETTE VERSION EST DESTINÉ À DES FIN DE TESTS UNIQUEMENT
ECHO ATTENTION CECI EST UNE VERSION ALPHA!!!
goto vistainstable


:ver_xp
ECHO le systeme d'exploitation est Windows XP. >> %LOG%
goto INSTALL

:ver_2003
ECHO le systeme d'exploitation est Windows Server 2003. >> %LOG%
goto INSTALL

:ver_2000
ECHO le systeme d'exploitation est Windows 2000. >> %LOG%
goto INSTALL

:ver_nt
ECHO le systeme d'exploitation est Windows NT. >> %LOG%
goto INSTALL

:ver_ME
ECHO le systeme d'exploitation est Windows ME. >> %LOG%
goto INSTALL

:ver_nineheight
ECHO le systeme d'exploitation est Windows 98. >> %LOG%
goto INSTALL

:ver_ninefive
ECHO le systeme d'exploitation est Windows 95. >> %LOG%
goto INSTALL

:osinconnu
ECHO le systeme d'exploitation est inconnu. >> %LOG%
goto INCOMPATIBLE

:vistainstable
ECHO Cette version de Windows Vista n'est pas pris en charge pour le moment
ECHO Abandon du deploiment
GOTO INCOMPATIBLE

:checkactivation
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo Windows est activé
) else (
  echo Windows N'EST PAS activé)
  
if /i "%licenseStatus%"=="Licensed" (
  goto INSTALL
) else (
  goto activation)

:ACTIVATION
set /p reponse=Voulez-vous Pré-activer Windows (yes/no/oui/non/o/n)? :
 
if /I "%reponse%"=="oui" (goto :OUI)
if /I "%reponse%"=="o" (goto :OUI)
if /I "%reponse%"=="y" (goto :OUI)
if /I "%reponse%"=="O" (goto :OUI)
if /I "%reponse%"=="Y" (goto :OUI)
if /I "%reponse%"=="yes" (goto :OUI)
if /I "%reponse%"=="non" (goto :NON)
if /I "%reponse%"=="n" (goto :NON)
if /I "%reponse%"=="no" (goto :NON)
if /I "%reponse%"=="NO" (goto :NON)
if /I "%reponse%"=="NON" (goto :NON)
if /I "%reponse%"=="N" (goto :NON)

goto ACTIVATION
 
:OUI
echo.
ECHO Activation de Windows, cliquez sur la demande de l'UAC
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% Activation de Windows >> %LOG%
ECHO -------------------------------------- >> %LOG%
%DAZ%
ECHO Windows devrait etre activé au prochain redemmarage
GOTO INSTALL
 
:NON
echo.
echo Activation de Windows abandonnée !
goto INSTALL


:INSTALL  
ECHO installation de .net Framework 1/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de .net Framework >> %LOG%
ECHO -------------------------------------- >> %LOG%
%dotnet%
ECHO installation de MalwareByte Anti-Malware 2/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de MalwareByte Anti-Malware >> %LOG%
ECHO -------------------------------------- >> %LOG%
%MBAM%
ECHO installation de Mozilla Firefox 3/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de  >> %LOG%
ECHO -------------------------------------- >> %LOG%
%MFF%
ECHO installation de Mozilla Thunderbird 4/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de Mozilla Thunderbird >> %LOG%
ECHO -------------------------------------- >> %LOG%
%MTB%
ECHO installation de LManager-mod 5/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de LManager version Phoenix informatique >> %LOG%
ECHO -------------------------------------- >> %LOG%
%LMD%
ECHO installation de K-Lite Codec Pack 6/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de K-Lite Codec Pack >> %LOG%
ECHO -------------------------------------- >> %LOG%
%KLCP%
REM ECHO installation de Java, cliquez sur la demande de l'UAC
REM ECHO -------------------------------------- >> %LOG%
REM ECHO %TIME% installation de Java >> %LOG%
REM ECHO -------------------------------------- >> %LOG%
REM %JAVA%
ECHO installation de CCleaner 7/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de CCleaner >> %LOG%
ECHO -------------------------------------- >> %LOG%
%CC%
ECHO installation de Adobe Reader 8/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de Adobe Reader >> %LOG%
ECHO -------------------------------------- >> %LOG%
%ADR%

ECHO installation de CDBurnerXp 9/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de CDBurnerXp >> %LOG%
ECHO -------------------------------------- >> %LOG%
%CDBXP%
ECHO installation de Bitdefender 10/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de Bitdefender >> %LOG%
ECHO -------------------------------------- >> %LOG%
%BDAV%
ECHO installation de Appache OpenOffice 11/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de Appache OpenOffice >> %LOG%
ECHO -------------------------------------- >> %LOG%
%OOO%
ECHO installation de Power Point Viewer 12/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de Power Point Viewer >> %LOG%
ECHO -------------------------------------- >> %LOG%
msiexec %PPV%


IF NOT EXIST "%USERPROFILE%\Desktop\ADWCleaner.exe" (GOTO ADWINSTALL) ELSE (goto ADWUPDATE)

:ADWINSTALL
ver | find /i "version 5.1." > nul
if %ERRORLEVEL% == 0 (goto ADWXP) ELSE ( goto other)
ECHO installation de ADWcleaner 13/13
ECHO -------------------------------------- >> %LOG%
ECHO %TIME% installation de ADWcleaner >> %LOG%
ECHO -------------------------------------- >> %LOG%
:ADWXP
COPY %ADWC% "%USERPROFILE%\Bureau\ADWCleaner.exe"
GOTO QUESTION
:other
COPY %ADWC% "%USERPROFILE%\Desktop\ADWCleaner.exe"
GOTO QUESTION

:ADWUPDATE
ECHO ADWCleaner est déja installé, une fonctionnalité de Mise a jour sera implémenté
PAUSE
GOTO QUESTION


REM :question
REM set /p choix=Voulez-vous installer Office 2007 (yes/no/oui/non/o/n)? :
 
REM if /I "%choix%"=="oui" (goto :A)
REM if /I "%choix%"=="y" (goto :A)
REM if /I "%choix%"=="yes" (goto :A)
REM if /I "%choix%"=="non" (goto :B)
REM if /I "%choix%"=="n" (goto :B)
REM if /I "%choix%"=="no" (goto :B)

REM goto question
 
REM :A
REM echo.
REM ECHO installation de Microsoft Office 2007, cliquez sur la demande de l'UAC
REM ECHO -------------------------------------- >> %LOG%
REM ECHO %TIME% installation de Microsoft Office 2007 >> %LOG%
REM ECHO -------------------------------------- >> %LOG%
REM %MSO%
REM goto confirmation
 
REM :B
REM echo.
REM echo Installation de Microsoft office 2007 abandonné !
REM goto confirmation
 

:CONFIRMATION
ECHO Le pack logiciel est installé
PAUSE
ECHO Le pack logiciel est installé >> %USERPROFILE%\Desktop\PACK_LOG-OK.txt
ECHO Le pack logiciel est installé >> %TEMP%\PACK_LOG-OK.txt
GOTO FIN

:INSTALLOK
ECHO L'installation du pack logiciel a été déja effectué
ECHO Tentative de réinstallation du pack logiciel le %DATE% a %TIME% >> %TEMP%\PACK_LOG-OK.txt
PAUSE
GOTO :FIN
:FIN
ECHO finalisation
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {59031a47-3f72-44a7-89c5-5595fe6b30ee} /T REG_DWORD /D 0 /F
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {20D04FE0-3AEA-1069-A2D8-08002B30309D} /T REG_DWORD /D 0 /F
ECHO installation terminé le %DATE% a %TIME%
ECHO installation terminé le %DATE% a %TIME% >> %LOG%
ECHO lancement de windows update
wuauclt /ShowWU /detectnow
PAUSE
exit

:INCOMPATIBLE
ECHO La plateforme n'est pas supportée
GOTO EEXIT

:EEXIT
Echo hum... il faut lire les indications..!
pause >nul
exit
