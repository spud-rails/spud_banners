module Spud
  module Banners
    require 'spud_banners/configuration'
    require "spud_banners/engine" if defined?(Rails)
  end
end