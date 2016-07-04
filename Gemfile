source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "~> #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['~> 3.7.5']
end

if ENV.key?('RAKE_VERSION')
  rakeversion = "~> #{ENV['RAKE_VERSION']}"
else
  rakeversion = nil
end

gem 'puppet', puppetversion
gem 'puppet-lint'
gem 'puppetlabs_spec_helper'
gem 'rake', rakeversion
gem 'librarian-puppet'
