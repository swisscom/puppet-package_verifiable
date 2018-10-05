require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package_verifiable::base', :type => 'class' do

  context 'with puppet 3' do
    let(:facts) do { 'puppetversion' => '3.8.7', } end

    it { should compile.with_all_deps }

    it { should contain_exec('ensure-facts-dir-is-present').with(
      :command => 'mkdir -p /etc/facter/facts.d',
      :unless  => 'test -d /etc/facter/facts.d',
      :path    => '/usr/bin:/bin',
    )}

    it { should contain_file('/etc/facter/facts.d/packages.txt').with(
      :ensure  => 'present',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0644',
      :require => 'Exec[ensure-facts-dir-is-present]',
    )}
  end

  context 'with puppet 4' do
    let(:facts) do { 'puppetversion' => '4.9.5', } end

    it { should compile.with_all_deps }

    it { should contain_exec('ensure-facts-dir-is-present').with(
      :command => 'mkdir -p /opt/puppetlabs/facter/facts.d',
      :unless  => 'test -d /opt/puppetlabs/facter/facts.d',
      :path    => '/usr/bin:/bin',
    )}

    it { should contain_file('/opt/puppetlabs/facter/facts.d/packages.txt').with(
      :ensure  => 'present',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0644',
      :require => 'Exec[ensure-facts-dir-is-present]',
    )}
  end

end

