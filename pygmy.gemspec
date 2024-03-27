# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pygmy/version'

Gem::Specification.new do |s|
  s.name        = 'pygmy'
  s.version     = Pygmy::VERSION
  s.date        = Pygmy::DATE
  s.summary     = 'This version of pygmy is no longer supported - please use https://github.com/pygmystack/pygmy instead.'
  s.description = 'This version of pygmy is no longer supported - please use https://github.com/pygmystack/pygmy instead.'
  s.authors     = ['Michael Schmid']
  s.email       = 'michael@amazee.io'
  s.files       = ['lib/pygmy.rb'] + Dir['lib/pygmy/**/*']
  s.homepage    = 'https://github.com/amazeeio/pygmy'
  s.license     = 'MIT'

  s.executables << 'pygmy'

  s.add_runtime_dependency 'colorize', '~> 0.7'
  s.add_runtime_dependency 'thor', '~> 0.19'
  s.add_runtime_dependency 'ptools', '~> 1.3'

  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'rake', '~> 10.5'
  s.add_development_dependency 'byebug', '~> 8.2'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.5'
end
