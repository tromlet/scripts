@echo off

set WORKDIR=%temp%\TSP1-BD-SEP-%random%

:environment-get-bitness
set SECTION=environment-get-bitness

wmic /output:"%workdir%\bitness.txt" os get osarchitecture /format:list
for /f "tokens=2 delims==" %%g in ("%workdir%\bitness.txt") do (set WMIC_BITNESS=%%g)
for /f "tokens=2 delims==" %g in ("%workdir%\bitness.txt") do (set WMIC_BITNESS=%g)
if %wmic_bitness% EQU 


mkdir "%workdir%"
robocopy ""