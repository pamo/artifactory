default['artifactory']['version'] = '4.8.0'
default['artifactory']['url'] = "https://dl.bintray.com/jfrog/artifactory-pro-rpms/org/artifactory/pro/rpm/jfrog-artifactory-pro/#{node['artifactory']['version']}/jfrog-artifactory-pro-#{node['artifactory']['version']}.rpm"

default['artifactory']['home'] = '/var/opt/jfrog/artifactory'
default['artifactory']['log_dir'] = '/var/opt/jfrog/artifactory/logs'
default['artifactory']['catalina_base'] = ::File.join(artifactory['home'], 'tomcat')
default['artifactory']['java']['xmx'] = '1g'
default['artifactory']['java']['xms'] = '512m'
default['artifactory']['java']['extra_opts'] = '-XX:+UseG1GC'

default['artifactory']['user'] = 'artifactory'
default['artifactory']['port'] = 8081
default['artifactory']['shutdown_port'] = 8015
default['artifactory']['install_java'] = true

default['artifactory']['use_ajp'] = false
default['artifactory']['ajp']['port'] = 8019
default['artifactory']['ajp']['maxThreads'] = 500
default['artifactory']['ajp']['minSpareThreads'] = 20
default['artifactory']['ajp']['enableLookups'] = false
default['artifactory']['ajp']['backlog'] = 100
