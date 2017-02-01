#! /bin/bash

set -e

if [ ! -z "$CIRCLE_BRANCH" ]; then
  UPPER_BRANCH=$(echo $CIRCLE_BRANCH | tr '[a-z]' '[A-Z]')
  GRAPHCOOL_PAT_FROM_BRANCH="GRAPHCOOL_PAT_${UPPER_BRANCH}"
  GRAPHCOOL_PAT=${!GRAPHCOOL_PAT_FROM_BRANCH:?$GRAPHCOOL_PAT_FROM_BRANCH env var not set}
fi


BRANCH="${CIRCLE_BRANCH:-dev}"

GRAPHCOOL_PAT="${GRAPHCOOL_PAT:?GRAPHCOOL_PAT env variable not set}"
GRAPHCOOL_PROJECT_ID="${GRAPHCOOL_PROJECT_ID:?GRAPHCOOL_PROJECT_ID env variable not set}"
CIRCLE_TOKEN="${CIRCLE_TOKEN:?CIRCLE_TOKEN env variable not set}"

markdown-to-graphcool -c content --reset 

# trigger rebuild of homepage
curl -X POST https://circleci.com/api/v1.1/project/github/graphcool/homepage/tree/$BRANCH?circle-token=$CIRCLE_TOKEN
