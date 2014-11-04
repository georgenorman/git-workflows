#!/bin/sh
set -e


# ===================================================
# constants
# ===================================================

# project root
export PROJECT_ROOT=~/Projects/git-workflows/generated

# date/time
export DATE=$(date +"%m%d%Y-%H%M")

# ------------------------
# colors
# ------------------------

export red="0;31"
export firebrick="1;31"

export green="1;32"
export lightgreen="0;32"

export blue="0;34"
export lightblue="1;34"

export violet="1;35"

# ------------------------
# content
# ------------------------

# initial contents of the test-1 file
export TEST_1_INITIAL="This, is the first line of the content. This is also tst #1.\n"

# modified contents of the test-1 file
export TEST_1_ENHANCEMENT_1="This, is the first line of the content. This is also tst number one.\n"

# qa fix for the test-1 file
export TEST_1_QA_FIX_1="This is the first line of the content. It's also test number one.\n"

# qa fix for the test-1 file
export TEST_1_QA_FIX_2="This is the first line of content and is test number one.\n"

# initial contents of the test-2 file
export TEST_2_INITIAL="Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.\n"

# additional text for the test-2 file (appended to file as second line)
export TEST_2_ENHANCEMENT_1="Separated, they live inn Bookmarksgrave, right at the coast of the Semantics, a raging language river.\n"

# hot-fix for the test-2 file (replaces second line)
export TEST_2_HOT_FIX_1="Separated, they live in Bookmarksgrove, right at the coast of the Semantics, a large language ocean.\n"

# README contents
export README="This is a sample README file."


# ===================================================
# functions
# ===================================================

# ------------------------
# Echo the given header message ($1) as a level-1 heading.
# ------------------------
function h1 {
  echo ""
  echoWithColor "#########################################################" ${lightblue}
  echoWithColor "$1" ${lightblue}
  echoWithColor "#########################################################" ${lightblue}
}

# ------------------------
# Echo the given header message ($1) as a level-2 heading.
# ------------------------
function h2 {
  echo ""
  echoWithColor "# ==================================" ${lightblue}
  echoWithColor "# $1" ${lightblue}
  echoWithColor "# ==================================" ${lightblue}
}

# ------------------------
# Echo the given header message ($1) as a level-3 heading.
# ------------------------
function h3 {
  echo ""
  echoWithColor "# --------------------" ${lightblue}
  echoWithColor "# $1" ${lightblue}
  echoWithColor "# --------------------" ${lightblue}
}

# ------------------------
# Echo the given header message ($1) as a level-4 heading.
# ------------------------
function h4 {
  echo ""
  echoWithColor "# $1" ${lightblue}
}

# ------------------------
# Echo a command heading ($2), followed by an echo of the command ($1), then execute the command.
# ------------------------
function cmd {
  echo ""

  if [ -n "$2" ]; then
    echoWithColor "# $2" ${lightblue}
  else
    echoWithColor "# execute cmd: $1" ${lightblue}
  fi

  echoWithColor "$ $1" ${violet}
  eval $1
}

# ------------------------
# Echo the given string ($1) with the given color ($2)
# ------------------------
function echoWithColor {
    echo $"\x1B[$2m$1\x1B[0m"
}

# ------------------------
# Create a starter project, consisting of the project directory abd a single README file.
# Note: Can't branch from an empty project - there must be at least one commited file.
# ------------------------
function createStarterProject {
  PROJECT_NAME=$1

  # assert that the project root is valid
  if [[ -z ${PROJECT_ROOT} || ${PROJECT_ROOT} == "" ]]; then
    echo "*** ERROR: PROJECT_ROOT is not defined ***"
    exit -1
  fi

  # assert that the project name is valid
  if [[ -z ${PROJECT_NAME} || ${PROJECT_NAME} == "" ]]; then
    echo "*** ERROR: setupProject's PROJECT_NAME parameter is not defined ***"
    exit -1
  fi

  # create an empty project for the specified project
  h4 "Creating starter project at: ${PROJECT_ROOT}/${PROJECT_NAME}"

  # cd to project root
  cd ${PROJECT_ROOT}

  # start clean, by deleting the project directory
  rm -rf ${PROJECT_NAME}

  # create new project directory
  mkdir ${PROJECT_NAME}

  # cd to project directory
  cd ${PROJECT_NAME}

  # create the README
  cmd 'echo "${README}" > README.txt'  "Create the README file"
}

# ------------------------
# Add files developed during first sprint
# ------------------------
function developPreliminaryProject {
  cmd 'echo "${TEST_1_INITIAL}" > test1.txt'  "Create a new text file (test1.txt) with content"

  mkdir myDir
  cmd 'echo "${TEST_2_INITIAL}" > myDir/test2.txt'  "Create a new text file (test2.txt) with content."
}

# ------------------------
# Apply ENHANCEMENT_1 to the project files
# ------------------------
function applySimpleMod1ToProject {
  cmd 'mv test1.txt testOne.txt'  "Rename test1.txt to testOne.txt"
  cmd 'echo "${TEST_1_ENHANCEMENT_1}" > testOne.txt'  "Modify testOne.txt"
  cmd 'echo "${TEST_2_ENHANCEMENT_1}" >> myDir/test2.txt'  "Modify test2.txt"
}

# ------------------------
# Apply QA_FIX_1 to the project files
# ------------------------
function applyQAFix1ToProject {
  cmd 'echo "${TEST_1_QA_FIX_1}" > testOne.txt'  "Fix the QA-001 issue [verbiage needed another update]"
}

# ------------------------
# Apply HOT_FIX_1 to the project files
# ------------------------
function applyHotFix1ToProject {
  cmd 'echo "${TEST_2_INITIAL}${TEST_2_HOT_FIX_1}" > myDir/test2.txt'  "Fix the SWF1-012 issue [verbiage needed yet another update]"
}

# ------------------------
# Create a starter Git repository (contains a single README)
# ------------------------
function createStarterRepo {
  # Create new repo for project
  cmd "git init"  "Create new repo (with master branch)"

  # Check status.
  cmd "git status" "Check status"

  # add README
  cmd "git add README.txt"  "Add the README file"

  # commit README
  cmd "git commit -m 'Initial commit of README'"  "Commit the README"
}

