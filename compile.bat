@echo off
setlocal enabledelayedexpansion
title thrift - Compile Application

echo ========================================================
echo   thrift -- The Campus Exchange
echo   Compiling Java Application...
echo ========================================================

:: Detect Java Compiler
set JAVAC_CMD=javac
where javac >nul 2>nul
if %errorlevel% neq 0 (
    if defined JAVA_HOME (
        set "JAVAC_CMD=%JAVA_HOME%\bin\javac.exe"
    ) else if exist "C:\Program Files\Java\jdk-27.0.1\bin\javac.exe" (
        set "JAVAC_CMD=C:\Program Files\Java\jdk-27.0.1\bin\javac.exe"
    ) else if exist "C:\Program Files\Java\latest\bin\javac.exe" (
        set "JAVAC_CMD=C:\Program Files\Java\latest\bin\javac.exe"
    ) else (
        echo [ERROR] javac was not found on PATH or in standard Java directories.
        echo Please set JAVA_HOME or add JDK bin to your PATH.
        pause
        exit /b 1
    )
)

echo Using compiler: !JAVAC_CMD!

:: Create bin directory
if not exist "bin" mkdir "bin"

:: Collect all Java source files with forward slashes so javac @argfile works without escape issues
echo Gathering source files...
powershell -NoProfile -Command "Get-ChildItem -Path 'src\main\java' -Filter '*.java' -Recurse | ForEach-Object { '\"' + $_.FullName.Replace('\', '/') + '\"' } | Out-File -Encoding ascii sources.txt"

:: Compile
echo Compiling...
"!JAVAC_CMD!" -encoding UTF-8 -d "bin" -cp "lib\*;bin" @sources.txt

if %errorlevel% equ 0 (
    echo.
    echo ========================================================
    echo   BUILD SUCCESSFUL!
    echo   Compiled classes are in .\bin
    echo.
    echo   Choose how you want to run:
    echo     [1] Desktop GUI App:   run.bat
    echo     [2] Web App (Browser): run-web.bat  (http://localhost:8080)
    echo ========================================================
    if exist sources.txt del sources.txt
) else (
    echo.
    echo [ERROR] Compilation failed. Please check the error messages above.
    if exist sources.txt del sources.txt
    pause
    exit /b 1
)

pause
