$:.push File.expand_path("../lib", __FILE__)
require "houdah/version"
require "rake"
require "date"

Gem::Specification.new do |s|
  s.name = "houdah"
  s.version = Houdah::VERSION
  s.authors = ["Brian Muller"]
  s.date = Date.today.to_s
  s.description = "Ruby lib for interacting with a Hadoop JobTracker / TaskTrackers"
  s.summary = "Simple lib for interfaceing with a Hadoop JobTracker via Thrift"
  s.email = "brian.muller@livingsocial.com"
  s.files = FileList["lib/**/*", "[A-Z]*", "Rakefile", "docs/**/*"]
  s.homepage = "https://github.com/livingsocial/houdah"
  s.require_paths = ["lib"]
  s.rubyforge_project = "houdah"
  s.add_dependency('thrift', '>= 0.5.0')
  s.add_dependency('nokogiri', '>= 1.4.4')
end
