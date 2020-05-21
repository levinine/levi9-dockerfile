require 'spec_helper_acceptance'

describe 'plain config test' do
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

  it 'file exists test' do
    idempotent_apply(pp)
    expect(file("/tmp/Multistage2")).to be_file
  end
end