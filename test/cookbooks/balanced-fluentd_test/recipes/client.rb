file '/var/log/balanced.log' do
  mode '0777'
end

%w(fluent-plugin-record-reformer).each do |gem|
  gem_package gem do
    gem_binary '/usr/lib/fluent/ruby/bin/gem'
  end
end
