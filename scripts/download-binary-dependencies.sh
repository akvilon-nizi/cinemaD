#!/usr/bin/env bash

# In case we're launched from fastlane
cd "$( dirname "${BASH_SOURCE[0]}" )/.."

mkdir -p .tmp && cd .tmp

# Delete old files
rm -rf "../Vendor/GoogleMaps/GoogleMaps.framework"
rm -rf "../Vendor/GoogleMaps/GoogleMapsBase.framework"
rm -rf "../Vendor/GoogleMaps/GoogleMapsCore.framework"

# Download binaries

if [ ! -f "GoogleMaps-2.4.0.tar.gz" ]
then
    echo "Downloading GoogleMaps binaries"
    curl -sSO https://dl.google.com/dl/cpdc/ca91069241a099f1/GoogleMaps-2.4.0.tar.gz
fi

# Extract required libs

echo "Unpacking GoogleMaps"
tar xzf GoogleMaps-2.4.0.tar.gz
mkdir -p ../Vendor/GoogleMaps
cp -r Base/Frameworks/GoogleMapsBase.framework ../Vendor/GoogleMaps
cp -r Maps/Frameworks/GoogleMaps.framework ../Vendor/GoogleMaps
cp -r Maps/Frameworks/GoogleMapsCore.framework ../Vendor/GoogleMaps
