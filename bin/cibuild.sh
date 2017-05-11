#!/usr/bin/env bash

# Exit immediately if there is an error
set -e

# cause a pipeline (for example, curl -s http://sipb.mit.edu/ | grep foo) to produce a failure
# return code if any command errors not just the last command of the pipeline.
set -o pipefail

# echo out each line of the shell as it executes
set -x

# import common build env vars
source "$(dirname "$0")/buildrc"

main() {

  git submodule init                                                    # Pulling submodule
  git submodule update                                                  # Updating submodule

  case "${CIRCLE_BRANCH}" in
    master)
      bundle exec jekyll build --destination ./_site/content-guide --baseurl ${SITE_BASEURL}
      ;;
    *)
      bundle exec jekyll build --destination ${DESTINATION}/ --baseurl "${SITE_BASEURL}"
      ;;
  esac

  bundle exec jekyll build --destination ${DESTINATION}/ --baseurl "${SITE_BASEURL}"

}

main $@
