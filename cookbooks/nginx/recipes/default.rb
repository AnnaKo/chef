#
# Cookbook:: mynginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
end


web_server 'nginx' do
  action [:attach]
end

web_server 'test-detach' do
  del_server '192.168.44.48'
  action [:detach]
end
