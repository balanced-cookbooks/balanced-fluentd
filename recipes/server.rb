include_recipe 'balanced-fluentd'

gem_package 'fluent-plugin-kafka' do
  gem_binary '/usr/lib/fluent/ruby/bin/gem'
end
