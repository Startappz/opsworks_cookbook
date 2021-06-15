#
# Cookbook:: OpsWorks
# Recipe:: php
#
# Copyright:: 2018, Moayyad Faris, All Rights Reserved.



apt_repository 'php7.4' do
  uri          'ppa:ondrej/php'
end

apt_update 'update'

package "php7.4" do
  action :install
end

package "php-pear" do
  action :install
end

package "php7.4-curl" do
  action :install
end

package "php7.4-mysql" do
  action :install
end

apt_package "php7.4-fpm" do
  action :install
end


apt_package "php7.4-mbstring" do
  action :install
end

apt_package "php7.4-zip" do
  action :install
end

apt_package "php7.4-xml" do
  action :install
end

apt_package "imagemagick" do
  action :install
end

apt_package "php7.4-imagick" do
  action :install
end

apt_package "php7.4-gd" do
  action :install
end




# cookbook_file "/etc/php/7.0/cli/php.ini" do
#   source "php.ini"
#   mode "0644"
#   notifies :restart, "service[apache2]"
# end


execute "chownlog" do
  command "chown www-data /var/log/php"
  action :nothing
end

directory "/var/log/php" do
  action :create
  notifies :run, "execute[chownlog]"
end