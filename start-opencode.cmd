@echo on
setlocal EnableExtensions EnableDelayedExpansion

echo === OpenCode Portable Bootstrap ===

REM ====== CONFIG ======
set NODE_VERSION=22.18.0
set NODE_DIST=node-v%NODE_VERSION%-win-x64
set NODE_ZIP=%NODE_DIST%.zip
set NODE_URL=https://nodejs.org/dist/v%NODE_VERSION%/%NODE_ZIP%

REM ====== PATHS ======
set ROOT=%~dp0
set DOWNLOADS=%ROOT%downloads
set NODE_DIR=%ROOT%%NODE_DIST%
set NPM_PREFIX=%ROOT%npm-global

set OPENCODE_CONFIG=%ROOT%opencode.json
set OPENCODE_DISABLE_MODELS_FETCH=1

REM ====== PREPARE FOLDERS ======
if not exist "%DOWNLOADS%" mkdir "%DOWNLOADS%"
if not exist "%NPM_PREFIX%" mkdir "%NPM_PREFIX%"

REM ====== NODE.JS ======
if not exist "%NODE_DIR%\node.exe" (
    echo [INFO] Node.js v%NODE_VERSION% not found
    echo [INFO] Downloading from %NODE_URL%

    if not exist "%DOWNLOADS%\%NODE_ZIP%" (
        powershell -NoProfile -Command ^
          "Invoke-WebRequest '%NODE_URL%' -OutFile '%DOWNLOADS%\%NODE_ZIP%'"
        if errorlevel 1 (
            echo [ERROR] Node.js download failed
            pause
            exit /b 1
        )
    )

    echo [INFO] Extracting Node.js...
    powershell -NoProfile -Command ^
      "Expand-Archive -Force '%DOWNLOADS%\%NODE_ZIP%' '%ROOT%'"
    if errorlevel 1 (
        echo [ERROR] Node.js extraction failed
        pause
        exit /b 1
    )
)

REM ====== ENV ======
set PATH=%NODE_DIR%;%NODE_DIR%\node_modules\npm\bin;%NPM_PREFIX%;%PATH%

REM ====== CHECK ======
where node
where npm
node -v
call npm -v

REM ====== NPM PREFIX ======
call npm config set prefix "%NPM_PREFIX%" >nul
call npm config get prefix

REM ====== OPENCODE ======
if not exist "%NPM_PREFIX%\opencode.cmd" (
    echo [INFO] Installing opencode-ai...
    call npm install -g opencode-ai@latest
    if errorlevel 1 (
        echo [ERROR] opencode-ai installation failed
        pause
        exit /b 1
    )
)

REM ====== RUN ======
echo [INFO] Starting OpenCode...
call "%NPM_PREFIX%\opencode.cmd"

echo === DONE ===

