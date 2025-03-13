@echo off
REM ===========================================
REM Author: Darpan
REM Date: 2025-01-30
REM Description: .NET Project Publish Script
REM ===========================================

REM Set initial color to green text on black background
color 0A

REM Title and Intro
echo ===========================================
echo         .NET Project Publish Script
echo ===========================================
echo.

REM Step 1: Automatically get the project name from the .csproj file matching *.Webs in the current directory
echo Searching for a .csproj file with pattern *.Webs...
for /r %%f in (*Webs*.csproj) do (
    set projectName=%%~nf
    goto :foundProject
)

REM Step 2: Handle case where no project file is found
echo.
color 0C
echo No .csproj file found in the directory with the pattern *.Webs.
echo Please ensure the project file is present and try again.
echo ===========================================
pause
exit /b

:foundProject
REM Confirm the project name found
color 0E
echo.
echo ===========================================
echo Found project file: %projectName%
echo ===========================================
echo.

REM Step 3: Ask if user wants to exclude config files
set /p excludeConfig="Do you want to **remove** configuration files (appsettings.json and web.config) from the published output? (y/n): "

REM Step 4: Ask if user wants to zip the published output
set /p choice="Do you want to zip the published output? (y/n): "

REM Step 5: Clean the project
color 0A
echo.
echo ===========================================
echo Cleaning project: %projectName% to remove previous build outputs...
dotnet clean %projectName%\%projectName%.csproj >nul
color 0B
echo Project cleaned successfully.
echo ===========================================
echo.

REM Step 6: Get the current date and time for unique folder naming
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set today=%%c-%%a-%%b
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set currentTime=%%a-%%b

REM Define the output folder path with the date and time
set folderPath=.\publish\%projectName%_%today%_%currentTime%
color 0E
echo Output folder path set to: %folderPath%
echo ===========================================
echo.

REM Step 7: Publish the project
color 0A
echo Publishing project: %projectName% in Release mode...
dotnet publish %projectName%\%projectName%.csproj -c Release -f net6.0 --self-contained false -o %folderPath% >nul
color 0B
echo Project published successfully to: %folderPath%
echo ===========================================
echo.

REM Step 8: Optionally remove config files if selected
if /i "%excludeConfig%"=="y" (
    color 0E
    echo Removing appsettings.json and web.config from the published output...
    del /f /q %folderPath%\appsettings.json
    del /f /q %folderPath%\web.config
    color 0B
    echo Configuration files removed.
    echo ===========================================
) else (
    color 0D
    echo Configuration files retained in the published output.
    echo ===========================================
)
echo.

REM Step 9: Optionally zip the output if selected
if /i "%choice%"=="y" (
    color 0A
    echo Zipping the published output...
    powershell Compress-Archive -Path %folderPath%\* -DestinationPath %folderPath%.zip >nul
    color 0B
    echo Project published and zipped successfully with the name %projectName%_%today%_%currentTime%.zip
    echo ===========================================

    REM Step 10: Clean up the folder after zipping
    color 0E
    echo Removing temporary publish folder...
    rmdir /s /q %folderPath%
    color 0B
    echo Temporary publish folder deleted.
    echo ===========================================
) else (
    color 0A
    echo Project published successfully to the folder: %folderPath%
    echo ===========================================
)
echo.

REM Step 11: Completion message
color 0F
echo Process complete. Thank you for using this script!
echo ===========================================
pause
