#
# Cookbook Name:: mcollective
# Attributes:: default
#
# Copyright 2011, Zachary Stevens
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Specify a version to install, or leave nil for latest
default['mcollective']['package']['version'] = nil

# Security provider plugin - psk/ssl/aes_security
default['mcollective']['securityprovider'] = "psk"

# The key for the psk security provider
default['mcollective']['psk'] = "unset"

# Connector plugin - activemq/rabbitmq/stomp
default['mcollective']['connector']         = "activemq"

# Use direct addressing?  Not supported on all connector plugins
# (see the MCollective documentation)
default['mcollective']['direct_addressing'] = "y"

# RabbitMQ details (used by rabbitmq connector)
default['mcollective']['rabbitmq']['vhost'] = "/"

# STOMP server details (used by stomp, rabbitmq and activemq connectors)
default['mcollective']['stomp']['hostname'] = "localhost"
default['mcollective']['stomp']['port'] = "6163"
default['mcollective']['stomp']['username'] = "mcollective"
default['mcollective']['stomp']['password'] = "marionette"

default['mcollective']['stomp']['ssl']['enabled'] = false
default['mcollective']['stomp']['ssl']['port'] = "6164"
default['mcollective']['stomp']['ssl']['ca'] = "/etc/ssl/certs/cacert.pem"
default['mcollective']['stomp']['ssl']['cert'] = "/etc/ssl/certs/cert.pem"
default['mcollective']['stomp']['ssl']['key'] = "/etc/ssl/certs/key.pem"
default['mcollective']['stomp']['ssl']['fallback'] = false

# MCollective Identity and collective membership
default['mcollective']['identity']        = node['fqdn']
default['mcollective']['main_collective'] = "mcollective"
default['mcollective']['collectives']     = "mcollective"

# Logging
default['mcollective']['logfile'] = "/var/log/mcollective.log"
default['mcollective']['loglevel'] = "info"

# Locations
default['mcollective']['site_plugins'] = "/etc/mcollective/site_plugins/mcollective"
default['mcollective']['plugin_conf'] = "/etc/mcollective/plugin.d"

# Fact Source
# The default option configures MCollective to read a YAML file
# produced by a Chef handler, containing a configurable list of
# facts.  This gives the best MCollective performance, at the cost of
# less fresh data (updated only as frequently as you run Chef).
#
# Set this to 'ohai' to instead use the opscodeohai MCollective Fact
# plugin.
default['mcollective']['factsource']    = 'yaml'
default['mcollective']['yaml_factfile'] = '/etc/mcollective/facts.yaml'

default['mcollective']['classesfile']   = '/var/tmp/chefnode.txt'

# Ohai keys to include in the YAML fact list.
default['mcollective']['fact_whitelist'] = [
                                            'fqdn',
                                            'hostname',
                                            'domain',
                                            'ipaddress',
                                            'macaddress',
                                            'os',
                                            'os_version',
                                            'platform',
                                            'platform_version',
                                            'ohai_time',
                                            'uptime',
                                            'uptime_seconds',
                                            'chef_packages',
                                            'keys',
                                            'instmaint',
                                            'virtualization',
                                            'cpu',
                                            'memory'
                                           ]

# MCollective plugin location (created by the packages)
case platform_family
when "debian"
  default['mcollective']['libdir'] = "/usr/share/mcollective/plugins"
when "rhel","fedora"
  default['mcollective']['libdir'] = "/usr/libexec/mcollective"
end

## Cookbook plumbing
# Recipe used to install common components
default['mcollective']['recipes']['install_common'] = 'mcollective::_install_common_pkg'
# Recipe used to install server components
default['mcollective']['recipes']['install_server'] = 'mcollective::_install_server_pkg'
# Recipe used to install client components
default['mcollective']['recipes']['install_client'] = 'mcollective::_install_client_pkg'
# Whether to enable the puppetlabs apt/yum repo when installing from packages.
default['mcollective']['enable_puppetlabs_repo'] = true

