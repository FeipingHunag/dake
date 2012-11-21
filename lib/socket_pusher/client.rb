# encoding: utf-8
require "socket"

module SocketPusher
  class Client
    attr_accessor  :host, :port
    attr_reader :socket

    def initialize(options = {})
      options = {
        :host => 'localhost',
        :port => 8080,
      }.merge(options)
      @host, @port = options.values_at(
        :host, :port
      )
    end


    def post data
      write do |sc|
        sc.write data
      end
    end

    def channel(channel_name)
      raise ConfigurationError, 'Missing client configuration' unless configured?
      Channel.new(channel_name, self)
    end

    def configured?
      host && port
    end

    alias :[] :channel

    private
    def establish_connection
      @socket = TCPSocket.open host, port if @socket.nil? or @socket.closed?
    end

    def write
      begin
        establish_connection
        yield @socket
      rescue IOError, Errno::EPIPE
        establish_connection
        retry
      end
    end
  end
end
