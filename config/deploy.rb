server 'bluebase', :app, :web, :db, :primary => true
set :bundle_cmd, "LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8' bundle"
set :default_environment, {
  'LANG' => 'en_US.UTF-8',
  'PATH' => '/usr/kerberos/sbin:/usr/sbin:/sbin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin'
}