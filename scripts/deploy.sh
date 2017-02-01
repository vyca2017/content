#! /bin/bash

set -e

markdown-to-graphcool -c content --reset 

# trigger rebuild of homepage
curl -X POST https://circleci.com/api/v1.1/project/github/graphcool/homepage/tree/$CIRCLE_BRANCH
