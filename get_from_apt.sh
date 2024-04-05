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

INRELEASE=$(curl -H 'User-Agent: Debian APT-HTTP/1.3' $REPOSITORY_URL/dists/$CODENAME/InRelease)

# PATH_URL=$(echo -e "$PACKAGE"|grep -A 100 "Package: $PACKAGE_NAME"|grep Filename|head -n 1|cut -d ':' -f 2|sed 's/ //g')
# echo -n $PACKAGE
# curl -H 'User-Agent: Debian APT-HTTP/1.3' $REPOSITORY_URL/$PATH_URL > $PACKAGE_NAME_$CODENAME_$ARCHITECTURE_$PACKAGE_VERSION.deb
#
