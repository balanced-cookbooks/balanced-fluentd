cookbook_file '/home/vagrant/test.py' do
  source 'socket.py'
  owner node['balanced-fluentd']['user']
  group node['balanced-fluentd']['group']
  mode '644'
end
