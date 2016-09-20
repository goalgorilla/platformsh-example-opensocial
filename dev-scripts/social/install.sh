#!/usr/bin/env bash

# Prompt for a YES.
read -p "You will lose any existing data. Are you sure you want to (re-)install the site? [Y/n]:" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
  then

    ##
    # Instructions
    ##
    # Run this script on your local machine. This will re-install Open Social in a given environment.
    ##

    ##########################
    # Platform.sh settings.  #
    ##########################

    PROJECT_ID=$1
    ENVIRONMENT_ID=$2

    #########################
    # Lets do a re-install  #
    #########################

    # TODO This might not be necessary if we have a working basic master environment.
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'si social'

    ###############################
    # Lets generate demo content  #
    ###############################

    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'pm-enable social_demo'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'cc drush'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'sda file user group topic event eventenrollment post comment'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'pm-uninstall social_demo'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'queue-run activity_logger_message'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'queue-run activity_creator_logger'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'queue-run activity_creator_activities'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'php-eval "node_access_rebuild()"'

  fi
