#!/usr/bin/env bash

##
# Instructions
##
# Run this script on your local machine. This will re-install Open Social in a given environment.
##

# platform self-update ?

##########################
# Platform.sh settings.  #
##########################

PROJECT_ID=$1
ENVIRONMENT_ID=$2
VERSION=$3 #TODO Is this necessary? Can we just use nightly instead?

# TODO Break the script when arguments 1,2 (and 3?) are missing.

########################
# Get the environment  #
########################

# TODO ? For enterprise consider this ok, for SAAS consider git upstream merge of another repository instead.

# TODO ? Backup prior to update

platform get $PROJECT_ID $ENVIRONMENT_ID -e $ENVIRONMENT_ID
cd $ENVIRONMENT_ID
composer require goalgorilla/open_social $VERSION
# TODO ? RUN stability tests etc. check if composer command was going well before committing and releasing?
git add composer.json
git add composer.lock
git commit -m "Self-update to version $VERSION"

platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'sset system.maintenance_mode 1'

# DEBUG MODE FOR NOW
git push origin HEAD

platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'sset system.maintenance_mode 0'