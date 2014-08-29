name             'balanced-fluentd'
maintainer       'Balanced'
maintainer_email 'dev@balancedpayments.com'
license          'MIT'
description      'Installs/Configures fluentd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.0'

depends          'td-agent', '~> 0.0.1'
depends          'balanced-monit', '~> 1.0.0'
