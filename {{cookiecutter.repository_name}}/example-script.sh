#!/bin/bash

# ==============================================================================
# Standard bash script argparse
# ==============================================================================

# ==============================================================================
# 1) Functions & helpers
# ==============================================================================

CLEAR='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'

function messageError() {
	echo -e "${RED}👉 $1 ${CLEAR}\n"
}

function messageSuccess() {
	echo -e "${GREEN}👉 $1 ${CLEAR}\n"
}

function dirExistsOrExecFunc() {
	if [ ! -d "$1" ]; then
		messageSuccess "$1 doesn't exist, create it ..."
		$2 "$1"
	else
		messageSuccess "$1 does exist."
	fi
}


# define a function to print usage to user
function usage() {
  if [ -n "$1" ]; then
    messageError "$1";
  fi
  echo "Usage: $0 [-i init]"
  echo "  -i, --init    Create virtualenv and install dependencies"
  echo "  -f, --format  Format code using black"
  echo "  -l, --lint    Lint code using pylint"
  echo ""
  echo "Example: $0 -i -f @filenameFormat -l @filenameLint"
  exit 1
}

# ==============================================================================
# 2) Start doing the job
# ==============================================================================

# exit if not param supplied
if [[ $# -eq 0 ]] ; then
	usage "No parameters supplied"
    exit 1
fi


# parse params
while [[ "$#" -gt 0 ]]; do case $1 in
  -i|--init)   INIT=1; shift;shift;;
  -f|--format) FORMAT=1 FORMAT_FILE=$2; shift;shift;;
  -l|--lint)   LINT=1 LINT_FILE=$2; shift;shift;;
  *) usage "Unknown parameter passed: $1"; shift;shift;;
esac; done


# verify params
if [ -n "${INIT}" ]; then
	dirExistsOrExecFunc "venv" "virtualenv"
	messageSuccess "Update pip & install dependencies from requirements.txt ..."
	venv/bin/python -m pip install --upgrade pip
	venv/bin/pip install -r requirements.txt
fi

if [ -n "${FORMAT}" ]; then
	if [ -z "${FORMAT_FILE}" ]; then 
		usage "You must define a file or directory to format";
	else
		venv/bin/black "${FORMAT_FILE}"
	fi
fi

if [ -n "${LINT}" ]; then
	if [ -z "${LINT_FILE}" ]; then 
		usage "You must define a file or directory to lint";
	else
		venv/bin/pylint "${LINT_FILE}"
	fi
fi
