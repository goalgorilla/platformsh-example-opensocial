#!/usr/bin/env bash

# Parse YAML, see: http://stackoverflow.com/a/21189044
function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

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


    ##########################
    # Social site settings.  #
    ##########################

    eval $(parse_yaml .social.settings.yml "CONFIG_")


    #########################
    # Lets do a re-install  #
    #########################

    # TODO This might not be necessary if we have a working basic master environment.
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'si social'


    ###############################
    # Lets generate demo content  #
    ###############################

    # TODO Check for CONFIG_DEMO_CONTENT.
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'pm-enable social_demo'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'cc drush'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'sda file user group topic event eventenrollment post comment'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'pm-uninstall social_demo'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'queue-run activity_logger_message'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'queue-run activity_creator_logger'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'queue-run activity_creator_activities'
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes 'php-eval "node_access_rebuild()"'


    ######################################################
    # Lets set some social site settings during install  #
    ######################################################

    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes "config-set system.site name '$CONFIG_site_name'"
    platform drush -p $PROJECT_ID -e $ENVIRONMENT_ID --yes "config-set system.site mail $CONFIG_site_mail"

  fi
