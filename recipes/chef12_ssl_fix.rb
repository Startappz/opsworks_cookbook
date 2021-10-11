# https://github.com/ajgon/opsworks_ruby/issues/268
link '/opt/chef/embedded/ssl/certs/cacert.pem' do
  to '/etc/ssl/certs/ca-certificates.crt'
end