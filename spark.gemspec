# -*- encoding: utf-8 -*-
($:.unshift File.expand_path(File.join( File.dirname(__FILE__), 'lib' ))).uniq!

Gem::Specification.new do |gem|
   gem.name = 'spark'; require gem.name
   gem.version = Spark::VERSION
   gem.homepage = "http://github.com/elliottcable/spark"
   
   gem.author = "elliottcable [http://ell.io/tt]"
   gem.license = 'MIT'
   
   gem.summary = "An extension to Speck, providing Rake tasks and pretty test runners."
   
   gem.files = Dir['lib/**/*'] + %w[README.markdown LICENSE.text] & `git ls-files -z`.split("\0")
   
   gem.add_dependency 'speck', ">= 1"
   gem.add_dependency 'rake', ">= 10.0.0"
   
   gem.add_development_dependency 'yard', ">= 0.8.5.2"
   gem.add_development_dependency 'maruku', ">= 0.6.1"
end
