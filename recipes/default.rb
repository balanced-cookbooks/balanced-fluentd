include_recipe 'td-agent'

directory node['balanced-fluentd']['log_dir'] do
  owner node['balanced-fluentd']['user']
  group node['balanced-fluentd']['group']
  mode '0775'
end

# death to the infidels, they do not know how to clone a hash
base_options = Hash[node['balanced-fluentd'].to_a]

node['balanced-fluentd']['sources'].each do |priority, source, options|
  merged_options = base_options.clone
  merged_options.update(Hash[options.to_a])
  merged_options['variables'] = merged_options
  template "#{node['balanced-fluentd']['config_dir']}/#{priority}-source-#{source}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/source-#{source}.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables merged_options

    notifies :restart, resources(:service => 'td-agent')
  end
end

node['balanced-fluentd']['matches'].each do |priority, match, options|
  merged_options = base_options.clone
  merged_options.update(Hash[options.to_a])
  merged_options['variables'] = merged_options
  template "#{node['balanced-fluentd']['config_dir']}/#{priority}-match-#{match}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/match-#{match}.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables merged_options

    notifies :restart, resources(:service => 'td-agent')
  end
end
