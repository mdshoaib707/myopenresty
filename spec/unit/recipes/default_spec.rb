#
# Cookbook:: myopenresty
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'myopenresty::default' do
  # context 'When all attributes are default, on an Ubuntu 16.04' do
  describe 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'installs openresty' do
      expect(chef_run).to install_openresty('openresty')
    end
  end

  # context 'When all attributes are default, on an Redhat 7.2' do
  describe 'When all attributes are default, on an Redhat 7.2' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.2')
      runner.converge(described_recipe)
    end

    it 'installs openresty' do
      expect(chef_run).to install_openresty('openresty')
    end
  end
end
