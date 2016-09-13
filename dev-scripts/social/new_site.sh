#!/usr/bin/env bash

##
# Instructions
##
# Run this script on your local machine. This will create a new environment on platform.sh.
# Like this:
# time sh dev-scripts/social/new_site.sh j4knhg75qxrfe alpha-env-3
#
# Please respect the naming conventions:
# - https://docs.platform.sh/user_guide/overview/environments.html
##

##########################
# Platform.sh settings.  #
##########################

PROJECT_ID=$1
ENVIRONMENT_ID=$2

# First test if the environment is unique for this project.
if platform environment:info -p $PROJECT_ID -e $ENVIRONMENT_ID &>/dev/null
then echo "\nEnvironment ID already exists! Aborting.\n"; exit $?
fi

echo "\nEnvironment does not exist yet. Lets continue.\n"

# Create new environment.
platform environment:branch -p $PROJECT_ID $ENVIRONMENT_ID alpha_template --no

# Lets install the site.
#DIR = `pwd`
#sh DIR/install.sh $PROJECT_ID $ENVIRONMENT_ID
