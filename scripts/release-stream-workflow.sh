#!/bin/sh
set -e

PROJECT_NAME="release-stream-workflow"

# Include the common support script
#   see: http://stackoverflow.com/questions/192292/bash-how-best-to-include-other-scripts
MY_DIR="$(dirname "$0")"
. $MY_DIR/common/support.sh


# ############################################################
h1 "# Release-Stream Workflow with Feature Branches (RSWF):
#   * Each release has its own stream of branches and multiple releases can be developed concurrently.
#   * A release stream consists of a stream of branches for a particular release."
# ############################################################


# =================================
h2 "Setup"
# =================================

# Create a starter project (consisting of the project directory and a README.txt file).
createStarterProject  ${PROJECT_NAME}


# Create a new repo for the project, then check its status.
createStarterRepo


# =================================
h2 "Create the release branch, for the 'R-1.0.0' stream (containing only the README)"
# =================================

# Branch is created, HEAD remains at master
cmd "git branch 'R-1.0.0-SNAPSHOT'"  "Create the 'R-1.0.0-SNAPSHOT' branch from the master branch"

cmd "git branch"  "List all branches"

# =================================
# @-@:p0 TODO: Make separate "feature" branches for all features in this sprint (and merge back into R-1.0.0-SNAPSHOT)
h2 "First Sprint: Generate some project files, add them to the index (aka staging area) and commit them to the development branch"
# =================================

# Develop on the 'R-1.0.0-SNAPSHOT' branch
cmd "git checkout 'R-1.0.0-SNAPSHOT'"  "Develop on the 'R-1.0.0-SNAPSHOT' branch"

# Generate files developed for first sprint
developPreliminaryProject

# Check status.
cmd "git status --short" "Check status (all files should be unknown to git)"

# Add files to staging area
cmd "git add test1.txt  myDir/test2.txt"  "Add files to staging area"

# Check status.
cmd "git status --short" "Check status (files should now be staged and ready for commit)"

# Commit files (in the staging area) to the repo.
cmd "git commit -m 'Initial commit for RSWF-001 feature [Lorem Ipsum and friends]'" "Commit the staged changes to the repo"

# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"

# =================================
# @-@:p0 TODO: Make separate "feature" branches for all features in this sprint (and merge back into R-1.0.0-SNAPSHOT)
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
cmd "git commit -m 'Implement RSWF-003 enhancement [Verbiage changes to cutomer facing text files]'" "Commit the staged changes to the repo (master branch)"

# View commit logs.
cmd "git log --oneline"  "View commit logs"

# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"



# =================================
h2 "Code complete: Create the release canidate branch (R-1.0.0-RC001) from the 'R-1.0.0-SNAPSHOT' branch"
# =================================

cmd "git branch 'R-1.0.0-RC001'"  "Create the 'R-1.0.0-RC001' branch from 'R-1.0.0-SNAPSHOT'"

cmd "git branch"  "List all branches"



# =================================
h2 "Fix QA issue(s)"
# =================================

# Develop on the 'R-1.0.0-RC001' branch
cmd "git checkout 'R-1.0.0-RC001'"  "Develop on the 'R-1.0.0-RC001' branch"

# @-@:p0 TODO: Make separate "bugfix" branches for all fixes of this cycle (and merge back into R-1.0.0-RC001)
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
cmd "git commit -m 'Fix RSWF-005 issue [another verbiage change]'" "Commit the staged changes to the repo"

# View commit logs.
cmd "git log --oneline"  "View commit logs"

# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"

exit -1

# =================================
h2 "Project Complete: Create the final release branch (R-1.0.0) from the release candidate (R-1.0.0-RC001)"
# =================================

cmd "git branch 'R-1.0.0'"  "Create the final release branch (R-1.0.0)"

cmd "git branch"  "List all branches"

cmd "git checkout 'R-1.0.0'"  "Tag the 'R-1.0.0' branch"

cmd "git status"


cmd "git tag 1.0.0"  "Tag the HEAD"
cmd "git show 1.0.0"  "Show the tag details"


# =================================
h2 "Fix production issue(s)"
# =================================


cmd "git branch 'R-1.0.1'"  "Create the patch release branch (R-1.0.1)"

cmd "git branch"  "List all branches"

# Develop on the 'R-1.0.1' branch
cmd "git checkout 'R-1.0.0-RC001'"  "Develop on the 'R-1.0.1' branch"


# @-@:p0 TODO: Make separate "hotfix" branches for all fixes of this cycle (and merge back into R-1.0.1-SNAPSHOT/RC001)
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
cmd "git commit -m 'Fix RSWF-009 issue [verbiage needed yet another update]'" "Commit the staged changes to the repo"


# View commit logs.
cmd "git log --oneline"  "View commit logs"


# Check status.
cmd "git status"  "Check status (all changes have been addressed - working directory should now be clean)"


# =================================
h2 "Project Complete: Tag the final patch release branch (R-1.0.1)"
# =================================

cmd "git tag 'R-1.0.1'" "Tag the HEAD"
cmd "git show 'R-1.0.1'"  "Show the tag details"

