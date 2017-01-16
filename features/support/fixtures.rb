# encoding: utf-8
require_relative 'configuration.rb'
require 'singleton'

class Fixtures
  include Singleton

  def self.instance
    @instance ||= new
  end

  def [] (fixture_name)
    self.send(fixture_name.to_sym)
  end

  #fall back to fixtures in config.yml
  def method_missing(sym, *args)
      Configuration.fetch(sym, '')
  end
end
