$:.unshift File.dirname(__FILE__) + "/lib/"
require 'westwind'

run Westwind::Application
