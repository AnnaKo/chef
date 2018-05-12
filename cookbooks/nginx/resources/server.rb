property :role, String, default: 'app-role'
property :del_server, String, default: '192.168.44.48'

action :attach do
  upstreampcs = ""
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
      sed -i '/#{del_server}/d' /etc/nginx/nginx.conf
      EOH
  end
  service 'nginx' do
    action [:restart]
  end
end
