#!/bin/bash

# ============================================================
# CREATOR SCRIPT - MAC / LINUX .SH
# Project: retreat_git_example
#
# This script helps the creator:
#   1. Create the project folder
#   2. Initialize Git
#   3. Make the first commit
#   4. Connect the local repo to GitHub
#   5. Push the first commit
# ============================================================

set -e

# ------------------------------------------------------------
# CHANGE THIS:
# Put your GitHub username here.
# Example:
# GITHUB_USERNAME="adrnmt95"
# ------------------------------------------------------------

GITHUB_USERNAME="YOUR_GITHUB_USERNAME"


# ------------------------------------------------------------
# Project name.
# This will be both:
#   - the local folder name
#   - the GitHub repository name
# ------------------------------------------------------------

PROJECT_NAME="retreat_git_example"


# ------------------------------------------------------------
# GitHub remote URL.
# This assumes you are using HTTPS.
# ------------------------------------------------------------

REMOTE_URL="https://github.com/$GITHUB_USERNAME/$PROJECT_NAME.git"


# ------------------------------------------------------------
# Create the project folder.
# If the folder already exists, the script stops to avoid overwriting.
# ------------------------------------------------------------

if [ -d "$PROJECT_NAME" ]; then
    echo "Folder '$PROJECT_NAME' already exists."
    echo "Delete it, rename it, or move somewhere else before running this script."
    exit 1
fi

mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"


# ------------------------------------------------------------
# Create a basic README.md file.
# README.md is the file GitHub shows on the repository homepage.
# ------------------------------------------------------------

cat > README.md <<EOF
# $PROJECT_NAME

This is an example repository for learning Git collaboration.
EOF


# ------------------------------------------------------------
# Create a basic .gitignore file.
# .gitignore tells Git which files it should ignore.
# ------------------------------------------------------------

cat > .gitignore <<EOF
# System files
.DS_Store
Thumbs.db
EOF


# ------------------------------------------------------------
# Initialize the local Git repository.
# This creates a hidden .git folder and starts tracking the project.
# ------------------------------------------------------------

git init


# ------------------------------------------------------------
# Add all current files to the staging area.
# The staging area is the place where you prepare files for a commit.
# ------------------------------------------------------------

git add .


# ------------------------------------------------------------
# Create the first commit.
# A commit is a snapshot of the project at this point in time.
# ------------------------------------------------------------

git commit -m "Initial commit"


# ------------------------------------------------------------
# Rename the default branch to main.
# Some Git installations still create "master" by default.
# This makes sure we use "main".
# ------------------------------------------------------------

git branch -M main


# ------------------------------------------------------------
# MANUAL STEP ON GITHUB:
#
# 1. Go to GitHub.
# 2. Create a new repository called:
#      retreat_git_example
#
# 3. Important:
#    Do NOT initialize it with:
#      - README
#      - .gitignore
#      - license
#
# We already created those files locally.
#
# After creating the empty repository on GitHub, press ENTER here.
# ------------------------------------------------------------

read -p "Create the empty GitHub repo now, then press ENTER to continue..."


# ------------------------------------------------------------
# Connect the local repository to the GitHub repository.
# "origin" is the conventional name for the main remote repository.
# ------------------------------------------------------------

git remote add origin "$REMOTE_URL"


# ------------------------------------------------------------
# Push the local main branch to GitHub.
# -u sets origin/main as the default remote branch for local main.
# ------------------------------------------------------------

git push -u origin main


# ------------------------------------------------------------
# MANUAL STEP ON GITHUB:
#
# Invite collaborators:
#
# Repository page
# -> Settings
# -> Collaborators / Manage access
# -> Add people
# -> Invite collaborator by username or email
#
# The collaborator must accept the invitation before they can push.
# ------------------------------------------------------------

echo
echo "Repository setup complete."
echo "Now invite collaborators from the GitHub repository settings."
