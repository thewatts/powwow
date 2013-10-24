require 'rubygems' if RUBY_VERSION <= "1.8.7"
ENV['IDEABOX_ENV'] = 'test'

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/ideabox'
