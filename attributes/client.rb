default[:td_agent][:in_http][:enable_api] = false

## messages tagged debug.* are printed to stdout
## everything else is forwarded to the server
#default['balanced-fluentd']['matches'] = [
#    [10, 'debug'], [99, 'forwarding']
#]
#
## messages can be sent via http or syslog
#default['balanced-fluentd']['sources'] = [
#    [20, 'http'], [20, 'syslog']
#]
