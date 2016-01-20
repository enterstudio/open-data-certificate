# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.
ENV["RAILS_ROOT"] ||= File.expand_path(File.dirname(__FILE__) + '/../../testbed')
require 'cucumber/rails'

# For Rails 3.0
include Surveyor::Helpers::AssetPipeline

# require File.expand_path(File.dirname(__FILE__) + '/../../testbed/config/environment.rb')
# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Use chrome for Selenium by default. This is because of Firefox's bug 566671
# (https://bugzilla.mozilla.org/show_bug.cgi?id=566671): any test that relies on
# blur or change events will not work when Firefox is in the background.
ENV['SELENIUM_BROWSER'] ||= 'chrome'

# Wait for AJAX requests to complete in selenium
# n.b.: Capybara 2.0 will change the way this works.
# http://groups.google.com/group/ruby-capybara/browse_thread/thread/6d955173ce413b0a/d0682d47a915dfbd
Capybara.register_driver :selenium do |app|
  SingleQuitSeleniumDriver.new(app, :browser => ENV['SELENIUM_BROWSER'].to_sym,
    :resynchronize => true)
end

Before do |scenario|
  Rails.logger.info "\n\nBeginning scenario #{scenario.file_colon_line} \"#{scenario.title}\""
end

require "json_spec/cucumber"
JsonSpec.configure do
  exclude_keys "id", "created_at", "updated_at", "uuid", "modified_at", "completed_at"
end
