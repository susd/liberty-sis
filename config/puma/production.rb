app = 'libertysis'
bind "unix:///srv/rails/#{app}/current/tmp/sockets/puma.sock"
pidfile "/srv/rails/#{app}/current/tmp/pids/puma"
state_path "/srv/rails/#{app}/current/tmp/pids/puma_state"
environment 'production'
rackup "/srv/rails/#{app}/current/config.ru"
activate_control_app
