# frozen_string_literal: true

require 'spec_helper'
require 'hiera'

describe 'dockerfile::config::plain' do
  hiera = Hiera.new(:config => 'spec/fixtures/hiera.yaml')

  title = 'Plain'
 params = hiera.lookup('dockerfile::configs.' + title + '.conf', nil, nil)
  let(:title) { title }
  let(:params) do
    {
        dockerfile: '/tmp/Dockerfile',
        conf: '',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
