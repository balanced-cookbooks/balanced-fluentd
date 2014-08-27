include_recipe 'td-agent'

directory node['balanced-fluentd']['log_dir'] do
  owner node['balanced-fluentd']['user']
  group node['balanced-fluentd']['group']
  mode '0775'
end

log node['balanced-fluentd']['sources']

node['balanced-fluentd']['sources'].each do |priority, source|
  template "#{node['balanced-fluentd']['config_dir']}/#{priority}-source-#{source}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/source-#{source}.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables node['balanced-fluentd']

    notifies :restart, resources(:service => 'td-agent')
  end
end

node['balanced-fluentd']['matches'].each do |priority, match|
  template "#{node['balanced-fluentd']['config_dir']}/#{priority}-match-#{match}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/match-#{match}.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables node['balanced-fluentd']

    notifies :restart, resources(:service => 'td-agent')
  end
end
