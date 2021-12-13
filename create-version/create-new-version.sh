#!/bin/bash
###### 🌏 ###### 💬 ######
# All my public-accessible Software-Content aren't underlying any Software-License. It's Free-Software.
# You can use my Code as you want — my only Wish is: mark me as Original-Creator of your Derivation. But you mustn't. :)
#
# My Intention of creating/publishing Free-Software is to help our Public Society.
# In this particular Case our newly-created "Computer-World". I mean everything regarding complex IT-Systems.
#
# made with ❤ by Jeremy Krüger (jkr.one). 😊
###### 🌏 ###### 💬 ######
# Variables.
readonly LOG_PREFIX='[Versioning- and Deployment-System: Version-Creation]: '

readonly GIT_REPOSITORY_URL_WITH_CREDENTIALS=${1}

readonly NEW_VERSION="$("${PWD}/versioning-and-deployment-system/create-version/subscripts/create-new-version/determine-new-version.sh")"
readonly BRANCH_FOR_NEW_VERSION="new-version_${NEW_VERSION}"
readonly COMMIT_MESSAGE_FOR_NEW_VERSION="[Versioning- and Deployment-System] set new Version of Software-Project: \"${NEW_VERSION}\"."

# Procedures.
if [[ -z ${GIT_REPOSITORY_URL_WITH_CREDENTIALS} ]]; then
  echo "You must specify an Repository-URL (with Authorization) for the Git-Origin/Destination."
  exit 1
fi

echo "${LOG_PREFIX}Start Creating new Version (\"${NEW_VERSION}\") on new Branch: \"${BRANCH_FOR_NEW_VERSION}\"."

git fetch origin

"${BASH_SOURCE%/*}/../common-subscripts/git/setup-repository-config.sh" "${GIT_REPOSITORY_URL_WITH_CREDENTIALS}"

"${BASH_SOURCE%/*}/subscripts/create-new-version/set-new-maven-version.sh" "${NEW_VERSION}"

"${BASH_SOURCE%/*}/subscripts/git-tools/commit-current-workspace-and-tag-commit.sh" "${COMMIT_MESSAGE_FOR_NEW_VERSION}" "${NEW_VERSION}"

"${BASH_SOURCE%/*}/subscripts/git-tools/push-current-workspace.sh" "${BRANCH_FOR_NEW_VERSION}"

echo "${LOG_PREFIX}Created new Version of Software-Project on Branch \"${BRANCH_FOR_NEW_VERSION}\": \"${NEW_VERSION}\"."
