require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'verify_package_versions', :type => 'puppet_function' do
  before(:each) do
    Puppet::Parser::Functions.function(:verify_package_versions)
  end

  context 'with no arguments' do
    it { is_expected.to run.with_params().and_raise_error(Puppet::ParseError) }
  end

  context 'with one prog' do
    context 'with no facts' do
      it { is_expected.to run.with_params('program1', '1.0').and_return(false) }
    end
    context 'with another fact version' do
      let(:facts){
        {
          :package_program1_version => '1.1'
        }
      }
      it { is_expected.to run.with_params('program1', '1.0').and_return(false) }
    end

    context 'with same fact version' do
      let(:facts){
        {
          :package_program1_version => '1.0'
        }
      }
      it { is_expected.to run.with_params('program1', '1.0').and_return(true) }
    end
  end

  context 'with one prog as hash' do
    context 'with no facts' do
      it { is_expected.to run.with_params('program1', '1.0').and_return(false) }
    end
  end

  context 'with mutliple programs' do
    context 'with another fact version' do
      let(:facts){
        {
          :package_program1_version => '1.1',
          :package_program2_version => '1.1'
        }
      }
      it { is_expected.to run.with_params({'program1' => '1.0', 'program2' => '1.0'}).and_return(false) }
    end

    context 'with another fact version for one prog' do
      let(:facts){
        {
          :package_program1_version => '1.0',
          :package_program2_version => '1.1'
        }
      }
      it { is_expected.to run.with_params({'program1' => '1.0', 'program2' => '1.0'}).and_return(false) }
    end

    context 'with another fact version for one prog round 2' do
      let(:facts){
        {
          :package_program1_version => '1.1',
          :package_program2_version => '1.0'
        }
      }
      it { is_expected.to run.with_params({'program1' => '1.0', 'program2' => '1.0'}).and_return(false) }
    end

    context 'with same fact version' do
      let(:facts){
        {
          :package_program1_version => '1.0',
          :package_program2_version => '1.0'
        }
      }
      it { is_expected.to run.with_params({'program1' => '1.0', 'program2' => '1.0'}).and_return(true) }
    end
  end
end
