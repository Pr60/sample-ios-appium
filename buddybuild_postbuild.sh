#!/usr/bin/env bash

chruby 2.3.1

# Set up the test reporting folder
TEST_RESULT_DIR=$BUDDYBUILD_WORKSPACE/buddybuild_artifacts/Appium
mkdir -p $TEST_RESULT_DIR

echo $'=== Building App for Simulator ==='

SIMULATOR_APP_PATH=$BUDDYBUILD_WORKSPACE'/sim_app'

# Build simulator app
xcodebuild -project "m2048.xcodeproj" \
    -scheme "$BUDDYBUILD_SCHEME" \
    -configuration "Debug" \
    -destination "platform=iOS Simulator,OS=11.0,name=iPhone 7" \
    -derivedDataPath $SIMULATOR_APP_PATH \
	CODE_SIGNING_REQUIRED=NO \
	CODE_SIGN_IDENTITY="" \
	CODE_SIGNING_ALLOWED=NO \
	ENABLE_BITCODE=NO \
	ONLY_ACTIVE_ARCH=YES \
	DEBUG_INFORMATION_FORMAT=dwarf-with-dsym

echo $'=== Installing Appium ==='

npm install -g appium

echo $'=== Installing authorize-ios ==='

npm install -g authorize-ios
sudo authorize-ios

echo $'=== Installing rubygems ==='
gem install bundler
bundle update	
#bundle install

echo $'=== Running Appium in background process ==='
nohup appium &
echo $! > $BUDDYBUILD_WORKSPACE/appium_pid.txt

# App path must be relative to $BUDDYBUILD_WORKSPACE
export APP_PATH=$SIMULATOR_APP_PATH'/Build/Products/Debug-iphonesimulator/m2048.app'

# Let appium process begin before running tests
# Is there a better way to handle this?
sleep 5

echo $'=== Running Appium tests ==='
bundle exec rspec --format html --out $TEST_RESULT_DIR'/results.html' simple_test.rb 

# Cleanup Appium process
# jobs -l
kill -9 `cat $BUDDYBUILD_WORKSPACE/appium_pid.txt`
rm $BUDDYBUILD_WORKSPACE/appium_pid.txt

# Copy test results to test reporting folder
# mv target/surefire-reports/*.xml $TEST_RESULT_DIR

exit 0