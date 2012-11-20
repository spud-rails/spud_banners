require 'spud_core'
require 'paperclip'

module Spud
  module Banners
    class Engine < Rails::Engine
      engine_name :spud_banners
      Spud::Core.append_admin_stylesheets('spud/admin/banners/application')
      Spud::Core.append_admin_javascripts('spud/admin/banners/application')
      initializer :admin do
        Spud::Core.config.admin_applications += [{
          :name => 'Banner Sets',
          :thumbnail => 'spud/photos/photo_albums_thumb.png',
          :retina => true,
          :url => '/spud/admin/banner_sets',
          :order => 120  
        }]
      end
    end
  end
end
