module Spud
  module Banners
    require 'responds_to_parent.rb'
    require 'spud_banners/configuration'
    require "spud_banners/engine" if defined?(Rails)
  end
end