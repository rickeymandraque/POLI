@echo off
REM version Actuel
set currentver=2.3
title Phoenix OffLine Installer (POLI) %currentver%

REM tests de wget
:wgettest
IF EXIST .\TOOLS\wget.exe. (
goto unrartest
) ELSE (
echo wget n'as pas été trouvé
echo Il n'y à pas de solution
echo Appuyez su une touche pour terminer.
pause >nul
exit
)
REM tests si unrar est present, si il n'y est pas nous allons le télécharger
:unrartest 
IF EXIST unrar.exe. (
goto 7ztest
) ELSE (
echo unrar n'est pas présent.
echo Pressez une touche pour le télécharger.
pause >nul
start /wait wget http://unrar.exe(à définir)
goto 7ztest
)
REM tests if 7za is present, if not will download
:7ztest
IF EXIST 7za.exe. (
goto frectest
) ELSE (
echo 7za.exe not found
echo Pressez une touche pour le télécharger.
pause >nul
start /wait wget http://7za.exe
goto something
)
