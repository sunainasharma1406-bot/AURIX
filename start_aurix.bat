@echo off
setlocal
cd /d "%~dp0"
where py >nul 2>nul
if errorlevel 1 (
  echo Python Launcher not found. Install Python 3.11 or later from python.org and enable the launcher.
  pause
  exit /b 1
)
if not exist ".venv\Scripts\python.exe" (
  echo Creating AURIX virtual environment...
  py -3 -m venv .venv
  if errorlevel 1 goto :error
)
".venv\Scripts\python.exe" -c "import PySide6, requests, bs4, psutil" >nul 2>nul
if errorlevel 1 (
  echo Installing core AURIX dependencies for the first time...
  ".venv\Scripts\python.exe" -m pip install --disable-pip-version-check -r requirements.txt
  if errorlevel 1 goto :error
)
echo Launching AURIX v6...
".venv\Scripts\python.exe" main.py
if errorlevel 1 goto :error
exit /b 0
:error
echo.
echo AURIX could not start. Read the error above, then check README.md.
pause
exit /b 1
