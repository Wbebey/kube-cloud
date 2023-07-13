##!/usr/bin/env bash

function get_environment_properties() {
    BRANCH_NAME=${GITHUB_REF#refs/heads/}
    BRANCH_NAME=${BRANCH_NAME//\//-}

    if [[ ${GITHUB_REF} == refs/heads/main  ]]
    then

        export ENV_NAME="prd"
        export DOPPLER_TOKEN="${TOKEN_PRD_DOPPLER}"
        export BUCKET_NAME="${PRODUCTION_URL}"
        export DOCKER_TAG="gcr.io/${GCP_PROJECT_ID}/${APP}-$ENVIRONMENT:$BRANCH_NAME-${GITHUB_SHA}"
    else
        echo "nothing to do"
    fi
}

function doppler_setup() {
    get_environment_properties
    echo "Setting up Doppler"
    curl --request GET \
     --url "https://api.doppler.com/v3/configs/config/secrets/download?project=${APP}&config=$ENV_NAME&format=env" \
     --header 'accept: application/json' \
     --header "authorization: Bearer $DOPPLER_TOKEN" > .env
}

function export_build_date() {
    echo "Setting build date"
    get_environment_properties
    # export TZ="Europe/Paris"  # set Paris timezone
    export GITHUB_BUILD_DATE=$(date +"%Y-%m-%dT%H:%M:%SZ")
    sed -i "s/${APP_BUILD_DATE}=.*/${APP_BUILD_DATE}=$GITHUB_BUILD_DATE/g" .env
}

function doppler_token() {
    get_environment_properties
    echo "Setting up Doppler"
    # export HISTIGNORE='export DOPPLER_TOKEN*' # ignore this command in history
    export DOPPLER_TOKEN="${DOPPLER_TOKEN}"
}