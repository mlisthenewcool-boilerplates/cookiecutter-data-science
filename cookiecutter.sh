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
		$2 $1
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
  echo "  -i, --init    Create virtualenv and install cookiecutter"
  echo "  -c, --create  Create a cookiecutter project"
  echo ""
  echo "Example: $0 -i"
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
  -c|--create) CREATE=1; shift;shift;;
  *) usage "Unknown parameter passed: $1"; shift;shift;;
esac; done

VENV="{{cookiecutter}}/venv"

# verify params
if [ -n "${INIT}" ]; then
	dirExistsOrExecFunc "$VENV" "virtualenv"
	messageSuccess "Update pip & install cookiecutter ..."
	"$VENV/bin/python" -m pip install --upgrade pip
	"$VENV/bin/pip" install cookiecutter
fi

# verify params
if [ -n "${CREATE}" ]; then
	"$VENV/bin/python" -m cookiecutter {{cookiecutter}}
fi
