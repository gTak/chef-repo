#
# Cookbook Name:: apiserver
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#log "Hello World!"

package "vim-enhanced" do
  action :install
end

service "iptables" do
  action [:stop, :disable]
end

%w{php mysql-server httpd}.each do |p|
  package p do
    action :install
  end
end

service "httpd" do
  action [:start, :enable]
end

template "httpd.conf" do
  path "/etc/httpd/conf/httpd.conf"
  source "httpd.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]'
end

