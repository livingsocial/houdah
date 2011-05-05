require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc "Create documentation"
Rake::RDocTask.new("doc") { |rdoc|
  rdoc.title = "HBaseRb - Naive Bayes classifier with HBase storage"
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
}

desc "Re-generate thrift files"
task "regen_thrift" do 
  if ENV['HUE_HOME'].nil?
    puts "You must set your HUE_HOME variable before calling this task."
    return
  end
  system "thrift --gen rb -o /tmp #{ENV['HUE_HOME']}/desktop/libs/hadoop/java/if/jobtracker.thrift"
  system "thrift --gen rb -o /tmp #{ENV['HUE_HOME']}/desktop/libs/hadoop/java/if/common.thrift"
  system "mv /tmp/gen-rb/* lib/thrift"
end

spec = Gem::Specification.new do |s|
  s.name = "hbaserb"
  s.version = "0.0.3"
  s.authors = ["Brian Muller"]
  s.date = %q{2010-12-03}
  s.description = "HBase Thrift interface for Ruby"
  s.summary = "Simple lib for interfaceing with HBase via Ruby and Thrift."
  s.email = "brian.muller@livingsocial.com"
  s.files = FileList["lib/**/*"]
  s.homepage = "http://github.com/bmuller/hbaserb"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.5"
  s.add_dependency('nokogiri', '>= 1.4.4') # keep this
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

desc "Default task: builds gem and runs tests"
task :default => [ :gem, :test ]
