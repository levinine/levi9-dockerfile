# frozen_string_literal: true

require 'spec_helper'

describe 'dockerfile::config::stage' do
  hiera = Hiera.new(:config => 'spec/fixtures/hiera.yaml')

  configs = hiera.lookup('dockerfile::configs', nil, nil)
  configs.each do |multistage, config|

    if config['type'] == 'multistage' then
      dockerfile = config['home'] + "/" + config['dockerfile_name']
      stages = config['conf']
      stages.each do |name, stage|
        title = multistage + "-" + name
        params = {
            'dockerfile' => dockerfile,
            #         'conf' => config['conf'],
        }
        let(:title) { title }
        let(:params) { params }

        context "title #{title}" do

          let(:title) { title }
          # let(:params) { params }
          it { is_expected.to compile }
          it do
            is_expected.to contain_concat__fragment(title)
          end
        end
      end
    end
  end
end

