#!/bin/bash

#Check if this conincides with proper versions
RVM_GEMSET=gcore
RVM_VERSION=2.1.2
GEM_NAME=gcore-ruby
GEM_VERSION=0.1.0

rvm use $RVM_VERSION@$RVM_GEMSET
git pull --all
gem build $GEM_NAME.gemspec
gem install $GEM_NAME-$GEM_VERSION.gem
