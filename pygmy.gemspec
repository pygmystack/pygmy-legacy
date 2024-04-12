# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pygmy/version'

Gem::Specification.new do |s|
  s.name        = 'pygmy'
  s.version     = Pygmy::VERSION
  s.date        = Pygmy::DATE
  s.summary     = 'The Ruby version of pygmy is no longer supported - please use https://github.com/pygmystack/pygmy instead.'
  s.description = 'The Ruby version of pygmy is no longer supported - please use https://github.com/pygmystack/pygmy instead.'
  s.authors     = ['The pygmystack authors']
  s.email       = 'lagoon@amazee.io'
  s.files       = ['lib/pygmy.rb'] + Dir['lib/pygmy/**/*']
  s.homepage    = 'https://github.com/pygmystack/pygmy-legacy'
  s.license     = 'MIT'

  s.executables << 'pygmy'

  s.add_runtime_dependency 'thor', '~> 1.3.0'
end
