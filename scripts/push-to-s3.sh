#!/usr/bin/env bash
set -euo pipefail

#
# Upload the /dist build output to your serverless-site S3 bucket.
#
# Usage:
#   ./scripts/push-to-s3.sh demo.usekarma.dev
#
# Prereqs:
#   - AWS CLI configured
#   - S3 bucket already created by serverless-site
#

if [ $# -ne 1 ]; then
  echo "Usage: $0 <s3-bucket-name>"
  echo "Example: $0 demo.usekarma.dev"
  exit 1
fi

BUCKET="$1"

if [ ! -d "dist" ]; then
  echo "ERROR: dist/ directory does not exist."
  echo "Did you run: npm run build ?"
  exit 1
fi

echo "🚀 Syncing dist/ → s3://$BUCKET/"
aws s3 sync dist/ "s3://$BUCKET/" \
  --delete \
  --cache-control "public, max-age=60" \
  --acl public-read

echo "✅ Upload complete."
echo "👉 https://$BUCKET (via CloudFront after CDN propagation)"
