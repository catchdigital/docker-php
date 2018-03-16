# php-fpm
Docker php-fpm image

## Versions
Default PHP version for `latest` will be `7.1`
For local development use versions with the suffix of `-dev` e.g. `7.1.1-dev`

## Variables
 - XDEBUG_ENABLE - If we want to use xdebug change XDEBUG_ENABLE to 1, otherwise set it to 0
 - XDEBUG_REMOTE_CONNECT_BACK - Currently an issue with remote connect back on docker for mac so disable (Set to 0)
 - XDEBUG_HOST - The IP address XDEBUG will connect back on
 - XDEBUG_PORT - The port to listen for xdebug on

## Updating Docker files
*Do not update Dockerfiles directly*. The template files in the root should be edited and then update.sh
should be run in order to update any Dockerfile.

For version specific config, put this in the install.sh root version folder. This will be copied in to the
subfolders when the dockerfiles are updates.