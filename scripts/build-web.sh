#!/usr/bin/env sh

set -e

echo "VERCEL_GIT_COMMIT_SHA: $VERCEL_GIT_COMMIT_SHA"

if [[ "$VERCEL_ENV" == "preview" ]]; then
  echo "🔥Building web app in preview environment"
  if [[ "$FLAVOR" == "pro" ]]; then
    flutter/bin/flutter build web --web-renderer canvaskit --dart-define SENTRY_DSN="$PG_ENV_DEV" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_pro.dart
  else
    flutter/bin/flutter build web --web-renderer canvaskit --dart-define SENTRY_DSN="$PG_ENV_DEV" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_free.dart
  fi
else
  echo "🔥Building web app in production environment"
  if [[ "$FLAVOR" == "pro" ]]; then
    echo "🔥Built for pro version"
    flutter/bin/flutter build web --web-renderer canvaskit --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_pro.dart --base-href /play/pro/
  else
    echo "🔥Built for free version"
    flutter/bin/flutter build web --web-renderer canvaskit --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_free.dart --base-href /play/
  fi
fi

exit 0
