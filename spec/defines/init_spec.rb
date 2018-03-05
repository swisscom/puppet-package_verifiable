require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package_verifiable', :type => 'define' do
  let(:facts_default) do
    {
      :virtual                    => 'kvm',
      :operatingsystem            => 'redhat',
      :operatingsystemmajrelease  => '7',
      :operatingsystemrelease     => '7.1',
      :osfamily                   => 'RedHat',
      :is_virtual                 => true,
      :concat_basedir             => '/var/lib/puppet/concat',
      :domain                     => 'example.com',
      :ipaddress                  => '10.0.0.1',
      :fqdn                       => 'std.example.com',
      :puppetversion              => '3.8.7',
    }
  end
  let(:facts) { facts_default }

  context 'default' do
    let(:title){'testpackage'}
    let(:params){
      {
        :version => '1.0-1'
      }
    }

    it { should compile.with_all_deps }

    it { should contain_package('testpackage').with(
      :ensure => '1.0-1',
      :before => ['Package_verifiable::Fact[testpackage]'],
    ) }

    it { should contain_package_verifiable__fact('testpackage').with(
      :version => '1.0-1',
    )}

    it { should contain_package_verifiable__yum__versionlock('testpackage').with(
      :ensure => '1.0-1',
    )}
    it { should contain_package_verifiable__yum__versionlock('testpackage').that_comes_before('Package[testpackage]') }
    it { should contain_package_verifiable__yum__versionlock('testpackage').that_comes_before('Package_verifiable::Fact[testpackage]') }
  end
  context 'without managing the package' do
    let(:title){'testpackage'}
    let(:params){
      {
        :version => '1.0-1',
        :manage_package => false,
      }
    }

    it { should compile.with_all_deps }

    it { should_not contain_package('testpackage') }

    it { should contain_package_verifiable__fact('testpackage').with(
      :version => '1.0-1',
    )}
    it { should contain_package_verifiable__yum__versionlock('testpackage').with(
      :ensure => '1.0-1',
    )}
  end

  context 'with dash name' do
    let(:title){'test-package'}
    let(:params){
      {
        :version => '1.0-1'
      }
    }

    it { should compile.with_all_deps }

    it { should contain_package('test-package').with(
      :ensure => '1.0-1',
      :before => ['Package_verifiable::Fact[test-package]'],
    ) }

    it { should contain_package_verifiable__fact('test-package').with(
      :version => '1.0-1',
    )}
  end

  context 'using epoch' do
    let(:title){'testpackage'}
    let(:params){
      {
        :epoch   => '5'
      }
    }

    it { should compile.with_all_deps }

    it { should contain_package('testpackage').with(
      :ensure => 'installed',
    ) }

    it { should contain_package_verifiable__fact('testpackage').with(
      :version => 'installed',
    )}

    it { should contain_package_verifiable__yum__versionlock('testpackage').with(
      :ensure => 'installed',
      :epoch  => '5'
    )}
  end
  context 'verfiy dependecy on external package' do
    let(:title){'testpackage'}
    let(:params){
      {
        :manage_package => false,
      }
    }
    let(:pre_condition){
      "package{'testpackage': ensure => 'installed'}"
    }

    it { should compile.with_all_deps }

    it { should contain_package('testpackage').with(
      :ensure => 'installed',
      :before => nil,
    ) }

    it { should contain_package_verifiable__fact('testpackage').with(
      :version => 'installed',
    )}
  end
  context 'without managing dependencies' do
    let(:title){'testpackage'}
    let(:params){
      {
        :manage_dependency => false,
      }
    }
    it { should compile.with_all_deps }

    it { should contain_package_verifiable__yum__versionlock('testpackage').with(
      :ensure => 'installed',
      :before => nil,
    )}

    it { should contain_package('testpackage').with(
      :ensure => 'installed',
      :before => nil,
    ) }

    it { should contain_package_verifiable__fact('testpackage').with(
      :version => 'installed',
      :after   => nil,
    )}
  end
end
