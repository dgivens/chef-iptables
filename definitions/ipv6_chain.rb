define :heat_iptables_ipv6_chain do
  execute 'ip6tables_restore' do
    command "/etc/network/if-pre-up.d/ip6tables"
    action :nothing
  end

  t = nil
  begin
    t = resources(:template => "/etc/network/ip6tables")
  rescue Chef::Exceptions::ResourceNotFound
    t = template "/etc/network/ip6tables" do
      cookbook 'heat-iptables'
      source 'ip6tables.erb'
      owner 'root'
      group 'root'
      mode '0600'
      variables({
        :rules => {},
        :chains => []
      })
      notifies :run, 'execute[ip6tables_restore]', :delayed
    end
  end

  if not t.variables[:chains].include? params[:name]
    t.variables[:chains] << params[:name]
  end
end
