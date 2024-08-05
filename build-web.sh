#!/bin/sh

set -e

if [[ "$VERCEL_ENV" == "preview" ]] ; then
  echo "🔥Building web app in preview environment"
  flutter/bin/flutter build web --dart-define SENTRY_DSN="$PG_ENV_DEV"
else
  echo "🔥Building web app in production environment"
  echo "VERCEL_GIT_COMMIT_SHA: $VERCEL_GIT_COMMIT_SHA"
  COMMIT_COUNT="$(git rev-list --count $VERCEL_GIT_COMMIT_SHA)"
  echo "COMMIT_COUNT: $COMMIT_COUNT, FLAVOR: $FLAVOR"
  if [[ "$FLAVOR" == "pro" ]] ; then
    echo "🔥Built for pro version"
    flutter/bin/flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --target lib/main_pro.dart --build-number "$COMMIT_COUNT" --base-href /play/pro/
  else
    echo "🔥Built for free version"
    flutter/bin/flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --target lib/main_free.dart --build-number "$COMMIT_COUNT" --base-href /play/
  fi
fi

exit 0
