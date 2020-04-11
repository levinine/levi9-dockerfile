# frozen_string_literal: true

require 'spec_helper'
require 'hiera'

describe 'dockerfile::config::plain' do
  hiera = Hiera.new(:config => 'spec/fixtures/hiera.yaml')

  configs = hiera.lookup('dockerfile::configs', nil, nil)
  configs.each do |title, config|


    if config['type'] == 'plain' then
      dockerfile = config['home'] + "/" + config['dockerfile_name']
      params = {
          'dockerfile' => dockerfile,
          'conf' => config['conf'],
      }
      let(:title) { title }
      let(:params) { params }

      on_supported_os.each do |os, os_facts|
        context "on #{os}" do
          let(:facts) { os_facts }
          let(:title) { title }
          let(:params) { params }
          it { is_expected.to compile }
          it do
            is_expected.to contain_file(dockerfile)
          end
        end
      end
    end
  end
end
