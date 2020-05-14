# frozen_string_literal: true

require 'spec_helper'
require 'hiera'

describe 'dockerfile' do
  hiera = Hiera.new(config: 'spec/fixtures/hiera.yaml')
  config = hiera.lookup('dockerfile::configs', nil, nil)
  config.each do |title, _params|
    context "title #{title}" do
      it { is_expected.to compile }
    end
  end
end
