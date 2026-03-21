#!/usr/bin/env bash
set -euo pipefail

# Start Jekyll in the docs directory with livereload and drafts
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/docs" || { echo "docs directory not found in $SCRIPT_DIR" >&2; exit 1; }

exec bundle exec jekyll serve --livereload --drafts --force_polling
