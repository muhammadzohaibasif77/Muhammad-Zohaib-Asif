@echo off
title Smart Healthcare SPM - Launcher
color 0A
cls

echo.
echo  ============================================================
echo    Smart Healthcare SPM - Project Management System
echo  ============================================================
echo.
echo  [*] Starting application, please wait...
echo.

:: Set project paths
set "ROOT_DIR=%~dp0"
set "APP_DIR=%ROOT_DIR%SmartHealthcareSPM"
set "VENV_PYTHON=%APP_DIR%\venv\Scripts\python.exe"
set "BUNDLED_PYTHON=%ROOT_DIR%python311\python.exe"

:: -------------------------------------------------------
:: Find a working Python executable (priority order)
:: -------------------------------------------------------
set "PYTHON_EXE="

:: 1. Try the local venv
if exist "%VENV_PYTHON%" (
    "%VENV_PYTHON%" --version >nul 2>&1
    if not errorlevel 1 (
        set "PYTHON_EXE=%VENV_PYTHON%"
        echo  [+] Using virtual environment Python
        goto :found_python
    )
)

:: 2. Try bundled python311
if exist "%BUNDLED_PYTHON%" (
    "%BUNDLED_PYTHON%" --version >nul 2>&1
    if not errorlevel 1 (
        set "PYTHON_EXE=%BUNDLED_PYTHON%"
        echo  [+] Using bundled Python 3.11
        goto :found_python
    )
)

:: 3. Try system Python
where python >nul 2>&1
if not errorlevel 1 (
    set "PYTHON_EXE=python"
    echo  [+] Using system Python
    goto :found_python
)

:: 4. Try py launcher
where py >nul 2>&1
if not errorlevel 1 (
    set "PYTHON_EXE=py"
    echo  [+] Using Python Launcher (py)
    goto :found_python
)

:: No Python found
echo.
echo  [!] ERROR: No Python installation found!
echo.
echo  Please install Python 3.11 from https://www.python.org/downloads/
echo  or ensure the bundled python311 folder is present.
echo.
pause
exit /b 1

:found_python
echo.
echo  [*] Launching Flask server on http://127.0.0.1:5000
echo.

:: -------------------------------------------------------
:: Start the browser after a short delay (2 seconds)
:: -------------------------------------------------------
start "" cmd /c "timeout /t 2 /nobreak >nul && start http://127.0.0.1:5000"

:: -------------------------------------------------------
:: Run the Flask app
:: -------------------------------------------------------
cd /d "%APP_DIR%"

:: If using venv, run directly. Otherwise check for flask module
if "%PYTHON_EXE%"=="%VENV_PYTHON%" (
    "%PYTHON_EXE%" app.py
) else if "%PYTHON_EXE%"=="%BUNDLED_PYTHON%" (
    "%PYTHON_EXE%" app.py
) else (
    "%PYTHON_EXE%" app.py
)

:: -------------------------------------------------------
:: App stopped or crashed
:: -------------------------------------------------------
echo.
echo  [!] The application has stopped.
echo.
pause
