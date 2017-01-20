require 'spec_helper'

describe 'profile_haproxy' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir  => "/foo",
            :member_ips      => "127.0.0.1",
            :member_names    => "localhost",
            :monitor_address => "localhost",
          })
        end

        context "profile_haproxy class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_haproxy') }
          it { is_expected.to contain_class('profile_haproxy::config') }
          it { is_expected.to contain_class('profile_haproxy::install') }
          it { is_expected.to contain_class('profile_haproxy::params') }
          it { is_expected.to contain_class('profile_haproxy::service') }

          it { is_expected.to contain_apt__ppa('ppa:vbernat/haproxy-1.6') }

        end
      end
    end
  end
end
