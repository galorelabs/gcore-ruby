#!/bin/bash

#Check if this conincides with proper versions
RVM_GEMSET=$(cat .ruby-gemset)
RVM_VERSION=$(cat .ruby-version)
GEM_NAME=gcore-ruby
GEM_VERSION=0.1.0

rvm use $RVM_VERSION@$RVM_GEMSET

#get current branch
BRANCH=$(git symbolic-ref -q HEAD | cut -d"/" -f 3)
echo "Working on the '$BRANCH' branch"
git checkout -q $BRANCH
git pull origin $BRANCH

gem build $GEM_NAME.gemspec
gem install $GEM_NAME-$GEM_VERSION.gem
