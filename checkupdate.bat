@echo off
REM version Actuel
set currentver=2.3
title Phoenix OffLine Installer (POLI) %currentver%
::Update routine, if fh.bat exists, will go directly to begin. If not, will continue.
:uptest
IF EXIST POLIup.bat. (
goto begin
) ELSE (
goto gpl
)
:gpl
::GPL notice
cls
title POLI %currentver% version: GPL notice
echo POLI %currentver% Copyright (C) 2011  Punyman
echo    This program comes with ABSOLUTELY NO WARRANTY; neither express not implied
echo    This is free software, and you are welcome to redistribute it
echo    under certain conditions;read the license for details.
echo    POLI is not responsible for any data loss resulting from
echo    improper use of this utility, including Data corruption, 
echo    or bricked flashcarts. FlashcartHelper is distributed in the hope that
echo    it will be useful, but this does not guarantee that it will be. 
echo    By continuing, it is assumed that you agree to the following terms
pause
cls
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
goto something
) ELSE (
echo 7za.exe not found
echo Pressez une touche pour le télécharger.
pause >nul
start /wait wget http://7za.exe
goto something
)
::required or it will go into an infinite loop.
:uptest
IF EXIST POLIup.bat. (
goto begin
) ELSE (
goto up
)
::fetches update file, disabled in BAT versions , source
:up
::Fetch Update File
wget -q http://POLIup.bat 2>nul
call POLIup.bat
