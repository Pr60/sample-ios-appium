#!/usr/bin/env bash

chruby 2.1.1

# install brew, ant, maven
if ! which brew >/dev/null; then
	echo "Installing brew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! which ant >/dev/null; then
	echo "Installing ant..."
	brew install ant
fi

if ! which maven >/dev/null; then
	echo "Installing brew..."
	brew install maven
fi

# clone appium
echo "Cloning Appium..."
cd && \
git clone git://github.com/appium/appium.git


# install appium deps
echo "Installing Appium dependencies..."
cd appium
npm install

# create env var for appium install
export APPIUM_HOME=pwd

# authorize for testing
npm install -g authorize-ios
authorize-ios