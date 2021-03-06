define :iptables_ipv4_chain do
  execute 'iptables_restore' do
    command '/etc/network/if-pre-up.d/iptables'
    action :nothing
  end

  t = nil
  begin
    t = resources(:template => '/etc/network/iptables')
  rescue Chef::Exceptions::ResourceNotFound
    t = template "/etc/network/iptables" do
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

  if not t.variables[:chains].include? params[:name]
    t.variables[:chains] << params[:name]
  end
end
