require 'bundler'
Bundler.require(:rake)
require 'rspec/core/rake_task'

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
  config.log_format = '%{path}:%{line}:%{KIND}: %{message}'
  config.disable_checks = ["class_inherits_from_params_class", "80chars"]
end

# use librarian-puppet to manage fixtures instead of .fixtures.yml
# offers more possibilities like explicit version management, forge downloads,...
task :librarian_spec_prep do
  sh "librarian-puppet install --path=spec/fixtures/modules/"
  pwd = Dir.pwd.strip
  unless File.directory?("#{pwd}/spec/fixtures/modules/role_icinga2")
    # workaround for windows as symlinks are not supported with 'ln -s' in git-bash
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      begin
        sh "cmd /c \"mklink /d #{pwd}\\spec\\fixtures\\modules\\role_icinga2 #{pwd}\""
      rescue Exception => e
        puts '-----------------------------------------'
        puts 'Git Bash must be started as Administrator'
        puts '-----------------------------------------'
        raise e
      end
    else
      sh "ln -s #{pwd} #{pwd}/spec/fixtures/modules/role_icinga2"
    end
  end
end

# Windows rake spec task for git bash
# default spec task fails because of unsupported symlinks on windows
task :spec_win do
  sh "rspec --pattern spec/\{classes,defines,unit,functions,hosts,integration\}/\*\*/\*_spec.rb --color"
end

task :spec_clean_win do
  pwd = Dir.pwd.strip
  sh "cmd /c \"rmdir /q #{pwd}\\spec\\fixtures\\modules\\role_icinga2\""
end

task :spec_prep => :librarian_spec_prep

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  task :default => [:spec_prep, :spec_win, :spec_clean, :spec_clean_win, :lint]
else
  task :default => [:spec, :lint]
end

# Acceptance tests (using Serverspec)
properties_file = 'spec/acceptance/properties.yml'

desc "Run serverspec to all hosts"
task :serverspec => 'serverspec:all'

all_nodes = []

# Read targets from properties file
if File.file?(properties_file)
  properties = YAML.load_file(properties_file)
  all_nodes = properties.keys if properties
end

# Read targets from subdirectories
Dir.glob('./spec/acceptance/*').each do |dir|
  next unless File.directory?(dir)
  target = File.basename(dir)
  next if target == 'default' or target == 'local' or target == 'shared'
  all_nodes |= [target]
end

namespace :serverspec do
  # Tests started from the local host
  if File.directory?('spec/acceptance/local')
    desc 'Run serverspec tests on the local host'
    RSpec::Core::RakeTask.new(:local) do |task|
      task.pattern = "spec/acceptance/local/*_spec.rb"
    end
  end

  # Tests started from the remote host, through SSH
  task :all => all_nodes.map {|host| 'serverspec:' + host }
  all_nodes.each do |host|
    desc "Run serverspec to #{host}"
    RSpec::Core::RakeTask.new(host) do |task|
      ENV['TARGET_HOST'] = host
      task.pattern = "spec/acceptance/{default,#{host}}/*_spec.rb"
    end
  end
end
