#!/bin/sh

set -e

echo "COMMIT_REF: $COMMIT_REF"
echo "CONTEXT: $CONTEXT"
echo "FLAVOR: $FLAVOR"
echo "APP_PREVIEW: $APP_PREVIEW"

if [ "$CONTEXT" = "production" ]; then
  echo "🔥Building web app in production environment"
  if [ "$FLAVOR" = "pro" ]; then
    echo "🔥Built for pro version"
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --dart-define APP_PREVIEW="$APP_PREVIEW" --target lib/main_pro.dart
  else
    echo "🔥Built for free version"
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_PROD" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --dart-define APP_PREVIEW="$APP_PREVIEW" --target lib/main_free.dart
  fi
else
  echo "🔥Building web app in $CONTEXT environment"
  if [ "$FLAVOR" = "pro" ]; then
    echo "🔥Built for pro version"
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_STG" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --dart-define APP_PREVIEW="$APP_PREVIEW" --target lib/main_pro.dart
  else
    echo "🔥Built for free version"
    flutter build web --dart-define SENTRY_DSN="$PG_ENV_STG" --dart-define GIT_COMMIT_SHA="$COMMIT_REF" --dart-define APP_PREVIEW="$APP_PREVIEW" --target lib/main_free.dart
  fi
fi

exit 0
