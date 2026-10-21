@echo off
setlocal enabledelayedexpansion
title thrift - Campus Exchange

echo ========================================================
echo   thrift -- The Campus Exchange
echo   Launching Application...
echo ========================================================

:: Detect Java Runtime
set JAVA_CMD=java
where java >nul 2>nul
if %errorlevel% neq 0 (
    if defined JAVA_HOME (
        set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
    ) else if exist "C:\Program Files\Java\jdk-27.0.1\bin\java.exe" (
        set "JAVA_CMD=C:\Program Files\Java\jdk-27.0.1\bin\java.exe"
    ) else if exist "C:\Program Files\Java\latest\bin\java.exe" (
        set "JAVA_CMD=C:\Program Files\Java\latest\bin\java.exe"
    ) else (
        echo [ERROR] java was not found on PATH or in standard Java directories.
        echo Please set JAVA_HOME or add JDK bin to your PATH.
        pause
        exit /b 1
    )
)

echo Using runtime: !JAVA_CMD!

:: Check if compiled classes exist
if not exist "bin\Main.class" (
    echo [INFO] Application not compiled yet. Running compile.bat first...
    call compile.bat
)

:: Run application
"!JAVA_CMD!" -cp "bin;lib\*" Main

if %errorlevel% neq 0 (
    echo.
    echo [INFO] Application exited with code %errorlevel%.
    pause
)
