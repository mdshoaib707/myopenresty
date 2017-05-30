# property :

default_action :install

action :install do

  node['myopenresty']['prerequisites'].each do |ab|
    package ab do
      action :install
    end
  end

  openresty_ver = 'openresty-1.11.2.2'

  url_loc = "https://openresty.org/download/#{openresty_ver}.tar.gz"

  ark 'openresty-1.11.2.2' do
    url url_loc.to_s
    action :put
    path '/opt/'
  end

  execute 'configure' do
    cwd "/opt/#{openresty_ver}"
    # command "./configure --with-luajit --with-http_ssl_module -j2"
    command node['myopenresty']['configcommand']
  end

  execute 'make and make install' do
    cwd "/opt/#{openresty_ver}"
    command 'make -j2 && make install'
  end

  # replace_or_add 'user' do
  #   path '/usr/local/openresty/nginx/conf/nginx.conf'
  #   pattern 'user*'
  #   line 'user www-data;'
  # end

  replace_or_add 'worker process' do
    path '/usr/local/openresty/nginx/conf/nginx.conf'
    pattern 'worker_processes*'
    line 'worker_processes  auto;'
  end

  if node['platform'] == 'ubuntu' || node['platform'] == 'debian'
    insert_line_after '/usr/local/openresty/nginx/conf/nginx.conf' do
      line 'worker_processes  auto;'
      insert 'user www-data;'
      not_if 'grep "user www-data;" /usr/local/openresty/nginx/conf/nginx.conf'
    end
  end

  insert_line_after '/usr/local/openresty/nginx/conf/nginx.conf' do
    line 'worker_processes  auto;'
    insert 'pid /run/openresty.pid;'
    not_if 'grep "pid /run/openresty.pid;" /usr/local/openresty/nginx/conf/nginx.conf'
  end

  directory '/var/log/openresty' do
    action :create
    recursive true
  end

  cookbook_file '/etc/systemd/system/openresty.service' do
    source 'openresty.service'
  end

  execute 'daemon-reload' do
    command '/bin/systemctl daemon-reload'
  end

  execute 'start-openresty-service' do
    command '/bin/systemctl start openresty.service'
  end
end
