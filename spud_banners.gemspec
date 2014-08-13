$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spud_banners/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spud_banners"
  s.version     = Spud::Banners::VERSION
  s.authors     = ["Greg Woods", "David Estes"]
  s.email       = ["greg@westlakedesign.com", "destes@redwindsw.com"]
  s.homepage    = "http://www.github.com/spud-rails/spud_banners"
  s.summary     = "Banner Management tool for Spud applications."
  s.description = "Spud Banners allows you to create and maintain sets of rotating banners for use on your Spud-based website."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency 'spud_core', ">= 1.0.0"
  s.add_dependency "paperclip", ">= 0"
  s.add_dependency 'liquid'

  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rspec', '2.14.0'
  s.add_development_dependency 'rspec-rails', '2.14.0'
  s.add_development_dependency 'shoulda', '~> 3.0.1'
  s.add_development_dependency 'factory_girl', '~> 3.0'
  s.add_development_dependency 'database_cleaner', '1.0.0.RC1'
  s.add_development_dependency 'mocha', '0.14.0'
  s.add_development_dependency 'simplecov'
end
