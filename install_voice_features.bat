@echo off
setlocal
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  echo First run start_aurix.bat to create the AURIX virtual environment.
  pause
  exit /b 1
)
echo Installing optional offline voice components...
".venv\Scripts\python.exe" -m pip install --disable-pip-version-check -r requirements-voice.txt
if errorlevel 1 goto :error
echo.
echo Voice components installed. Next run download_voice_model.ps1 to get the offline speech model.
echo Wake-word mode also needs a compatible ONNX model selected in Configuration.
pause
exit /b 0
:error
echo Voice feature installation failed. Check the error above.
pause
exit /b 1
