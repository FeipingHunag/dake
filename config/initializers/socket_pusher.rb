require 'socket_pusher'
pusher_config = YAML::load(File.read(File.join(Rails.root.to_s, 'config/socket_pusher.yml')))
# setting pusher with the given env
%w(host port).each do |attr|
  SocketPusher.send("#{attr}=", pusher_config[Rails.env.to_s][attr])
end
