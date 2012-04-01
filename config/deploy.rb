set :default_environment, {
  'LANG' => 'en_US.UTF-8'
}
server 'bluebase', :app, :web, :db, :primary => true