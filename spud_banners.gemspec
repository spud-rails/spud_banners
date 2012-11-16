$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spud_banners/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spud_banners"
  s.version     = Spud::Banners::VERSION
  s.authors     = ["Greg Woods"]
  s.email       = ["greg@westlakedesign.com"]
  s.homepage    = "http://www.github.com/gregawoods/spud_banners"
  s.summary     = "Banner Management tool for Spud applications."
  s.description = "Spud Banners allows you to create and maintain sets of rotating banners for use on your Spud-based website."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "Readme.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency 'spud_core', ">= 0.9.0"
  s.add_dependency "paperclip", ">= 0"
end