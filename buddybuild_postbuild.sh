#!/usr/bin/env bash

chruby 2.3.1

# # install brew, ant, maven
# if ! which brew >/dev/null; then
# 	echo "Installing brew..."
# 	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# fi

# if ! which ant >/dev/null; then
# 	echo "Installing ant..."
# 	brew install ant
# fi

# if ! which maven >/dev/null; then
# 	echo "Installing brew..."
# 	brew install maven
# fi

# install appium
echo 'Installing appium...'
npm install -g appium

# authorize for testing
echo 'Installing authorize-ios...'
npm install -g authorize-ios
sudo authorize-ios

# install rubygems
echo 'Installing rubygems...'
bundle update
bundle install

# start appium in background
echo 'Running appium in background task...'
nohup appium &
echo $! > $BUDDYBUILD_WORKSPACE/appium_pid.txt

# App path must be relative to $BUDDYBUILD_WORKSPACE
export APP_PATH='../../..'$BUDDYBUILD_PRODUCT_DIR'/Debug-iphonesimulator/m2048.app'

# Let appium process begin before running tests
sleep 5

echo 'Running appium tests...'
bundle exec ruby simple_test.rb

# terminate 
jobs -l
kill -9 `cat $BUDDYBUILD_WORKSPACE/appium_pid.txt`
rm $BUDDYBUILD_WORKSPACE/appium_pid.txt

exit 0