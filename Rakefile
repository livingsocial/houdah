require 'rubygems'
require 'bundler'
require 'rake/testtask'
require 'rdoc/task'

Bundler::GemHelper.install_tasks

desc "Create documentation"
Rake::RDocTask.new("doc") { |rdoc|
  rdoc.title = "Houdah - Riding on the back of Hadoop"
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

task :default => [ :gem, :doc ]
