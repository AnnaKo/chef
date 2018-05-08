#
# Cookbook:: jboss
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

include_recipe 'java'
package 'unzip'

#add user
user 'jboss' do
  shell '/bin/bash'
end

#download
remote_file './jboss.zip' do
  source 'https://kent.dl.sourceforge.net/project/jboss/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA.zip'
  show_progress true
end

#install
bash 'unarchive' do
  code <<-EAA
    mkdir -p /opt/jboss
    unzip jboss.zip -d /opt
    cp -r /opt/jboss-5.1.0.GA/* /opt/jboss/
    chown -R jboss:jboss /opt/jboss
    EAA
end

#service
systemd_unit 'jboss.service' do
  content <<-EBB
  [Unit]
  Description=Jboss Application Server
  After=network.target

  [Service]
  Type=forking

  User=jboss
  Group=jboss
  ExecStart=/bin/bash -c 'nohup /opt/jboss/bin/run.sh -b 192.168.44.45 &'
  ExecStop=/bin/bash -c 'bin/shutdown.sh -s 192.168.44.45 -u admin'
  TimeoutStartSec=300
  TimeoutStopSec=600
  SuccessExitStatus=143

  [Install]
  WantedBy=multi-user.target
  EBB
  action [ :create, :enable ]
end

#start
service 'jboss' do
  action [ :enable, :start ]
end

#deploy sample app
remote_file '/opt/jboss/server/default/deploy/sample.war' do
  source 'https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war'
end
