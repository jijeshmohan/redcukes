# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redcukes/version"

Gem::Specification.new do |s|
  s.name        = "redcukes"
  s.version     = Redcukes::VERSION
  s.authors     = ["Jijesh Mohan"]
  s.email       = ["jijeshmohan@gmail.com"]
  s.homepage    = "https://github.com/jijeshmohan/redcukes"
  s.summary     = %q{Redmine-cucumber integration gem}
  s.description = %q{To run redmine issues using cucumber and update the execution status back in redmine}

  s.rubyforge_project = "redcukes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "activeresource"
  s.add_runtime_dependency "cucumber"
end
