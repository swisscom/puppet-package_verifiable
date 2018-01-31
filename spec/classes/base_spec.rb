require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package_verifiable::base', :type => 'class' do

  context 'with puppet 3' do
    let(:facts) do { 'puppetversion' => '3.8.7', } end

    it { should compile.with_all_deps }

    it { should contain_file('/etc/facter/facts.d/packages.txt').with(
      :ensure => 'present',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644'
    )}
  end

  context 'with puppet 4' do
    let(:facts) do { 'puppetversion' => '4.9.5', } end

    it { should compile.with_all_deps }

    it { should contain_file('/opt/puppetlabs/facter/facts.d/packages.txt').with(
      :ensure => 'present',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644'
    )}
  end

end

