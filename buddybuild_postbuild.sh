#!/usr/bin/env bash

# Set up the custom reporting folders
mkdir /tmp/sandbox/workspace/buddybuild_artifacts
mkdir /tmp/sandbox/workspace/buddybuild_artifacts/Appium

chruby 2.3.1

# Build simulator app
xcodebuild -project "m2048.xcodeproj" -scheme $BUDDYBUILD_SCHEME -configuration "Debug" -destination "platform=iOS Simulator,OS=11.0,name=iPhone 7" \
	CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY="" CODE_SIGNING_ALLOWED=NO ENABLE_BITCODE=NO ONLY_ACTIVE_ARCH=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym 

echo $'\n\n===Installing Appium===\n\n'

npm install -g appium

echo $'\n\n===Installing authorize-ios===\n\n'

npm install -g authorize-ios
sudo authorize-ios

echo $'\n\n===Installing rubygems===\n\n'
gem install bundler
bundle update	
#bundle install

echo $'\n\n===Running Appium in background process===\n\n'
nohup appium &
echo $! > $BUDDYBUILD_WORKSPACE/appium_pid.txt

# App path must be relative to $BUDDYBUILD_WORKSPACE
export APP_PATH='../../..'$BUDDYBUILD_PRODUCT_DIR'/Debug-iphonesimulator/m2048.app'

# Let appium process begin before running tests
# Is there a better way to handle this?
sleep 5

echo $'\n\n===Running Appium tests===\n'
bundle exec ruby simple_test.rb

# Cleanup Appium process
jobs -l
kill -9 `cat $BUDDYBUILD_WORKSPACE/appium_pid.txt`
rm $BUDDYBUILD_WORKSPACE/appium_pid.txt

# Copy test results to buddybuild test reporting folder
mv target/surefire-reports/*.xml /tmp/sandbox/workspace/buddybuild_artifacts/Appium

exit 0