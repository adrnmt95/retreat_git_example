@echo off

REM ============================================================
REM CREATOR SCRIPT - WINDOWS .BAT
REM Project: retreat_git_example
REM
REM This script helps the creator:
REM   1. Create the project folder
REM   2. Initialize Git
REM   3. Make the first commit
REM   4. Connect the local repo to GitHub
REM   5. Push the first commit
REM ============================================================


REM ------------------------------------------------------------
REM CHANGE THIS:
REM Put your GitHub username here.
REM Example:
REM set "GITHUB_USERNAME=adrnmt95"
REM ------------------------------------------------------------

set "GITHUB_USERNAME=YOUR_GITHUB_USERNAME"


REM ------------------------------------------------------------
REM Project name.
REM This will be both:
REM   - the local folder name
REM   - the GitHub repository name
REM ------------------------------------------------------------

set "PROJECT_NAME=retreat_git_example"


REM ------------------------------------------------------------
REM GitHub remote URL.
REM This assumes you are using HTTPS.
REM ------------------------------------------------------------

set "REMOTE_URL=https://github.com/%GITHUB_USERNAME%/%PROJECT_NAME%.git"


REM ------------------------------------------------------------
REM Create the project folder.
REM If the folder already exists, the script stops to avoid overwriting.
REM ------------------------------------------------------------

if exist "%PROJECT_NAME%" (
    echo Folder "%PROJECT_NAME%" already exists.
    echo Delete it, rename it, or move somewhere else before running this script.
    pause
    exit /b
)

mkdir "%PROJECT_NAME%"
cd "%PROJECT_NAME%"


REM ------------------------------------------------------------
REM Create a basic README.md file.
REM README.md is the file GitHub shows on the repository homepage.
REM ------------------------------------------------------------

echo # %PROJECT_NAME%> README.md
echo.>> README.md
echo This is an example repository for learning Git collaboration.>> README.md


REM ------------------------------------------------------------
REM Create a basic .gitignore file.
REM .gitignore tells Git which files it should ignore.
REM ------------------------------------------------------------

echo # System files> .gitignore
echo .DS_Store>> .gitignore
echo Thumbs.db>> .gitignore


REM ------------------------------------------------------------
REM Initialize the local Git repository.
REM This creates a hidden .git folder and starts tracking the project.
REM ------------------------------------------------------------

git init


REM ------------------------------------------------------------
REM Add all current files to the staging area.
REM The staging area is the place where you prepare files for a commit.
REM ------------------------------------------------------------

git add .


REM ------------------------------------------------------------
REM Create the first commit.
REM A commit is a snapshot of the project at this point in time.
REM ------------------------------------------------------------

git commit -m "Initial commit"


REM ------------------------------------------------------------
REM Rename the default branch to main.
REM Some Git installations still create "master" by default.
REM This makes sure we use "main".
REM ------------------------------------------------------------

git branch -M main


REM ------------------------------------------------------------
REM MANUAL STEP ON GITHUB:
REM
REM 1. Go to GitHub.
REM 2. Create a new repository called:
REM      retreat_git_example
REM
REM 3. Important:
REM    Do NOT initialize it with:
REM      - README
REM      - .gitignore
REM      - license
REM
REM We already created those files locally.
REM
REM After creating the empty repository on GitHub, come back here.
REM ------------------------------------------------------------

pause


REM ------------------------------------------------------------
REM Connect the local repository to the GitHub repository.
REM "origin" is the conventional name for the main remote repository.
REM ------------------------------------------------------------

git remote add origin "%REMOTE_URL%"


REM ------------------------------------------------------------
REM Push the local main branch to GitHub.
REM -u sets origin/main as the default remote branch for local main.
REM ------------------------------------------------------------

git push -u origin main


REM ------------------------------------------------------------
REM MANUAL STEP ON GITHUB:
REM
REM Invite collaborators:
REM
REM Repository page
REM -> Settings
REM -> Collaborators / Manage access
REM -> Add people
REM -> Invite collaborator by username or email
REM
REM The collaborator must accept the invitation before they can push.
REM ------------------------------------------------------------

echo.
echo Repository setup complete.
echo Now invite collaborators from the GitHub repository settings.
pause
