#
# Cookbook Name:: cog_samhain
# Recipe:: default
#
# Copyright 2015, Cash On Go Ltd
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/root/samhain-#{node['cog_samhain']['samhain_version']}.tar.gz" do
  source "samhain-#{node['cog_samhain']['samhain_version']}.tar.gz"
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'Extract samhain source' do
  command "tar zxf /root/samhain-#{node['cog_samhain']['samhain_version']}.tar.gz"
  cwd '/root'
  not_if {  ::File.exists?("/root/samhain-#{node['cog_samhain']['samhain_version']}/configure") }
end

node['cog_samhain']['packages'].each do |pkg|
  package pkg
end

template "/root/samhain_build_options" do
  owner "root"
  group "root"
  mode "0644"
  source "oneliner.erb"
  variables({
    :line => node['cog_samhain']['samhain_build_options']
    })
  notifies :create,"file[rebuild_samhain]",:immediately
end

file "rebuild_samhain" do
  action :nothing
  owner "root"
  group "root"
  mode "0600"
  path "/root/rebuild_samhain"
end

execute 'Configure Samhain Server source' do
  cwd "/root/samhain-#{node['cog_samhain']['samhain_version']}"
  command "./configure #{node['cog_samhain']['samhain_build_options']}"
  not_if { File.exists?("/root/samhain-#{node['cog_samhain']['samhain_version']}/config.log") && !File.exists?('/root/rebuild_samhain') }
end

execute 'Build samhain' do
  cwd "/root/samhain-#{node['cog_samhain']['samhain_version']}"
  command 'make'
  not_if { File.exists?("/root/samhain-#{node['cog_samhain']['samhain_version']}/samhain") && !File.exists?('/root/rebuild_samhain') }
end

execute 'Install samhain' do
  cwd "/root/samhain-#{node['cog_samhain']['samhain_version']}"
  command 'make install'
  environment ({ 'LC_ALL' => 'POSIX'})
  not_if { File.exists?("/usr/local/sbin/samhain") && FileUtils.identical?("/usr/local/sbin/samhain","/root/samhain-#{node['cog_samhain']['samhain_version']}/samhain")}
  notifies :restart,'service[samhain]',:delayed
end

cookbook_file '/etc/samhainrc' do
  action :create
  source 'samhainrc'
  owner 'root'
  group 'root'
  mode '0600'
  notifies :run,'execute[reload-samhain]',:delayed
end

file "/etc/init.d/samhain" do
  owner 'root'
  group 'root'
  mode 0755
  content lazy  { ::File.open("/root/samhain-#{node['cog_samhain']['samhain_version']}/init/samhain.startLinux").read }
  action :create
end

execute "Samhain initialize database" do
  command "samhain -t init --foreground"
  action :run
  not_if { File.exists?("/var/lib/samhain/samhain_file")}
end

service "samhain" do
  service_name "samhain"
  action [:enable, :start]
end

execute "reload-samhain" do
  action :nothing
  command '/usr/local/sbin/samhain reload'
  returns [0,7]
end

file "rebuild_samhain" do
  action :delete
  owner "root"
  group "root"
  mode "0600"
  path "/root/rebuild_samhain"
end
