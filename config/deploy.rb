set :default_environment, {
  'LANG' => 'en_US.UTF-8'
}
server 'bluebase', :god, :app, :web, :db, :primary => true