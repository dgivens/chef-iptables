define :heat_iptables_ipv6_rule, :chain => 'INPUT', :source => nil, :destination => nil, :port => nil, :protocol => nil, :interface => nil, :action => 'ACCEPT' do
  execute 'ip6tables_restore' do
    command "/etc/network/if-pre-up.d/ip6tables"
    action :nothing
  end

  t = nil
  begin
    t = resources(:template => "/etc/network/ip6tables")
  rescue Chef::Exceptions::ResourceNotFound
    t = template "/etc/network/iptables" do
      cookbook 'heat-iptables'
      source 'ip6tables.erb'
      owner 'root'
      group 'root'
      mode 600
      variables({
        :rules => {},
        :chains => []
      })
      notifies :run, 'execute[ip6tables_restore]', :delayed
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
