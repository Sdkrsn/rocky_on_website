@echo off
REM Quick Netlify Deployment Helper for Rocky Website
REM This script helps you prepare and deploy to Netlify

echo.
echo ============================================
echo  ROCKY NETLIFY DEPLOYMENT HELPER
echo ============================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed!
    echo Please install Git from https://git-scm.com
    pause
    exit /b 1
)

REM Check if node/npm is installed (for Netlify CLI)
npm --version >nul 2>&1
if errorlevel 1 (
    echo WARNING: npm is not installed!
    echo You can still deploy using the Netlify Dashboard.
    echo To use Netlify CLI, install from https://nodejs.org
    echo.
) else (
    echo ✓ npm found
    echo.
)

REM Menu
:menu
cls
echo.
echo ============================================
echo  ROCKY NETLIFY DEPLOYMENT OPTIONS
echo ============================================
echo.
echo 1. Check Git status
echo 2. Push to GitHub (requires git remote)
echo 3. Install Netlify CLI
echo 4. Deploy with Netlify CLI
echo 5. View Deployment Guide
echo 6. Setup Environment Variables
echo 7. Exit
echo.
set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" goto check_git
if "%choice%"=="2" goto push_github
if "%choice%"=="3" goto install_netlify
if "%choice%"=="4" goto deploy_netlify
if "%choice%"=="5" goto view_guide
if "%choice%"=="6" goto setup_env
if "%choice%"=="7" exit /b 0

echo Invalid choice. Please try again.
pause
goto menu

:check_git
cls
echo.
echo ============ GIT STATUS ============
echo.
git status
echo.
pause
goto menu

:push_github
cls
echo.
echo ========== PUSH TO GITHUB ==========
echo.
echo Make sure you have:
echo 1. Created a repository on GitHub
echo 2. Added remote: git remote add origin https://github.com/USERNAME/REPO.git
echo.
echo Pushing to main branch...
echo.
git add .
git commit -m "Setup Rocky for Netlify deployment"
git push -u origin main
echo.
pause
goto menu

:install_netlify
cls
echo.
echo ===== INSTALLING NETLIFY CLI =====
echo.
echo This requires npm. Installing netlify-cli...
echo.
npm install -g netlify-cli
echo.
if errorlevel 1 (
    echo ERROR: Failed to install Netlify CLI
) else (
    echo ✓ Netlify CLI installed successfully!
)
echo.
pause
goto menu

:deploy_netlify
cls
echo.
echo ======== NETLIFY DEPLOYMENT ========
echo.
echo Checking for Netlify CLI...
netlify --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Netlify CLI not found. Please install it first.
    pause
    goto menu
)
echo.
echo Netlify CLI found. Follow these steps:
echo.
echo 1. Enter "netlify login" in your terminal
echo 2. Log in with your GitHub account
echo 3. Select or create a new site
echo 4. Deploy with "netlify deploy --prod"
echo.
echo Opening Netlify CLI...
echo.
netlify login
echo.
pause
goto menu

:view_guide
cls
echo.
echo ===== DEPLOYMENT GUIDE =====
echo.
echo Opening NETLIFY_DEPLOYMENT.md...
echo.
if exist NETLIFY_DEPLOYMENT.md (
    start notepad NETLIFY_DEPLOYMENT.md
) else (
    echo ERROR: NETLIFY_DEPLOYMENT.md not found
)
echo.
pause
goto menu

:setup_env
cls
echo.
echo ====== SETUP ENVIRONMENT VARIABLES ======
echo.
echo Your app needs these environment variables on Netlify:
echo.
echo GEMINI_API_KEY = your-google-gemini-api-key
echo.
echo Steps to add on Netlify:
echo 1. Go to https://app.netlify.com
echo 2. Select your site
echo 3. Site Settings ^> Build ^& Deploy ^> Environment
echo 4. Click "Edit variables"
echo 5. Add: GEMINI_API_KEY = your-key-here
echo 6. Trigger rebuild
echo.
echo To get GEMINI_API_KEY:
echo - Visit https://aistudio.google.com
echo - Create an API key
echo - Copy and paste into Netlify environment variables
echo.
pause
goto menu
