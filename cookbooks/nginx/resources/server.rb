property :role, String, default: 'app-role'
property :detach_server, String, default: '10.0.0.100'

action :attach do
  upstreampcs = ''
  search(:node, 'role:app-role').each do |node|
    print node['ipaddress']
    upstreampcs += "server #{node[:network][:interfaces][:enp0s8][:addresses].detect{|k,v| v[:family] == 'inet' }.first}:8090; "
  end

  nginxip = node[:network][:interfaces][:enp0s8][:addresses].detect{|k,v| v[:family] == 'inet' }.first
  template '/etc/nginx/nginx.conf' do
    source "nginx.conf.erb"
    variables( server_list: upstreampcs,
               nginx_server: nginxip)
  end

  service 'nginx' do
    action [:restart]
  end
end

action :detach do
  bash 'del' do
    code <<-EOH
      sed -i '/#{detach_server}/d' /etc/nginx/nginx.conf
      EOH
  end
  service 'nginx' do
    action [:restart]
  end
end
