# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dory/version'

Gem::Specification.new do |s|
  s.name        = 'dory'
  s.version     = Dory::VERSION
  s.date        = '2016-03-08'
  s.summary     = 'slackbot_frd provides a dirt-simple framework ' \
    'for implementing one or more slack bots'
  s.description = 'The slack web api is good, but very raw.  ' \
    'What you need is a great ruby framework to abstract away all ' \
    'that.  This is it!  This framework allows you to write bots ' \
    'easily by providing methods that are easy to call.  Behind ' \
    'the scenes, the framework is negotiating your real time ' \
    'stream, converting channel names and user names to and from ' \
    'IDs so you can use the names instead, and parsing/classifying ' \
    'the real time messages into useful types that you can hook ' \
    "into.  Don't write your bot without this."
  s.authors     = ['Ben Porter']
  s.email       = 'BenjaminPorter86@gmail.com'
  s.files       = ['lib/dory.rb'] + Dir['lib/dory/**/*']
  s.homepage    = 'https://github.com/FreedomBen/dory'
  s.license     = 'MIT'

  s.executables << 'dory'

  s.add_runtime_dependency 'colorize', '~> 0.7'
  s.add_runtime_dependency 'thor', '~> 0.19'
  s.add_runtime_dependency 'ptools', '~> 1.3'

  s.add_development_dependency 'byebug', '~> 4.0'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'rake', '~> 10.5'
end
