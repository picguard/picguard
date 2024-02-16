#!/bin/sh

set -e

if [[ "$VERCEL_ENV" == "preview" ]] ; then
  echo "🔥Building web app in preview environment"
  flutter/bin/flutter build web --no-tree-shake-icons --web-renderer canvaskit;
else
  echo "🔥Building web app in production environment"
  flutter/bin/flutter build web --no-tree-shake-icons --web-renderer canvaskit --base-href /watermark-assistant/play/;
fi

exit 0