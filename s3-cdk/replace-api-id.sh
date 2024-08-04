#!/bin/bash

# Variables
TAG_KEY="Project"
TAG_VALUE="MyProject"
PLACEHOLDER="{API_ID}"
HTML_FILE="data-folder/index.html"

# Fetch the API ID using AWS CLI
API_ID=$(aws apigateway get-rest-apis --query "items[?tags.${TAG_KEY}=='${TAG_VALUE}'].id" --output text)

# Check if API_ID was found
if [ -z "$API_ID" ]; then
    echo "API ID not found for the given tag"
    exit 1
fi


# Replace the placeholder in the HTML file
sed -i "s/${PLACEHOLDER}/${API_ID}/g" "$HTML_FILE"

echo "Replaced ${PLACEHOLDER} with ${API_ID} in ${HTML_FILE}"
