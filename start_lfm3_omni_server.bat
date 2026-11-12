@echo off
setlocal
cd /d "%~dp0"
where llama >nul 2>nul
if errorlevel 1 (
  echo llama.cpp command was not found.
  echo Install the Windows build with:
  echo   winget install llama.cpp
  echo Then close this window, reopen it, and run this file again.
  pause
  exit /b 1
)
echo ============================================================
echo AURIX - LOCAL MULTIMODAL SERVICE
echo Model: LiquidAI/LFM3-Omni-2B-GGUF Q4_K_M
echo Endpoint: http://127.0.0.1:8081/v1
echo First run downloads the model and multimodal projectors.
echo Keep this server bound to localhost on this PC.
echo ============================================================
echo.
llama serve -hf LiquidAI/LFM3-Omni-2B-GGUF:Q4_K_M --reasoning off --temp 0 --port 8081
if errorlevel 1 (
  echo.
  echo The multimodal server stopped with an error. Check the llama.cpp build and model download.
  pause
  exit /b 1
)
