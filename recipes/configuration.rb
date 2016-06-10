file "#{node['artifactory']['home']}/etc/artifactory.lic" do
  content node['artifactory']['license']
  owner 'artifactory'
  group 'artifactory'
  mode '0644'
  action :create
  notifies :restart, 'service[artifactory]', :immediately
end
