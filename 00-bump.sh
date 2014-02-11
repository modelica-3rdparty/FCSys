#!/bin/bash
# Checkout a release branch from master and apply a version number to the
# Modelica files.
#
# The branch is named with the version number.
#
# Assumptions:
# 1. The repository has the same name as the Modelica package.
#
# See http://semver.org/ and
# http://nvie.com/posts/a-successful-git-branching-model/ .
#
# Kevin Davies, 7/7/13

# Get the version.
version=`git describe --abbrev=0 --tags`
version=${version:1}
read -p "Enter the new version (last was $version): " version

# Get the name of the package (see assumption 1).
package="$(basename "$( pwd )" )"
#echo $package

# Create the branch.
git checkout -b "v$version" master

# Go to the root of the repo.
cd "$(git rev-parse --show-toplevel)"

# Update the version number in various items.
# Package folder
git mv "`echo $package*.*`" "$package $version"
# Load script
sed -i "s/$package[ 0-9.]*\/package.mo/$package $version\/package.mo/" load.mos
# Link to documentation
sed -i "s/$package[ 0-9.]*\/help/$package $version\/help/" documentation.html
# Readme file
sed -i "s/($package[ 0-9.]*\//($package $version\//" README.md
# Python module
sed -i s/version='"'[0-9A-Za-z.]*'"',/version='"'$version'"',/ "$package $version/Resources/Source/Python/setup.py"
# Modelica release information
./00-stamp.sh

# Finish.
git commit -am "Added release information for v$version"
echo "Now on branch v$version from master."

