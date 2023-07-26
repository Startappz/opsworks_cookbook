#
# Cookbook:: OpsWorks
# Recipe:: OpenSSH-9.3p2 
#
# Copyright:: 2023, Nouraldeen Abu Alhassan@StartAppz, All Rights Reserved.
#
# This is only works for Chef v12.1.0 or later
# The installation steps from https://www.linuxfromscratch.org/blfs/view/svn/postlfs/openssh.html

Chef::Log.info("Start installing OpenSSH v9.3p2...")

Chef::Log.info("Install Openssh v9.3p2 dependencies")
package ['wget', 'gcc', 'zlib1g-dev', 'libssl-dev', 'libssl-doc', 'make'] do
    action :install
end


Chef::Log.info("Install Openssh v9.3p2 zipped package")
remote_file "/tmp/openssh-9.3p2.tar.gz" do
    source "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.3p2.tar.gz"
end


execute 'Extract openssh-9.3p2.tar.gz' do
    command 'tar xzvf openssh-9.3p2.tar.gz'
    cwd '/tmp/'
end

execute 'Set group sys & mode 700 for /var/lib/sshd directory' do
    command 'install -v -g sys -m700 -d /var/lib/sshd'
    cwd '/tmp/openssh-9.3p2'
end

execute 'Add group with GID 50 & name sshd' do
    command 'groupadd -g 50 sshd'
end

execute 'Add user with UID 50, name sshd, with group sshd GID 50 & home-dir /var/lib/sshd' do
    command "useradd  -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd"
end

execute 'Run configure file' do
    command './configure --prefix=/usr --sysconfdir=/etc/ssh --with-privsep-path=/var/lib/sshd --with-default-path=/usr/bin --with-superuser-path=/usr/sbin:/usr/bin --with-pid-dir=/run'
    cwd '/tmp/openssh-9.3p2'
end

execute 'Run make' do
    command 'make'
    cwd '/tmp/openssh-9.3p2'
end

execute 'Run make install' do
    command 'make install'
    cwd '/tmp/openssh-9.3p2'
end

execute 'Set mode 755 for contrib/ssh-copy-id & /usr/bin' do
    command 'install -v -m755    contrib/ssh-copy-id /usr/bin'
    cwd '/tmp/openssh-9.3p2'
end

execute 'Set mode 644 contrib/ssh-copy-id.1 & /usr/share/man/man1' do
    command 'install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1'
    cwd '/tmp/openssh-9.3p2'
end

execute 'Set mode 755 /usr/share/doc/openssh-9.3p2' do
    command 'install -v -m755 -d /usr/share/doc/openssh-9.3p2'
    cwd '/tmp/openssh-9.3p2'
end

execute 'Set mode 644 for INSTALL, LICENCE, OVERVIEW, README* && /usr/share/doc/openssh-9.3p2' do
    command 'install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-9.3p2'
    cwd '/tmp/openssh-9.3p2'
end


Chef::Log.info("Finished OpenSSH v9.3p2 Installation...")