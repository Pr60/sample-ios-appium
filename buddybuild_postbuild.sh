#!/usr/bin/env bash

# start appium in background
node $APPIUM_HOME &

export APP_PATH=$BUDDYBUILD_PRODUCT_DIR

ruby simple_test.rb