@echo off
REM Script copie des setup
REM dfinition de l'environnement

REM IF NOT EXIST "%PROGRAMFILES(X86)%" (set 7z=TOOLS\7-Zip\x86\7z.exe) else (set 7z=TOOLS\7-Zip\x64\7z.exe)
ECHO ATTENTION ce script NE doit PAS etre lancé en tant qu'administrateur si vous avez fait une erreur appuyez sur CTRL+C
pause
cls
IF NOT EXIST "%PROGRAMFILES(X86)%" (GOTO x86) else (GOTO AMD64)




:AMD64
set unzip=TOOLS\7-Zip\x64\7z.exe
set CDBXP=setup_cdburnerxp_x64.exe
set BDAV=bitdefender_av_64b.exe
REM set JAVA=
REM set AOO=Apache_OpenOffice_4.1.0_Win_x86_64_install_fr.exe
GOTO COMMON

:X86
set unzip=TOOLS\7-Zip\x86\7z.exe
set CDBXP=setup_cdburnerxp_x32.exe
set BDAV=bitdefender_av_32b.exe
REM AOO=Apache_OpenOffice_4.1.0_Win_x86_install_fr.exe
REM set JAVA=
GOTO COMMON

:COMMON
REM environnement
set SETUP=%TEMP%\Phoenix\Setups
set LOG=%TEMP%\Phoenix.log
set APPLOG=%TEMP%\Applications.log
set SCRIPT=TOOLS\Install.bat
REM Logiciels
set ADR=AdbeRdr1010_fr_FR.exe
set ADWC=adwcleaner.exe
set KLCP=k-lite-codec-pack.exe
set LMD=LManager-mod.7z
set MBAM=malwarebytes.exe
set MSO=Office.7z
set PPV=PowerPointViewer.exe
set CC=setup_ccleaner.exe
set MFF=setup_firefox_1036.exe
set MTB=setup_thunderbird_1036.exe
set DAZ="TOOLS\Windows Loader.7z"
set DOTNET=setup_dotnet.exe
set OOO=setup_openoffice_1036.exe
GOTO INSTALL
 

:INSTALL
MKDIR %TEMP%\Phoenix
MKDIR %SETUP%
REM COPY %JAVA% %SETUP%\Java.exe
COPY %CDBXP% %SETUP%\CDBurnerXP.exe
COPY %DOTNET% %SETUP%\dotnet.exe
COPY %ADWC% %SETUP%\ADWCleaner.exe
COPY %KLCP% %SETUP%\K-Lite.exe
REM COPY %DAZ% %SETUP%\
COPY %MFF% %SETUP%\Firefox.exe
COPY %MTB% %SETUP%\Thunderbird.exe
COPY %MBAM% %SETUP%\Malwarebytes.exe
COPY %CDBXP% %SETUP%\CDBurnerXP.exe
COPY %ADR% %SETUP%\Reader.exe
COPY %CC% %SETUP%\CCleaner.exe
COPY %BDAV% %SETUP%\Bitdefender.exe
MKDIR "%SETUP%\PowerPointViewer"
%unzip% x %PPV% -o"%SETUP%\PowerPointViewer"
REM %unzip% x %MSO% -o%SETUP%
%unzip% x %LMD% -o%SETUP%
%unzip% x %OOO% -o%SETUP%\OOO
ver | find /i "version 5.1." > nul
if %ERRORLEVEL% == 0 (goto ver_xp) ELSE ( goto other)


:ver_xp
COPY %SCRIPT% "%USERPROFILE%\Bureau\Install.bat"
goto fin
:other
%unzip% x %DAZ% -o%SETUP%
COPY %SCRIPT% "%USERPROFILE%\DESKTOP\Install.bat"
goto fin
:fin
echo copie terminé!!!
pause
