#
# Cookbook Name:: iptables
# Attributes:: default
#

default[:iptables][:allow_ping] = true
default[:iptables][:internal_iface] = ['eth2']
default[:iptables][:ipv4] = {
  :filter => {
    :input => {
      :policy => 'ACCEPT',
      :rules => []
    },
    :forward => {
      :policy => 'ACCEPT',
      :rules => []
    },
    :output => {
      :policy => 'ACCEPT',
      :rules => []
    }
  }
}
default[:iptables][:ipv6] = {
  :filter => {
    :input => {
      :policy => 'ACCEPT',
      :rules => []
    },
    :forward => {
      :policy => 'ACCEPT',
      :rules => []
    },
    :output => {
      :policy => 'ACCEPT',
      :rules => []
    }
  }
}

# Example rule
#
# default['iptables']['tables']['filter']['input']['rules'] = [{'interface' => 'eth0', 'source' => '192.168.1.0/24', 'destination' => '192.168.2.0/24', 'dport' => '80', 'proto' => 'tcp', 'action' => 'ACCEPT'}]