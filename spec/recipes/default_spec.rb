require_relative '../spec_helper'

describe 'iptables::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'creates cookbook_file[/etc/network/if-pre-up.d/iptables]' do
    expect(chef_run).to create_cookbook_file('/etc/network/if-pre-up.d/iptables').with(
      owner: 'root',
      group: 'root',
      mode: '0755'
    )
  end

  it 'creates cookbook_file[/etc/network/if-pre-up.d/ip6tables]' do
    expect(chef_run).to create_cookbook_file('/etc/network/if-pre-up.d/ip6tables').with(
      owner: 'root',
      group: 'root',
      mode: '0755'
    )
  end
end
