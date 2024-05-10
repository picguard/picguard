#!/bin/sh

set -e

if [[ "$VERCEL_ENV" == "preview" ]] ; then
  echo "🔥Building web app in preview environment"
  flutter/bin/flutter build web --no-tree-shake-icons --dart-define SENTRY_DSN="$PG_ENV_STG" --web-renderer canvaskit
else
  echo "🔥Building web app in production environment"
  flutter/bin/flutter build web --no-tree-shake-icons --dart-define SENTRY_DSN="$PG_ENV_PROD" --web-renderer canvaskit --base-href /picguard/play/
fi

exit 0
