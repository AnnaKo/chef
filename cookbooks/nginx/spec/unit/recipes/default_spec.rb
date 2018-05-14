#
# Cookbook:: mynginx
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

=begin
describe 'mynginx::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
=end

describe 'web::default' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'Converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'Install nginx' do
    expect(chef_run).to install_package 'nginx'
  end

  it 'Start nginx' do
    expect(chef_run).to start_service 'nginx'
  end

  it 'Add proxy pass' do
    expect(chef_run).to attach_web_server 'attach_nginx'
  end

  it 'Remove proxy pass' do
    expect(chef_run).to_not detach_web_server 'detach_nginx'
  end

end
