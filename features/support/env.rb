#encoding: UTF-8
require 'cucumber'
require 'rspec'
require 'selenium-webdriver'
require 'rest-client'
require 'capybara'
require 'capybara/dsl'

$zap_proxy = "localhost"
$zap_proxy_port = 8095

if ENV['security'] == "true"
  Capybara.register_driver :selenium do |app|
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile["network.proxy.type"] = 1
    profile["network.proxy.http"] = $zap_proxy
    profile["network.proxy.http_port"] = $zap_proxy_port
    Capybara::Selenium::Driver.new(app, :profile => profile)
  end
end

$screenshot_counter = 0
Capybara.save_and_open_page_path = File.expand_path(File.join(File.dirname(__FILE__), "../screenshots/"))

Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_selector = :css
Capybara.default_max_wait_time = 15
Capybara.ignore_hidden_elements = false 
Capybara.exact = true
Capybara.app_host = 'http://www.akakce.com'
World(Capybara::DSL)

ENV['NO_PROXY'] = ENV['no_proxy'] = '127.0.0.1'
if ENV['APP_HOST']
  Capybara.app_host = ENV['APP_HOST']
  if Capybara.app_host.chars.last != '/'
    Capybara.app_host += '/'
  end
end

FIRST_ACCOUNT_SUFFIX = 5001
$delete_enabled = true
$environment = 'qa'