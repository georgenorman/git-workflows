#!/bin/sh
set -e

PROJECT_NAME="single-branch-workflow"

# Include the common support script
#   see: http://stackoverflow.com/questions/192292/bash-how-best-to-include-other-scripts
MY_DIR="$(dirname "$0")"
. $MY_DIR/common/support.sh


# ############################################################
h1 "# Single Branch Workflow (SBWF)
#   - All development occurs on master branch"
# ############################################################


# =================================
h2 "Setup"
# =================================

# Create a starter project (consisting of the project directory and a README.txt file).
createStarterProject  ${PROJECT_NAME}


# Create a new repo for the project, then check its status.
createStarterRepo


# =================================
h2 "First Sprint: Generate some project files, add them to the index (aka staging area) and commit them to the master branch"
# =================================

# Generate files developed for first sprint
developPreliminaryProject

# Check status.
cmd "git status --short" "Check status (all files should be unknown to git)"

# Add files to staging area
cmd "git add test1.txt  myDir/test2.txt"  "Add files to staging area"

# Check status.
cmd "git status --short" "Check status (files should now be staged and ready for commit)"

# Commit files (in the staging area) to the repo.
cmd "git commit -m 'Initial commit for SBWF1-001 feature [Lorem Ipsum and friends]'" "Commit the staged changes to the repo"

# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"


# =================================
h2 "Second Sprint: Implement enhancements, then add them to the staging area and commit them to the master branch"
# =================================

# Modifiy the project by applying the SIMPLE_MOD_1 changes
applySimpleMod1ToProject

# Check status.
cmd "git status --short" "Check status (files should reflect their modified state - purple)"

# Show diffs (before adding to staging area).
cmd "git diff"  "Show diffs"

# Add changes to staging area
cmd "git add --all test1.txt  testOne.txt  myDir/test2.txt"  "Add changes to staging area"

# Check status.
cmd "git status --short"  "Check status (files should now be staged and ready for commit)"

# Commit changes (that are in the staging area) to the repo.
cmd "git commit -m 'Implement SBWF1-003 enhancement [Verbiage changes to cutomer facing text files]'" "Commit the staged changes to the repo (master branch)"

# View commit logs.
cmd "git log --oneline"  "View commit logs"

# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"


# =================================
h2 "Code complete: Tag the release for QA"
# =================================

cmd "git tag 1.0.0-RC001"  "Tag the HEAD"
cmd "git show 1.0.0-RC001"  "Show the tag details"


# =================================
h2 "Fix QA issue(s)"
# =================================

# Apply QA_FIX_1 to the project files
applyQAFix1ToProject

# Check status.
cmd "git status --short" "Check status"

# Show diffs (before adding to staging area).
cmd "git diff"  "Show diffs"

# Add changes to staging area
cmd "git add testOne.txt"  "Add changes to staging area"

# Check status.
cmd "git status --short"  "Check status"

# Commit changes (that are in the staging area) to the repo.
cmd "git commit -m 'Fix SBWF1-005 issue [verbiage needed another update]'" "Commit the staged changes to the repo"

# View commit logs.
cmd "git log --oneline"  "View commit logs"

# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"


# =================================
h2 "Project Complete: Prepare to deploy to PRD. Tag the final release 1.0.0"
# =================================

cmd "git tag 1.0.0"  "Tag the HEAD"
cmd "git show 1.0.0"  "Show the tag details"


# =================================
h2 "Fix production issue(s)"
# =================================

# Apply HOT_FIX_1 to the project files
applyHotFix1ToProject

# Check status.
cmd "git status --short" "Check status"

# Show diffs (before adding to staging area).
cmd "git diff"  "Show diffs"

# Add changes to staging area
cmd "git add myDir/test2.txt"  "Add changes to staging area"

# Check status.
cmd "git status --short"  "Check status"


# Commit changes (that are in the staging area) to the repo.
cmd "git commit -m 'Fix SBWF1-009 issue [verbiage needed yet another update]'" "Commit the staged changes to the repo"


# View commit logs.
cmd "git log --oneline"  "View commit logs"


# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"


# =================================
h2 "Project Complete: Prepare to deploy to PRD. Tag the final release 1.0.1"
# =================================

cmd "git tag 1.0.1" "Tag the HEAD"
cmd "git show 1.0.1"  "Show the tag details"



