define :iptables_ipv4_rule, :chain => 'INPUT', :source => nil, :destination => nil, :port => nil, :protocol => nil, :interface => nil, :action => 'ACCEPT' do
  execute 'iptables_restore' do
    command '/etc/network/if-pre-up.d/iptables'
    action :nothing
  end

  t = nil
  begin
    t = resources(:template => '/etc/network/iptables')
  rescue Chef::Exceptions::ResourceNotFound
    t = template '/etc/network/iptables' do
      cookbook 'iptables'
      source 'iptables.erb'
      owner 'root'
      group 'root'
      mode '0600'
      variables({
        :rules => {},
        :chains => []
      })
      notifies :run, 'execute[iptables_restore]', :delayed
    end
  end

  if not t.variables[:rules].has_key?(params[:name])
    t.variables[:rules][params[:name]] = {}
  end
  t.variables[:rules][params[:name]] = {
    :chain => params[:chain],
    :source => params[:source],
    :destination => params[:destination],
    :port => params[:port],
    :protocol => params[:protocol],
    :interface => params[:interface],
    :action => params[:action]
  }
end
