include_recipe 'balanced-monit'

monit_monitrc 'td-agent' do
  template_cookbook 'balanced-monit'
  template_source 'process.monitrc.erb'
  variables({
                :process_name => 'td-agent',
                :process_check => "with pidfile #{node['balanced-fluentd']['pid_file']}",
                :process_start_cmd => '/etc/init.d/td-agent start',
                :process_stop_cmd => '/etc/init.d/td-agent stop',
                :conditions => [
                    {:if_stmt => 'cpu is greater than 50% for 2 cycles', :then_stmt => 'alert'},
                    {:if_stmt => 'cpu > 80% for 5 cycles', :then_stmt => 'restart'},
                    {:if_stmt => '10 restarts within 10 cycles', :then_stmt => 'timeout'}
                ]
            })
end
