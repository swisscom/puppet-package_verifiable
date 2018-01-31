source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "~> #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.8.7']
end

gem 'puppet', puppetversion
gem 'deep_merge'
gem 'puppet-lint'
gem 'puppetlabs_spec_helper'
gem 'rake'
gem 'librarian-puppet'
gem 'rspec-puppet-utils'
gem 'json_pure', '< 2.0.2'
gem 'safe_yaml', '~> 1.0.4'

# Serverspec dependencies
gem 'serverspec'

# Octofacts dependencies
gem 'octofacts'
gem 'octofacts-updater'
