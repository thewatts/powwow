require 'rubygems' if RUBY_VERSION <= "1.8.7"
ENV['POWWOW_ENV'] = 'test'

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/powwow'
