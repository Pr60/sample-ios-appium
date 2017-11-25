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
    subject { find_elements(:class_name, 'UIATableView')[0] }

    it { should_not be nil }

    context 'when used as a selection context' do
      it 'Can be a selection context' do
        rows = subject.find_elements(:class_name, 'UIATableCell')
        rows.size.should eq 12
      end

      it 'does not return elements it does not contain' do
        nav_bar = subject.find_elements(:class_name, 'UIANavigationBar')
        nav_bar.length.should be 0
      end
    end

    it 'returns its text' do
      rows = subject.find_elements(:class_name, 'UIATableCell')
      # rows.first.name.should eq 'Buttons, Various uses of UIButton'
      rows.first.name.should eq 'Buttons'
    end
  end
end
