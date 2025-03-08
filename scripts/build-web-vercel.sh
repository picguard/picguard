#!/bin/sh

set -e

echo "VERCEL_GIT_COMMIT_SHA: $VERCEL_GIT_COMMIT_SHA"
echo "VERCEL_ENV: $VERCEL_ENV"
echo "FLAVOR: $FLAVOR"

if [ "$VERCEL_ENV" = "production" ]; then
  echo "🔥Building web app in production environment"
  if [ "$FLAVOR" = "pro" ]; then
    echo "🔥Built for pro version"
    flutter/bin/flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_pro.dart --base-href /play/pro/
  else
    echo "🔥Built for free version"
    flutter/bin/flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_free.dart --base-href /play/
  fi
else
  echo "🔥Building web app in $VERCEL_ENV environment"
  if [ "$FLAVOR" = "pro" ]; then
    echo "🔥Built for pro version"
    flutter/bin/flutter build web --dart-define SENTRY_DSN="$PG_ENV_DEV" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_pro.dart
  else
    echo "🔥Built for free version"
    flutter/bin/flutter build web --dart-define SENTRY_DSN="$PG_ENV_DEV" --dart-define GIT_COMMIT_SHA="$VERCEL_GIT_COMMIT_SHA" --target lib/main_free.dart
  fi
fi

exit 0
