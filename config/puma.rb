# config/puma.rb

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      Puma::Configuration::DEFAULTS[:rackup] if defined?(Puma::Configuration::DEFAULTS[:rackup])
port        ENV['PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.connection_pool.with_connection do |conn|
    conn.establish_connection if defined?(ActiveRecord)
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end
