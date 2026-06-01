@echo off

REM ============================================================
REM COLLABORATOR SCRIPT - WINDOWS .BAT
REM Project: retreat_git_example
REM
REM This script helps a collaborator:
REM   1. Clone the repository
REM   2. Enter the project folder
REM   3. Update main
REM   4. Create a personal branch
REM   5. Make an example change
REM   6. Commit and push the branch
REM   7. Open a Pull Request manually on GitHub
REM ============================================================


REM ------------------------------------------------------------
REM CHANGE THIS:
REM Put the GitHub username of the repository owner here.
REM Example:
REM set "REPO_OWNER=adrnmt95"
REM ------------------------------------------------------------

set "REPO_OWNER=CREATOR_GITHUB_USERNAME"


REM ------------------------------------------------------------
REM Project name.
REM This must match the GitHub repository name.
REM ------------------------------------------------------------

set "PROJECT_NAME=retreat_git_example"


REM ------------------------------------------------------------
REM Choose your branch name.
REM Do not work directly on main.
REM Use a descriptive name.
REM
REM Examples:
REM   feature/add-homepage
REM   fix/readme-typo
REM   experiment/test-layout
REM ------------------------------------------------------------

set "BRANCH_NAME=feature/my-first-change"


REM ------------------------------------------------------------
REM GitHub remote URL.
REM This assumes you are using HTTPS.
REM ------------------------------------------------------------

set "REMOTE_URL=https://github.com/%REPO_OWNER%/%PROJECT_NAME%.git"


REM ------------------------------------------------------------
REM MANUAL STEP ON GITHUB:
REM
REM Before continuing:
REM
REM 1. The repository owner must invite you as a collaborator.
REM 2. You must accept the invitation by email or on GitHub.
REM
REM If you do not accept the invitation, you may be able to clone
REM a public repository, but you will not be able to push changes.
REM ------------------------------------------------------------

pause


REM ------------------------------------------------------------
REM Clone the repository from GitHub.
REM git clone downloads the project to your computer.
REM ------------------------------------------------------------

if exist "%PROJECT_NAME%" (
    echo Folder "%PROJECT_NAME%" already exists.
    echo The repository may already be cloned.
    echo Delete it, rename it, or move somewhere else before running this script.
    pause
    exit /b
)

git clone "%REMOTE_URL%"


REM ------------------------------------------------------------
REM Enter the project folder.
REM ------------------------------------------------------------

cd "%PROJECT_NAME%"


REM ------------------------------------------------------------
REM Make sure we are on main.
REM main is the stable/default branch.
REM ------------------------------------------------------------

git switch main


REM ------------------------------------------------------------
REM Download the latest version of main.
REM Always do this before starting new work.
REM ------------------------------------------------------------

git pull origin main


REM ------------------------------------------------------------
REM Create your own branch and switch to it.
REM You will do your work here instead of directly on main.
REM ------------------------------------------------------------

git switch -c "%BRANCH_NAME%"


REM ------------------------------------------------------------
REM MAKE YOUR CHANGES.
REM
REM Normally, at this point you would open the project in your editor:
REM VS Code, Cursor, IntelliJ, Eclipse, etc.
REM
REM Example:
REM code .
REM
REM For this tutorial, we create a small example file automatically.
REM You can delete these echo commands if you want to edit manually.
REM ------------------------------------------------------------

echo This is my first collaborator change.> collaborator_notes.txt
echo I am working on branch: %BRANCH_NAME%>> collaborator_notes.txt


REM ------------------------------------------------------------
REM Check what changed.
REM git status shows modified, added, or deleted files.
REM ------------------------------------------------------------

git status


REM ------------------------------------------------------------
REM Add the changed files to the staging area.
REM The dot means: add all changed files.
REM ------------------------------------------------------------

git add .


REM ------------------------------------------------------------
REM Commit your changes.
REM The commit message should explain what you changed.
REM ------------------------------------------------------------

git commit -m "Add collaborator notes"


REM ------------------------------------------------------------
REM Push your branch to GitHub.
REM This does NOT push directly to main.
REM It pushes your personal branch.
REM ------------------------------------------------------------

git push -u origin "%BRANCH_NAME%"


REM ------------------------------------------------------------
REM MANUAL STEP ON GITHUB:
REM
REM Open a Pull Request:
REM
REM 1. Go to the GitHub repository page.
REM 2. GitHub will usually show:
REM      Compare & pull request
REM
REM 3. Open a Pull Request from:
REM      feature/my-first-change
REM
REM    into:
REM      main
REM
REM 4. The repository owner can review and merge your changes.
REM ------------------------------------------------------------

echo.
echo Your branch has been pushed.
echo Now open a Pull Request on GitHub.
pause
