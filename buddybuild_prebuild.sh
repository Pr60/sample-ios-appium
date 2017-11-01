#!/usr/bin/env bash

chruby 2.4.1

ruby -v
node -v
npm -v

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

# install appium
npm install -g appium

# authorize for testing
npm install -g authorize-ios
authorize-ios

# install rubygems
bundle install