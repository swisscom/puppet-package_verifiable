require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'verify_package_versions', :type => 'puppet_function' do
  before(:each) do
    Puppet::Parser::Functions.function(:verify_package_versions)
  end

  context 'with no arguments' do
    it { expect { subject.call([]) }.to raise_error(Puppet::ParseError) }
  end

  context 'with one prog' do
    context 'with no facts' do
      it { subject.call(['program1', '1.0']).should be_falsy }
    end
    #TODO: facts are currently not working in rspec-puppet, no easy
    #workaround found ->
    context 'with another fact version' do
      let(:facts){
        {
          :package_program1_version => '1.1'
        }
      }
      it { subject.call([{'program1' => '1.0'}]).should be_falsy }
    end

    context 'with same fact version' do
      let(:facts){
        {
          :package_program1_version => '1.0'
        }
      }
      it { subject.call([{'program1' => '1.0'}]).should be_truthy }
    end
  end

  context 'with one prog as hash' do
    context 'with no facts' do
      it { subject.call(['program1', '1.0']).should be_falsy }
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
      it { subject.call([{'program1' => '1.0', 'program2' => '1.0'}]).should be_falsy }
    end

    context 'with another fact version for one prog' do
      let(:facts){
        {
          :package_program1_version => '1.0',
          :package_program2_version => '1.1'
        }
      }
      it { subject.call([{'program1' => '1.0', 'program2' => '1.0'}]).should be_falsy }
    end

    context 'with another fact version for one prog round 2' do
      let(:facts){
        {
          :package_program1_version => '1.1',
          :package_program2_version => '1.0'
        }
      }
      it { subject.call([{'program1' => '1.0', 'program2' => '1.0'}]).should be_falsy }
    end

    context 'with same fact version' do
      let(:facts){
        {
          :package_program1_version => '1.0',
          :package_program2_version => '1.0'
        }
      }
      it { subject.call([{'program1' => '1.0', 'program2' => '1.0'}]).should be_truthy }
    end
  end
end
