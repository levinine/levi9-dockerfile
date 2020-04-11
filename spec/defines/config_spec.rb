# frozen_string_literal: true

require 'spec_helper'

describe 'dockerfile::config' do
  hiera = Hiera.new(:config => 'spec/fixtures/hiera.yaml')

  config = hiera.lookup('dockerfile::configs', nil, nil)

  config.each do |title, params|
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }
        let(:title) { title }
        let(:params) { params }
        it { is_expected.to compile }
      end
    end
  end
end
