#
# Cookbook:: postgres
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#following the instructions on https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-centos-7

package %w(postgresql-server postgresql-contrib) do 
  action :install
end

#initialize the cluster
execute 'initialize-the-cluster' do
    command 'postgresql-setup initdb'
end

#change password for postgres user
#Monday123

user 'postgres' do
  action :modify
  home '/home/postgres'
  password '$1$0TD5SSvm$CmA78zrARJsx15I9anLEC/'
end

#update pg_hba.conf from template, restart pgsql when template is loaded
template '/var/lib/pgsql/data/pg_hba.conf' do
  action :create
  source 'pg_hba.conf.erb'
  notifies :restart, 'service[postgresql]'
end

#start and enable service on startup
service "postgresql" do
  action [ :enable, :start ]
end 

#add postgresql.conf template
template '/var/lib/pgsql/data/postgresql.conf' do
  action :create
  source 'postgresql.conf.erb'
  notifies :restart, 'service[postgresql]'
end


#add attributes
#add databags
