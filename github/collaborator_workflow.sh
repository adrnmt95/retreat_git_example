#!/bin/bash

# ============================================================
# COLLABORATOR SCRIPT - MAC / LINUX .SH
# Project: retreat_git_example
#
# This script helps a collaborator:
#   1. Clone the repository
#   2. Enter the project folder
#   3. Update main
#   4. Create a personal branch
#   5. Make an example change
#   6. Commit and push the branch
#   7. Open a Pull Request manually on GitHub
# ============================================================

set -e

# ------------------------------------------------------------
# CHANGE THIS:
# Put the GitHub username of the repository owner here.
# Example:
# REPO_OWNER="adrnmt95"
# ------------------------------------------------------------

REPO_OWNER="CREATOR_GITHUB_USERNAME"


# ------------------------------------------------------------
# Project name.
# This must match the GitHub repository name.
# ------------------------------------------------------------

PROJECT_NAME="retreat_git_example"


# ------------------------------------------------------------
# Choose your branch name.
# Do not work directly on main.
# Use a descriptive name.
#
# Examples:
#   feature/add-homepage
#   fix/readme-typo
#   experiment/test-layout
# ------------------------------------------------------------

BRANCH_NAME="feature/my-first-change"


# ------------------------------------------------------------
# GitHub remote URL.
# This assumes you are using HTTPS.
# ------------------------------------------------------------

REMOTE_URL="https://github.com/$REPO_OWNER/$PROJECT_NAME.git"


# ------------------------------------------------------------
# MANUAL STEP ON GITHUB:
#
# Before continuing:
#
# 1. The repository owner must invite you as a collaborator.
# 2. You must accept the invitation by email or on GitHub.
#
# If you do not accept the invitation, you may be able to clone
# a public repository, but you will not be able to push changes.
# ------------------------------------------------------------

read -p "Accept the GitHub collaborator invitation, then press ENTER to continue..."


# ------------------------------------------------------------
# Clone the repository from GitHub.
# git clone downloads the project to your computer.
# ------------------------------------------------------------

if [ -d "$PROJECT_NAME" ]; then
    echo "Folder '$PROJECT_NAME' already exists."
    echo "The repository may already be cloned."
    echo "Delete it, rename it, or move somewhere else before running this script."
    exit 1
fi

git clone "$REMOTE_URL"


# ------------------------------------------------------------
# Enter the project folder.
# ------------------------------------------------------------

cd "$PROJECT_NAME"


# ------------------------------------------------------------
# Make sure we are on main.
# main is the stable/default branch.
# ------------------------------------------------------------

git switch main


# ------------------------------------------------------------
# Download the latest version of main.
# Always do this before starting new work.
# ------------------------------------------------------------

git pull origin main


# ------------------------------------------------------------
# Create your own branch and switch to it.
# You will do your work here instead of directly on main.
# ------------------------------------------------------------

git switch -c "$BRANCH_NAME"


# ------------------------------------------------------------
# MAKE YOUR CHANGES.
#
# Normally, at this point you would open the project in your editor:
# VS Code, Cursor, IntelliJ, Eclipse, etc.
#
# Example:
# code .
#
# For this tutorial, we create a small example file automatically.
# You can delete these echo commands if you want to edit manually.
# ------------------------------------------------------------

echo "This is my first collaborator change." > collaborator_notes.txt
echo "I am working on branch: $BRANCH_NAME" >> collaborator_notes.txt


# ------------------------------------------------------------
# Check what changed.
# git status shows modified, added, or deleted files.
# ------------------------------------------------------------

git status


# ------------------------------------------------------------
# Add the changed files to the staging area.
# The dot means: add all changed files.
# ------------------------------------------------------------

git add .


# ------------------------------------------------------------
# Commit your changes.
# The commit message should explain what you changed.
# ------------------------------------------------------------

git commit -m "Add collaborator notes"


# ------------------------------------------------------------
# Push your branch to GitHub.
# This does NOT push directly to main.
# It pushes your personal branch.
# ------------------------------------------------------------

git push -u origin "$BRANCH_NAME"


# ------------------------------------------------------------
# MANUAL STEP ON GITHUB:
#
# Open a Pull Request:
#
# 1. Go to the GitHub repository page.
# 2. GitHub will usually show:
#      Compare & pull request
#
# 3. Open a Pull Request from:
#      feature/my-first-change
#
#    into:
#      main
#
# 4. The repository owner can review and merge your changes.
# ------------------------------------------------------------

echo
echo "Your branch has been pushed."
echo "Now open a Pull Request on GitHub."
