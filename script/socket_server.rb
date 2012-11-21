# encoding: utf-8
# samle server
require 'socket'

server = TCPServer.open(2000)  # Socket to listen on port 2000
client = server.accept       # Wait for a client to connect
puts client.to_s
loop {                         # Servers run forever
  puts client.read(32)
  sleep 1
}
