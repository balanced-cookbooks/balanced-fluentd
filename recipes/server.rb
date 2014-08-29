include_recipe 'balanced-fluentd'

%w(fluent-plugin-record-reformer fluent-plugin-kafka).each do |gem|
  gem_package gem do
    gem_binary '/usr/lib/fluent/ruby/bin/gem'
  end
end
