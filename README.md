# Appium Testing with Native iOS

This example app demonstrates how you might go about setting up a buddybuild project to run your Appium tests locally

### Custom buddybuild_postbuild.sh script
This script will set up our environment in such a way that we can easily install necessary dependenecies, run Appium's web server on our virtual machine instace, as well as run the ruby test cases.  While we use ruby, any language that Appium supports can be used.

The key steps this script performs are:
1. Build your application to be run on a simulator (No code signing)
2. Install/configure dependencies (ruby, appium, authorize-ios, gems)
3. Run the test using Rspec (with RSpecJunitFormatter)
4. Move the output JUnit test output to the buddybuild_artifacts folder, so that buddybuild can examine the output and expose it for rendering in the build details page.
5. Stop Appium and clean up environment
