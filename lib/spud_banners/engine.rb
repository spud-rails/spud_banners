module Spud
  module Banners
    class Engine < ::Rails::Engine
      engine_name :spud_banners
      initializer :admin do
        # setup stuff
      end
    end
  end
end
