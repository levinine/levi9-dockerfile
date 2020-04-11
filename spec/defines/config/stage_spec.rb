# frozen_string_literal: true

require 'spec_helper'

describe 'dockerfile::config::stage' do
  let(:title) { 'namevar' }
  let(:params) do
    {
        dockerfile: '/tmp/Dockerfile',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it do
        is_expected.to contain_concat_fragment(title)
      end
      context 'with arg =>' do
        let(:params) do
          super().merge({ 'arg' => {'BUILD_NUM' => 'latest' }})
        end

        it { is_expected.to compile }
      end
    end
  end
end
