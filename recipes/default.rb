#
# Cookbook Name:: heat-iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rack_nets = [
  # WSG
  "50.56.228.96/28",
  "50.56.230.136/29",
  "72.32.146.48/29",
  "198.61.154.80/29",
  # VPN
  "72.32.115.224/28",
  "50.57.17.240/28",
  # SAT6 Cloud
  "50.57.17.24",
  # AUS2 Rackers
  "50.56.230.33",
  # inova,
  "74.205.117.244",
  # Jenkins
  "198.101.131.60"
]

ops_node = partial_search(:node, "role:ops-node AND chef_environment:#{node.chef_environment}", :keys => {'ip' => ['cloud', 'public_ipv4']})
ops_node_ip = ops_node.first ? ops_node.first['ip'] : nil

template '/etc/network/iptables' do 
    source 'iptables.erb'
    owner 'root'
    group 'root'
    mode 00600
    variables :rack_nets => rack_nets, :ops_node => ops_node_ip
    action :create
    notifies :run, 'execute[iptables_restore]', :delayed
end

template '/etc/network/ip6tables' do 
    source 'ip6tables.erb'
    owner 'root'
    group 'root'
    mode 00600
    action :create
    notifies :run, 'execute[ip6tables_restore]', :delayed
end

cookbook_file '/etc/network/if-pre-up.d/iptables' do
    source "iptables"
    owner 'root'
    group 'root'
    mode 00700
    action :create
end

cookbook_file '/etc/network/if-pre-up.d/ip6tables' do
    source "ip6tables"
    owner 'root'
    group 'root'
    mode 00700
    action :create
end

execute 'iptables_restore' do
    command "/etc/network/if-pre-up.d/iptables"
    action :nothing
end


execute 'ip6tables_restore' do
    command "/etc/network/if-pre-up.d/ip6tables"
    action :nothing
end