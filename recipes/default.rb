#
# Cookbook Name:: heat-iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/etc/network/if-pre-up.d/iptables' do
    source "iptables"
    owner 'root'
    group 'root'
    mode '0700'
    action :create
end

cookbook_file '/etc/network/if-pre-up.d/ip6tables' do
    source "ip6tables"
    owner 'root'
    group 'root'
    mode '0700'
    action :create
end
