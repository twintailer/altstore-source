#!/bin/bash
# deploy.sh — Push AltStore Source to GitHub Pages
#
# Usage: ./deploy.sh <github-repo-url>
# Example: ./deploy.sh https://github.com/username/altstore-source.git
#
# After deployment, your source URL will be:
#   https://username.github.io/altstore-source/apps.json

set -euo pipefail

REPO_URL="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -z "$REPO_URL" ]; then
    echo "Usage: ./deploy.sh <github-repo-url>"
    echo "Example: ./deploy.sh https://github.com/user/altstore-source.git"
    exit 1
fi

cd "$SCRIPT_DIR"

# Replace placeholder URLs with the actual GitHub Pages URL
# Extract username and repo from the URL
if [[ "$REPO_URL" =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
    GH_USER="${BASH_REMATCH[1]}"
    GH_REPO="${BASH_REMATCH[2]}"
    BASE_URL="https://${GH_USER}.github.io/${GH_REPO}"
    echo "Base URL: $BASE_URL"

    # Replace placeholders in apps.json
    sed -i "s|{{DOWNLOAD_BASE_URL}}|${BASE_URL}|g" apps.json
    echo "Placeholders in apps.json replaced."
else
    echo "WARNING: Could not parse GitHub URL. Placeholders remain in apps.json."
    echo "Manually replace {{DOWNLOAD_BASE_URL}} in apps.json before committing."
fi

# Copy IPA files into the source directory
echo "Copying IPA files..."
cp ../*.ipa . 2>/dev/null || echo "No IPA files found in parent directory."

# Init git repo and push
if [ ! -d ".git" ]; then
    git init
    git checkout -b main
fi

git add -A
git commit -m "Deploy AltStore source"

git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"
git push -u origin main --force

echo ""
echo "Deployed! Next steps:"
echo "1. Go to GitHub repo Settings > Pages"
echo "2. Set source to 'Deploy from a branch' > 'main' > '/ (root)'"
echo "3. Your AltStore source URL: ${BASE_URL:-<your-github-pages-url>}/apps.json"
echo "4. Add this URL in AltStore > Sources > +"
