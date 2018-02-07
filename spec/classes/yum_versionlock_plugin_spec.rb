require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package_verifiable::yum::versionlock_plugin', :type => 'class' do

  context 'default' do
    let(:facts) do { 'puppetversion' => '4.9.5', } end

    it { should compile.with_all_deps }

    it { should contain_package('yum-plugin-versionlock').with(
      :ensure => 'present'
    )}
  end

end

