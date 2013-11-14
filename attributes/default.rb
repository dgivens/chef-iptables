#
# Cookbook Name:: heat-iptables
# Attributes:: default
#

default[:heat_iptables][:allow_ping] = true
default[:heat_iptables][:internal_iface] = ['eth2']
default[:heat_iptables][:ipv4] = {
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
default[:heat_iptables][:ipv6] = {
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
# default['heat-iptables']['tables']['filter']['input']['rules'] = [{'interface' => 'eth0', 'source' => '192.168.1.0/24', 'destination' => '192.168.2.0/24', 'dport' => '80', 'proto' => 'tcp', 'action' => 'ACCEPT'}]