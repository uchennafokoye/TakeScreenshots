# Require selenium web driver
require "selenium-webdriver"


class TakeScreenshots


  # Quick set up
  def self.setup
    Selenium::WebDriver::Firefox.driver_path = "path_to_driver/geckodriver"
    caps =Selenium::WebDriver::Remote::Capabilities.firefox marionette: true
    @driver = Selenium::WebDriver.for :firefox, :desired_capabilities => caps
    # Visit the page
    @driver.navigate.to "www.website.com#manage_tab"

    # Maximize the page
    @driver.manage.window.maximize

    login
    @driver
  end



  def self.login
    # wait for 2 seconds
    sleep 2
    # grab the element for the password...the username is already filled
    @driver.find_element(:name, "password").send_keys("password");

    # then click the login Button
    @driver.find_element(:id, "loginButton").click
  end

  def self.snap_each_channel class_name

    # click every channell that has a class of channel

    # wait for 2 seconds
    sleep 20

    # get all elements by class name
    elements = @driver.find_elements(:class_name => class_name)
    elements.each_with_index do |element, index|
      if (element.tag_name == "li")
        next;
      end

      # If not visible, make visible
      if (!element.displayed?)
        @driver.execute_script("argument[0].scrollIntoView(true)", element);
      end

      # Then click
      element.click

      # Sleep for a few second
      sleep 3
      @driver.save_screenshot("./screenshot_faster/#{class_name}s/#{class_name}_#{index}.png");

    end


  end

  def self.takeScreenshot
    # Set up and visit the page
    setup
    snap_each_channel "channel"
    snap_each_channel "channelSet"
  end

  private

  attr_accessor :driver




end

TakeScreenshots.takeScreenshot