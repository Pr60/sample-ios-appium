#!/usr/bin/env bash

# start appium in background
nohup appium &

export APP_PATH=$BUDDYBUILD_PRODUCT_DIR

cd $BUDDYBUILD_WORKSPACE
bundle exec ruby simple_test.rb