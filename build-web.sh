#!/bin/sh

set -e

commit_sha="$VERCEL_GIT_COMMIT_SHA"
echo "${commit_sha:0:8}"

if [[ "$VERCEL_ENV" == "preview" ]] ; then
  echo "🔥Building web app in preview environment"
  flutter/bin/flutter build web --no-tree-shake-icons --dart-define SENTRY_DSN="$PG_ENV_STG" --build-number "${commit_sha:0:8}" --web-renderer canvaskit
else
  echo "🔥Building web app in production environment"
  flutter/bin/flutter build web --no-tree-shake-icons --dart-define SENTRY_DSN="$PG_ENV_PROD" --build-number "${commit_sha:0:8}" --web-renderer canvaskit
fi

exit 0
