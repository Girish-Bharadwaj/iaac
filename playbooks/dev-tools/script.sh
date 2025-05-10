#!/bin/bash

echo "Fetching example.com homepage..."
curl -s https://example.com > /dev/null

if [ $? -eq 0 ]; then
  echo "✅ Successfully fetched example.com!"
else
  echo "❌ Failed to fetch example.com."
fi