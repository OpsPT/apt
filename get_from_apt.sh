#! /bin/bash
set -e

# Check if all required arguments are provided
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <package-name> <package-version> <architecture> <repository-url> <codename>"
    exit 1
fi

PACKAGE_NAME=$1
PACKAGE_VERSION=$2
ARCHITECTURE=$3
REPOSITORY_URL=$4
CODENAME=$5

curl -H 'User-Agent: Debian APT-HTTP/1.3' $REPOSITORY_URL/dists/$CODENAME/binary-$ARCHITECTURE/Packages > Packages
cat Packages


