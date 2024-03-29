God.watch do |w|
 w.name     = "faye-server-0"
 w.group    = "bigblue-faye"
 w.interval = 30.seconds
 w.log      = File.join(RAILS_ROOT, 'log', "#{w.name}.god.log")
 w.uid      = 'rails'
 w.gid      = 'rails'
 w.env      = { 'RAILS_ENV' => RAILS_ENV }
 w.dir      = RAILS_ROOT
 w.start    = "bundle exec rackup faye.ru -E production"

 # restart if memory gets too high
 w.transition(:up, :restart) do |on|
   on.condition(:memory_usage) do |c|
     c.above = 300.megabytes
     c.times = 2
   end
 end

 # determine the state on startup
 w.transition(:init, { true => :up, false => :start }) do |on|
   on.condition(:process_running) do |c|
     c.running = true
   end
 end

 # determine when process has finished starting
 w.transition([:start, :restart], :up) do |on|
   on.condition(:process_running) do |c|
     c.running = true
     c.interval = 5.seconds
   end

   # failsafe
   on.condition(:tries) do |c|
     c.times = 5
     c.transition = :start
     c.interval = 5.seconds
   end
 end

 # start if process is not running
 w.transition(:up, :start) do |on|
   on.condition(:process_running) do |c|
     c.running = false
   end
 end
end