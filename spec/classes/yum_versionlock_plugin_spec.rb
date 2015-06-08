require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package::yum::versionlock_plugin', :type => 'class' do

  context 'default' do
    it { should contain_package('yum-plugin-versionlock').with(
      :ensure => 'present'
    )}
  end

end

