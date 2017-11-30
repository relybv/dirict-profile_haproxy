if ENV['BEAKER'] == 'true'
  # running in BEAKER test environment
  require 'spec_helper_acceptance'
else
  # running in non BEAKER environment
  require 'serverspec'
  set :backend, :exec
end

describe 'profile_haproxy class' do

  context 'default parameters' do
    if ENV['BEAKER'] == 'true'
      # Using puppet_apply as a helper
      it 'should work  with no errors' do
        pp = <<-EOS
        class { 'profile_haproxy': }
        EOS

        # Run it and test for errors
        apply_manifest(pp, :catch_failures => true)
      end
    end

    describe package('haproxy') do
      it { is_expected.to be_installed }
    end

    describe service('haproxy') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(80) do
      it { should be_listening.with('tcp') }
    end

    describe port(443) do
      it { should be_listening.with('tcp') }
    end

    describe port(9090) do
      it { should be_listening.with('tcp') }
    end

  end
end
