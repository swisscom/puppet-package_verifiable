require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package::base', :type => 'class' do

  context 'default' do
    it { should compile.with_all_deps }

    it { should contain_file('/etc/facter/facts.d/packages.txt').with(
      :ensure => 'present',
      :owner  => 'root',
      :group  => 0,
      :mode   => '0644'
    )}
  end

end

