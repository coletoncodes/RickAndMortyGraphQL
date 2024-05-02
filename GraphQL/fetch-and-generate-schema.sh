#!/bin/sh

#  fetch-and-generate-schema.sh
#  RickAndMortyGraphQL
#
#  Created by Coleton Gorecke on 5/1/24.
#  

cd "${SRCROOT}"

echo "Fetching schema"
# Fetch the scheme
./apollo-ios-cli fetch-schema

echo "Generating code"
# Generate the code to the local swift package.
./apollo-ios-cli generate
