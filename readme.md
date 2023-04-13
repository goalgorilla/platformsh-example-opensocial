# Open Social Platform.sh trial!

Template for the Open Social Platform.sh trials.

How to use:

1. Clone this repository into a new directory and enter this directory.

2. Create a new project on Platform.sh and choose "create from scratch"
    Once the project is built, you'll see a step to [set Platform.sh as remote](https://docs.platform.sh/gettingstarted/introduction/own-code/create-project.html)

    ````
    git remote add platform [id]@git.[region].platform.sh:[id].git
    ````
    
    Or if you're using the Platform CLI:
    ````
    platform project:set-remote <project ID>
    ````

3. Change the composer.json file to your liking.
    E.g. change open_social version or add new modules.

4. Commit the changes.
    ````
    git add .
    git commit -m "Customizations"
    git push -u platform master
    ````

6. Install the site using the UI interface from the project URL on platform.sh

7. Now go and develop this your custom Open Social site.
    Remember you can add custom modules, themes etc by placing this in either html/modules/custom or html/themes/custom.

    The deploy hooks are defined in .platform.app.yaml and may be changed according to your needs.

@TODO: Define how we are going to use configuration management to ensure overrides are not removed.
