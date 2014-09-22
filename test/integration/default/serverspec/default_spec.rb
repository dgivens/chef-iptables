require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  end
end

describe "iptables" do
  it "creates ipv4 chain and rule" do
    expect(iptables).to have_rule('-A CHAIN_V4 -s 1.1.1.1 -d 2.2.2.2 -i eth0 -p tcp -m tcp --dport 1111 -j REJECT')
  end

  it "creates ipv6 chain and rule" do
    expect(ip6tables).to have_rule('-A CHAIN_V6 -s 2001:1234::1 -d 2001:1234::2 -i eth0 -p tcp -m tcp --dport 1111 -j REJECT')
  end
end
