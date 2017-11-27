require 'rubygems'
require 'appium_lib'
require 'rspec'

# RSpec.configure do |c|
#   c.treat_symbols_as_metadata_keys_with_true_values = true
# end

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

describe 'M2ViewController' do
  before(:all) do
    Appium::Driver.new(desired_caps).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  def back_click(opts={})
    opts        ||= {}
    search_wait = opts.fetch(:wait, 10) # seconds
    wait(search_wait) { button_exact('Back').click }
  end

  after(:all) do
    driver_quit
  end

  describe '.settings', :one do
    subject { find_elements(:class_name, 'UIAButton')[0] }

    it { should_not be nil }

    context 'when playing the game' do
      it 'can access the settings' do
        subject.click()
      end
    end
  end
end
