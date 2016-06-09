package 'rsync'

if node['artifactory']['install_java']
  node.set['java']['jdk_version'] = 8
  include_recipe 'java'
end

remote_file "#{Chef::Config[:file_cache_path]}/artifactory-#{node['artifactory']['version']}.rpm" do
  source node['artifactory']['url']
  not_if 'rpm -ql artifactory'
end

yum_package 'artifactory' do
  source "#{Chef::Config[:file_cache_path]}/artifactory-#{node['artifactory']['version']}.rpm"
  action :install
  not_if 'rpm -ql artifactory'
end

service 'artifactory' do
  supports start: true, stop: true, restart: true, status: true
  action [:enable, :start]
end

template "#{node['artifactory']['home']}/tomcat/conf/server.xml" do
  mode 00644
  notifies :restart, 'service[artifactory]'
end

