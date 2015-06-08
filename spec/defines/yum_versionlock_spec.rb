require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package::yum::versionlock', :type => 'define' do
  context 'default' do
    let(:title){'testpackage'}
    let(:params){
      {
        :ensure => '1.0-1'
      }
    }

    it { should contain_class('package::yum::versionlock_plugin')}

    it { should contain_augeas('testpackage_yum_versionlock').with(
      :incl      => '/etc/yum/pluginconf.d/versionlock.list',
      :lens      => 'YumVersionlock.lns',
      :load_path => '/var/lib/puppet/lib/package/lenses',
      :context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      :changes   => ['set testpackage/version 1.0-1']
    )}
  end

  context 'with epoch' do
    let(:title){'testpackage'}
    let(:params){
      {
        :ensure => '1.0-1',
        :epoch  => '5',
      }
    }

    it { should contain_augeas('testpackage_yum_versionlock').with(
      :incl      => '/etc/yum/pluginconf.d/versionlock.list',
      :lens      => 'YumVersionlock.lns',
      :load_path => '/var/lib/puppet/lib/package/lenses',
      :context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      :changes   => ['set testpackage/epoch 5', 'set testpackage/version 1.0-1']
    )}
  end

  context 'with absent' do
    let(:title){'testpackage'}
    let(:params){
      {
        :ensure => 'absent'
      }
    }

    it { should contain_augeas('testpackage_yum_versionlock').with(
      :incl      => '/etc/yum/pluginconf.d/versionlock.list',
      :lens      => 'YumVersionlock.lns',
      :load_path => '/var/lib/puppet/lib/package/lenses',
      :context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      :changes   => ['rm testpackage']
    )}
  end

  context 'with installed' do
    let(:title){'testpackage'}
    let(:params){
      {
        :ensure => 'installed'
      }
    }

    it { should contain_augeas('testpackage_yum_versionlock').with(
      :incl      => '/etc/yum/pluginconf.d/versionlock.list',
      :lens      => 'YumVersionlock.lns',
      :load_path => '/var/lib/puppet/lib/package/lenses',
      :context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      :changes   => ['rm testpackage']
    )}
  end

  context 'with latest' do
    let(:title){'testpackage'}
    let(:params){
      {
        :ensure => 'latest'
      }
    }

    it { should contain_augeas('testpackage_yum_versionlock').with(
      :incl      => '/etc/yum/pluginconf.d/versionlock.list',
      :lens      => 'YumVersionlock.lns',
      :load_path => '/var/lib/puppet/lib/package/lenses',
      :context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      :changes   => ['rm testpackage']
    )}
  end

  context 'with present' do
    let(:title){'testpackage'}
    let(:params){
      {
        :ensure => 'present'
      }
    }

    it { should contain_augeas('testpackage_yum_versionlock').with(
      :incl      => '/etc/yum/pluginconf.d/versionlock.list',
      :lens      => 'YumVersionlock.lns',
      :load_path => '/var/lib/puppet/lib/package/lenses',
      :context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      :changes   => ['rm testpackage']
    )}
  end
end
