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

web_server 'attach_nginx' do
  action [:attach]
end

#web_server 'test-detach' do
  #del_server '192.168.44.49'
  #action [:detach]
#end
