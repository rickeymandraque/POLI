::Phoenix OffLine Installer updater
@echo off
color 9f
set newver=2.3
echo POLI is currently at %currentver%
pause
IF %newver% GTR %currentver% goto update
IF %newver% EQU %currentver% goto noup
IF %newver% LSS %currentver% goto beta

:noup
echo Latest POLI is at %newver%
echo There are no new updates at this time
pause
call FlashcartHelper

:beta
echo WARNING! You are running a beta version of POLI.
pause
call POLI
:update
cls
echo There is an update from %currentver% to %newver%
echo Press any key to update.
pause 2>nul
echo POLI is updating to %newver%
start /wait wget https://github.com/rickeymandraque/POLI/POLI.up
del something.exe
ren poli.up poli.exe
call poli
