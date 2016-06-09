package 'rsync'

if node['artifactory']['install_java']
  node.set['java']['jdk_version'] = 8
  include_recipe 'java'
end

user node['artifactory']['user'] do
  home node['artifactory']['home']
  manage_home true
  action :create
end

directory node['artifactory']['home'] do
  owner node['artifactory']['user']
  mode 00755
  recursive true
end

directory node['artifactory']['catalina_base'] do
  owner node['artifactory']['user']
  mode 00755
  recursive true
end

%w(work temp).each do |tomcat_dir|
  directory ::File.join(node['artifactory']['catalina_base'], tomcat_dir) do
    owner node['artifactory']['user']
    mode 00755
  end
end

directory node['artifactory']['log_dir'] do
  owner node['artifactory']['user']
  mode 00755
end

remote_file "#{Chef::Config[:file_cache_path]}/artifactory-#{node['artifactory']['install']['version']}.rpm" do
  source node['artifactory']['install']['url']
  not_if 'rpm -ql artifactory'
end

rpm_package 'artifactory' do
  source "#{Chef::Config[:file_cache_path]}/artifactory-#{node['artifactory']['install']['version']}.rpm"
  action :install
  not_if 'rpm -ql artifactory'
end

service 'artifactory' do
  supports start: true, stop: true, restart: true, status: true
  action [:enable, :start]
end

link ::File.join(node['artifactory']['home'], 'webapps') do
  to '/usr/local/artifactory/webapps'
end

link ::File.join(node['artifactory']['catalina_base'], 'logs') do
  to node['artifactory']['log_dir']
end

link ::File.join(node['artifactory']['catalina_base'], 'conf') do
  to '/usr/local/artifactory/tomcat/conf'
end

template '/usr/local/artifactory/tomcat/conf/server.xml' do
  mode 00644
  notifies :restart, 'service[artifactory]'
end

