require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package::verifiable', :type => 'define' do
  context 'default' do
    let(:title){'testpackage'}
    let(:params){
      {
        :version => '1.0-1'
      }
    }
    it { should contain_package('testpackage').with(
      :ensure => '1.0-1',
    ) }

    it { should contain_file_line('testpackage_version_fact').with(
      :path    => '/etc/facter/facts.d/packages.txt',
      :match   => "^package_testpackage_version=",
      :line    => 'package_testpackage_version=1.0-1',
      :require => 'Package[testpackage]',
    )}
  end
  context 'without managing the package' do
    let(:title){'testpackage'}
    let(:params){
      {
        :version => '1.0-1',
        :manage_package => false,
      }
    }
    it { should_not contain_package('testpackage') }

    it { should contain_file_line('testpackage_version_fact').with(
      :path    => '/etc/facter/facts.d/packages.txt',
      :match   => "^package_testpackage_version=",
      :line    => 'package_testpackage_version=1.0-1',
      :require => 'Package[testpackage]',
    )}
  end

  context 'with dash name' do
    let(:title){'test-package'}
    let(:params){
      {
        :version => '1.0-1'
      }
    }
    it { should contain_package('test-package').with(
      :ensure => '1.0-1',
    ) }

    it { should contain_file_line('test-package_version_fact').with(
      :path    => '/etc/facter/facts.d/packages.txt',
      :match   => "^package_test_package_version=",
      :line    => 'package_test_package_version=1.0-1',
      :require => 'Package[test-package]',
    )}
  end

  context "facts are always downcased" do
      let(:title){'TESTPackage'}
    let(:params){
      {
        :version => '1.0-1'
      }
    }
    it { should contain_package('TESTPackage').with(
      :ensure => '1.0-1',
    ) }

    it { should contain_file_line('TESTPackage_version_fact').with(
      :path    => '/etc/facter/facts.d/packages.txt',
      :match   => "^package_testpackage_version=",
      :line    => 'package_testpackage_version=1.0-1',
      :require => 'Package[TESTPackage]',
    )}
  end
end
