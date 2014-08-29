include_recipe 'td-agent'

directory node['balanced-fluentd']['log_dir'] do
  owner node['balanced-fluentd']['user']
  group node['balanced-fluentd']['group']
  mode '0775'
end

if node['balanced-fluentd']['in_unix']['path']
  directory File.dirname(node['balanced-fluentd']['in_unix']['path']) do
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    mode '0775'
  end
end


# death to the infidels, they do not know how to clone a hash
@base_options = Hash[node['balanced-fluentd'].to_a]

def merge_options(options)
  merged_options = @base_options.clone
  merged_options['node'] = node
  merged_options.update(Hash[options.to_a])
  merged_options['variables'] = merged_options
  merged_options
end

node['balanced-fluentd']['sources'].each do |priority, source, options|
  merged_options = merge_options(options)
  name = merged_options.delete('name')
  template "#{node['balanced-fluentd']['config_dir']}/#{priority}-source-#{name or source}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/source-#{source}.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables merged_options

    notifies :restart, resources(:service => 'td-agent')
  end
end

node['balanced-fluentd']['matches'].each do |priority, match, options|
  merged_options = merge_options(options)
  name = merged_options.delete('name')
  template "#{node['balanced-fluentd']['config_dir']}/#{priority}-match-#{name or match}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/match-#{match}.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables merged_options

    notifies :restart, resources(:service => 'td-agent')
  end
end

node['balanced-fluentd']['services'].each do |name|
  options = merge_options({})
  options[:pattern] = "#{name}.**"
  options[:stores] = [
      [
          's3',
          {
              :AWS_ACCESS_KEY_ID => ENV['AWS_ACCESS_KEY_ID'],
              :AWS_SECRET_ACCESS_KEY => ENV['AWS_SECRET_ACCESS_KEY'],
              :S3_BUCKET_NAME => 'balanced-logs',
              :S3_ENDPOINT => 's3-us-west-1.amazonaws.com',
              :S3_PREFIX => name
          }
      ]
  ]
  template "#{node['balanced-fluentd']['config_dir']}/30-match-#{name}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/match-copy.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables options

    notifies :restart, resources(:service => 'td-agent')
  end
end

node['balanced-fluentd']['in_tail']['files'].each do |file_to_tail|
  template "#{node['balanced-fluentd']['config_dir']}/30-source-#{file_to_tail.name}.conf" do
    source "#{node['balanced-fluentd']['config_dir']}/source-tail.conf.erb"
    owner node['balanced-fluentd']['user']
    group node['balanced-fluentd']['group']
    variables file_to_tail

    notifies :restart, resources(:service => 'td-agent')
  end
end
