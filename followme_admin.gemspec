$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "followme_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "followme_admin"
  s.version     = FollowmeAdmin::VERSION
  s.authors     = ["Amol Udage"]
  s.email       = ["amoludage@joshsoftware.com"]
  s.homepage    = ""
  s.summary     = "Summary of FollowmeAdmin."
  s.description = "Description of FollowmeAdmin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.7"

  s.add_development_dependency "pg", "~> 0.18.2"
end
