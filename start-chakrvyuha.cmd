@echo off
set "PROJECT=%~dp0"
set "PYTHON=%PROJECT%backend\.venv\Scripts\python.exe"
if not exist "%PYTHON%" (
  echo Python environment not found: %PYTHON%
  pause
  exit /b 1
)
attrib -R "%PROJECT%backend\chakravyuha.db" 2>nul
attrib -R "%PROJECT%backend" 2>nul
if not exist "%PROJECT%backend\uploads" mkdir "%PROJECT%backend\uploads"
if not exist "%PROJECT%backend\reports" mkdir "%PROJECT%backend\reports"
start "Chakravyuha Backend" /D "%PROJECT%backend" cmd /k "set PYTHONDONTWRITEBYTECODE=1&& set ENVIRONMENT=local&& set UPLOAD_DIR=./uploads&& set REPORT_DIR=./reports&& set ADMIN_EMAIL=admin@chakravyuha.ai&& %PYTHON% -m uvicorn app.main:app --host 127.0.0.1 --port 8000"
timeout /t 8 /nobreak >nul
start "Chakravyuha Frontend" /D "%PROJECT%frontend" cmd /k "%PYTHON% -m http.server 8001 --bind 127.0.0.1"
timeout /t 3 /nobreak >nul
start msedge "http://127.0.0.1:8001/local-dev.html"
