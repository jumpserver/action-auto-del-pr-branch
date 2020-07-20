#!/bin/bash -eix

PR_ACTION=$(jq -r .action < "${GITHUB_EVENT_PATH}")
if [[ "${PR_ACTION}" != "closed" ]];then
  exit 0
fi

PR_HEAD_REF=$(jq -r .pull_request.head.ref < "${GITHUB_EVENT_PATH}")

if [[ ! "${PR_HEAD_REF}" =~ 'pr_' ]];then
  echo "Not a valid pull request branch, exit"
  exit 0
fi

PR_HEAD_BRANCH_URL=$(jq -r .pull_request.head.repo.git_refs_url < "${GITHUB_EVENT_PATH}" |sed "s@{.*}@/heads/$PR_HEAD_REF@g")

curl \
      --fail \
      -X DELETE \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer ${GITHUB_TOKEN}" \
      "${PR_HEAD_BRANCH_URL}"