#
# Cookbook:: jboss
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'
require 'chefspec'
require 'chefspec/berkshelf'

=begin 
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
=end

describe 'jboss::default' do
  let(:chef_run)do
    runner =  ChefSpec::SoloRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe) 
  end

  before do
    stub_data_bag_item("sumka", "jb_port").and_return("id": "akoport", "port": "8090")
  end

  it 'Converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'Adds server.xml template' do
    expect(chef_run).to create_template('/opt/jboss/server/default/deploy/jbossweb.sar/server.xml').with(
      source: 'server.xml.erb',
      user: 'jboss',
      group: 'jboss'
    )
  end

  it 'Adds service for jboss' do
    expect(chef_run).to create_systemd_unit('jboss.service')
  end
  
end
