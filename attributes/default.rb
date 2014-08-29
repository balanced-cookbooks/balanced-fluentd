# configs go here
default['td_agent']['includes'] = true
default['td_agent']['default_config'] = false

# NOTE: these are hardcoded in the underlying cookbook, do not change
default['balanced-fluentd']['owner'] = 'td-agent'
default['balanced-fluentd']['group'] = 'td-agent'
default['balanced-fluentd']['config_dir'] = '/etc/td-agent/conf.d'
default['balanced-fluentd']['log_dir'] = '/var/log/fluentd'
default['balanced-fluentd']['pid_file'] = '/var/run/td-agent/td-agent.pid'

# these default ones will log debug.* to stdout (/var/log/td-agent/td-agent.log)
default['balanced-fluentd']['sources'] = [[10, 'debug', {}]]
default['balanced-fluentd']['matches'] = [[10, 'debug', {}]]
default['balanced-fluentd']['services'] = []

# should always match node['td_agent']['in_forward']['port']
default['balanced-fluentd']['in_forward']['port'] = 24224
default['balanced-fluentd']['in_forward']['bind'] = '0.0.0.0'
# requests are forwarded to these servers
default['balanced-fluentd']['in_forward']['servers'] = []

default['balanced-fluentd']['in_http']['port'] = 8080
default['balanced-fluentd']['in_http']['bind'] = '0.0.0.0'

default['balanced-fluentd']['in_syslog']['port'] = 5140
default['balanced-fluentd']['in_syslog']['bind'] = '0.0.0.0'
default['balanced-fluentd']['in_syslog']['tag'] = 'syslog'

# path to socket if used
default['balanced-fluentd']['in_unix']['path'] = nil

default['balanced-fluentd']['in_udp']['port'] = 5160
default['balanced-fluentd']['in_udp']['bind'] = '0.0.0.0'

default['balanced-fluentd']['in_tail']['files'] = []

default['balanced-fluentd']['tail_transforms']['balanced-nginx-access'] = <<-'EOH'.gsub(/\s+/, ' ').strip
  /(?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})
  -
  (?:(?<user>.+)|-)
  \[(?<timestamp>\d{2}\/\w{3}\/\d{4}:\d{2}:\d{2}:\d{2}\s+\+\d{4})\]
  "(?:(?<method>\w+)\s+(?<uri>.+)\s+HTTP\/(?<version>\d\.\d)|-)"
  (?:(?<status>\d+)|-)
  (?:(?<bytes_sent>\d+)|-)
  "(?:(?<referrer>.*?)|-)"
  "(?<user_agent>.*?)"
  (?<request_time>\d+\.\d+)?
  (?:(?:"guru[-_]id=(?:(?<guru_id>.+?)|-)"|"marketplace[-_]id=(?:(?<marketplace_id>.+?)|-)"|"merchant[-_]id=(?:(?<merchant_id>.+?)|-)"|"\w+=.+?"))*/
EOH

default['balanced-fluentd']['tail_transforms']['nginx-error'] = '/^(?<time>[^ ]+ [^ ]+) \[(?<log_level>.*)\] (?<pid>\d*).(?<tid>[^:]*): (?<message>.*)$/'
