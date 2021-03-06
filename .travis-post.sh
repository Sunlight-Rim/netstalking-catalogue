if [ "${TRAVIS_EVENT_TYPE}" = "push" ] && [ "${TRAVIS_BRANCH}" = "master" ]; then
  
  if git diff --exit-code --quiet ; then
    echo "Nothing to commit"
  else
    # russian version is default
    cp README.ru.md README.md

    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis CI"

    # add localized files
    git add README.*.md

    # add default
    git add README.md

    git commit --message "[ci skip] travis build: ${TRAVIS_BUILD_NUMBER}"

    git push https://vechur:${GH_TOKEN}@github.com/netstalking-core/netstalking-catalogue.git HEAD:master
  fi
fi

if [ "${TRAVIS_EVENT_TYPE}" = "pull_request" ]; then
  for md_file in $(ls -1 README.*.md); do
    diff ${md_file}.pre ${md_file}
  done
fi
