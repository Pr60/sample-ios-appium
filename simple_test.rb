require 'rubygems'
require 'appium_lib'

# Retrieve the APP_PATH env var
app_path =  `echo $APP_PATH`.chomp

desired_caps = {
  caps: {
    platformName:  'iOS',
    platformVersion: '11.0',
    deviceName:    'iPhone 7',
    app:           app_path,
    automationName: 'XCUITest',
    wdaLocalPort: 8110,
  },
  appium_lib: {
    sauce_username:   nil, # don't run on Sauce
    sauce_access_key: nil,
    wait: 60
  }
}

# Start the driver
Appium::Driver.new(desired_caps, true).start_driver

module TwentyFourtyEight
  module IOS
    # Add all the Appium library methods to Test to make
    # calling them look nicer.
    Appium.promote_singleton_appium_methods TwentyFourtyEight

    # Click the first button
    button(1).click

    # Quit when you're done!
    driver_quit
    puts 'Tests Succeeded!'
  end
end

