require 'spud_core'
require 'paperclip'
require 'liquid'

module Spud
  module Banners
    class Engine < Rails::Engine
      engine_name :spud_banners
      Spud::Core.append_admin_stylesheets('spud/admin/banners/application')
      Spud::Core.append_admin_javascripts('spud/admin/banners/application')
      initializer :admin do
        Spud::Core.config.admin_applications += [{
          :name => 'Banner Sets',
          :thumbnail => 'spud/admin/banners/banners.png',
          :retina => true,
          :url => '/spud/admin/banner_sets',
          :order => 120  
        }]
      end
      initializer :liquid do
        Liquid::Template.register_tag('spud_banner_set', Spud::Banners::BannerSetTag) if defined?(Liquid::Template)
      end
    end
  end
end
