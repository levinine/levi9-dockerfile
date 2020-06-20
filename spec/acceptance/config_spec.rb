require 'spec_helper_acceptance'

describe 'dockerfile config test' do
  dockerfiles = get_dockerfiles

  before(:all) do
    @basedir = setup_test_directory
  end
  let(:pp) do
    <<-MANIFEST
        include dockerfile
    MANIFEST
  end

  it 'idempotency test' do
    idempotent_apply(pp)
  end

  it 'file exists with content test' do
    idempotent_apply(pp)
    dockerfiles.each { |filename, content|
      expect(file("/#{@basedir}/#{filename}")).to be_file
      expect(file("/#{@basedir}/#{filename}").content).to match (content)
    }
  end
end