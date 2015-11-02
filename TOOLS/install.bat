@ECHO off
cls
color 9f
Echo Ce script doit etre lancer en tant qu'administrateur
ECHO si ce n'est pas le cas faites CTRL+C et relancez le.
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
IF EXIST %TEMP%\PACK_LOG-OK.txt (GOTO INSTALLOK) ELSE (GOTO DEBUT)


:debut
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
ECHO l'architecture du poste est un %PROCESSOR_ARCHITECTURE% >> %LOG%
REM script de détermination de l'OS
REM Detection de l'OS
REM Detection de l'OS
ver | find /i "version 6.3." > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 8.1-2012R2
if %ERRORLEVEL% == 0 goto ver_heightone
ver | find /i "version 6.2." > nul
if %ERRORLEVEL% == 0 goto ver_height
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 8-2012
ver | find /i "version 6.1." > nul
if %ERRORLEVEL% == 0 goto ver_7
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 7-2008R2
ver | find /i "version 6.0." > nul
if %ERRORLEVEL% == 0 goto ver_vista
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows Vista-2008
ver | find /i "version 5.1." > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows XP
if %ERRORLEVEL% == 0 goto ver_xp
ver | find /i "version 5.2." > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 2003
if %ERRORLEVEL% == 0 goto ver_2003
ver | find /i "Windows 2000" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 2000
if %ERRORLEVEL% == 0 goto ver_2000
ver | find /i "Windows NT" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows NT
if %ERRORLEVEL% == 0 goto ver_nt
ver | find /i ">Windows ME" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows ME
if %ERRORLEVEL% == 0 goto ver_ME
ver | find /i "Windows 98" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 98
if %ERRORLEVEL% == 0 goto ver_nineheight
ver | find /i "Windows 95" > nul
REM if %errorlevel%==0 set $VERSIONWINDOWS=Windows 95
if %ERRORLEVEL% == 0 goto ver_ninefive
if not exist %SystemRoot%\system32\systeminfo.exe goto osinconnu
goto osinconnu

:ver_heightone
ECHO le systeme d'exploitation est Windows 8.1 ou 2012 R2 >> %LOG%
goto INSTALL

:ver_height
ECHO le systeme d'exploitation est Windows 8 ou 2012 >> %LOG%
goto INSTALL


:ver_7
ECHO le systeme d'exploitation est Windows 7 ou 2008 R2. >> %LOG%
goto checkactivation

:ver_vista
ECHO le systeme d'exploitation est Windows Vista ou 2008. >> %LOG%
goto checkactivation

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
goto INSTALL


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
if /I "%reponse%"=="yes" (goto :OUI)
if /I "%reponse%"=="non" (goto :NON)
if /I "%reponse%"=="n" (goto :NON)
if /I "%reponse%"=="no" (goto :NON)

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

:EEXIT
Echo hum... il faut lire les indications..!
pause >nul
exit
