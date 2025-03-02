#!/bin/sh

set -e

echo "COMMIT_REF: $COMMIT_REF"
echo "CONTEXT: $CONTEXT"
echo "FLAVOR: $FLAVOR"

if [[ "$CONTEXT" == "production" ]]; then
  echo "🔥Building web app in production environment"
  if [[ "$FLAVOR" == "pro" ]]; then
    echo "🔥Built for pro version"
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --target lib/main_pro.dart --base-href /play/pro/
  else
    echo "🔥Built for free version"
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --target lib/main_free.dart --base-href /play/
  fi
else
  echo "🔥Building web app in preview environment"
  if [[ "$FLAVOR" == "pro" ]]; then
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_STG" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --target lib/main_pro.dart
  else
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_STG" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --target lib/main_free.dart
  fi
fi

exit 0
