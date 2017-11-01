#!/usr/bin/env bash

echo $APPIUM_HOME

# start appium in background
node $APPIUM_HOME &

export APP_PATH=$BUDDYBUILD_PRODUCT_DIR

cd $BUDDYBUILD_WORKSPACE
bundle exec ruby simple_test.rb