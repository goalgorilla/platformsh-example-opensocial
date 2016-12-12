# Open Social Platform.sh trial!#

Template for the Open Social Platform.sh trials.

How to use:

1. Create a new project on Platform.sh
    Configure the project by selecting a name and the necessary resources, etc.
    Make sure to select that you want to import "an existing project".
    You should see instructions to push existing code to platform.

    ````
    git remote add platform [id]@git.[region].platform.sh:[id].git
    git push -u platform master
    ````

2. Clone this repository into a new directory and go to this directory.

3. Change the composer.json file to your liking.
    E.g. change open_social version or add new modules.

4. Run composer install in this directory.

5. Add everything to a new commit, including composer.lock.
    ````
    git add .
    git remote add platform [id]@git.[region].platform.sh:[id].git
    git push -u platform master
    ````

6. Install the site using the UI interface from the project URL on platform.sh

7. Now go and develop this your custom Open Social site.
    Remember you can add custom modules, themes etc by placing this in either html/modules/custom or html/themes/custom.

    The deploy hooks are defined in .platform.app.yaml and may be changed according to your needs.

@TODO: Define how we are going to use configuration management to ensure overrides are not removed.
