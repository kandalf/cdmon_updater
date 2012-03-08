# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cdmon_updater/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Leonardo Mateo"]
  gem.email         = ["leonardomateo@gmail.com"]
  gem.description   = %q{Just another client for CDMon (http://www.cdmon.com) dynamic DNS.}
  gem.summary       = %q{CDMon dynamic DNS client}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "cdmon_updater"
  gem.require_paths = ["lib"]
  gem.version       = CdmonUpdater::VERSION
end
