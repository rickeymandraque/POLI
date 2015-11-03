::Phoenix OffLine Installer Toolkit updater
@echo off
color 9f
set newver=2.3
echo la version actuel de PO-LI est %currentver%
pause
IF %newver% GTR %currentver% goto update
IF %newver% EQU %currentver% goto noup
IF %newver% LSS %currentver% goto beta

:noup
echo La derniere version de PO-LI est %newver%
echo Il n'y a pas de nouvelle mise à jour pour le moment
pause
call something

:beta
echo ATTENTION! Vous utilisez une version de test de  PO-LI.
pause
call POLI
:update
cls
echo Mise à jour de la version %currentver% à la version %newver%
echo pressez une touche pour faire la mise à jour.
pause 2>nul
echo PO-LI est en cour de mise à jour vers la version %newver%
start /wait wget https://github.com/rickeymandraque/POLI/POLI.up
del something.exe
ren poli.up poli.exe
call poli
