require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'package_verifiable::fact', :type => 'define' do
  context 'default' do
    let(:title) { 'testpackage' }
    let(:params){
      {
        :package => 'testpackage',
        :ensure  => '1.0-1',
      }
    }

    it { should compile.with_all_deps }

    it { should contain_file_line('testpackage_version_fact').with(
      :path  => '/etc/facter/facts.d/packages.txt',
      :match => "^package_testpackage_version=",
      :line  => 'package_testpackage_version=1.0-1',
    )}

  end

  context "facts are always downcased" do
    let(:title){'TESTPackage'}
    let(:params){
      {
        :version => '1.0-1'
      }
    }

    it { should compile.with_all_deps }

    it { should contain_file_line('testpackage_version_fact').with(
      :path    => '/etc/facter/facts.d/packages.txt',
      :match   => "^package_testpackage_version=",
      :line    => 'package_testpackage_version=1.0-1',
    )}
  end
end
