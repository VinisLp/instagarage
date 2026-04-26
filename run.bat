@echo off
echo Encerrando processo na porta 58855...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :58855') do (
    taskkill /PID %%a /F 2>nul
)
echo Iniciando InstaCollection...
flutter run -d chrome --web-port=58855