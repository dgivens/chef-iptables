include_recipe 'iptables'

iptables_ipv4_chain 'CHAIN_V4'
iptables_ipv6_chain 'CHAIN_V6'

iptables_ipv4_rule 'rule_v4' do
  chain 'CHAIN_V4'
  source '1.1.1.1'
  destination '2.2.2.2'
  port '1111'
  protocol 'tcp'
  interface 'eth0'
  action 'reject'
end

iptables_ipv6_rule 'rule_v6' do
  chain 'CHAIN_V6'
  source '2001:1234::1'
  destination '2001:1234::2'
  port '1111'
  protocol 'tcp'
  interface 'eth0'
  action 'reject'
end
