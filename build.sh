#!/bin/bash
# LINK SP Report Builder — Netlify build script
# Injects environment variables into the HTML file at deploy time.
# Real key values are stored in Netlify's environment variable dashboard —
# they are never committed to the repository.

set -e  # Stop immediately if any command fails

echo "Starting LINK SP build..."

# Confirm required environment variables are present
if [ -z "$SHEETS_API_KEY" ]; then
  echo "ERROR: SHEETS_API_KEY environment variable is not set."
  exit 1
fi
if [ -z "$MAPBOX_TOKEN" ]; then
  echo "ERROR: MAPBOX_TOKEN environment variable is not set."
  exit 1
fi
if [ -z "$ADMIN_SUFFIX" ]; then
  echo "ERROR: ADMIN_SUFFIX environment variable is not set."
  exit 1
fi

# Copy the source HTML to a dist folder (keeps source file clean)
mkdir -p dist
cp index.html dist/index.html

# Inject real values in place of placeholders
sed -i "s|__SHEETS_API_KEY__|${SHEETS_API_KEY}|g" dist/index.html
sed -i "s|__MAPBOX_TOKEN__|${MAPBOX_TOKEN}|g" dist/index.html
sed -i "s|__ADMIN_SUFFIX__|${ADMIN_SUFFIX}|g" dist/index.html

echo "Build complete. Output: dist/index.html"
