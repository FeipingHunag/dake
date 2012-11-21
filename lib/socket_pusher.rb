autoload 'Logger', 'logger'
require 'forwardable'
require 'socket'
require 'socket_pusher/client'

module SocketPusher
  
  class Error < RuntimeError; end
  class ConfigurationError < Error; end

  class << self
    extend Forwardable

    def_delegators :default_client,  :host, :port
    def_delegators :default_client,  :host=, :port=

    def_delegators :default_client, :post
    def_delegators :default_client, :channel, :[]
    def_delegators :default_client, :trigger

    attr_writer :logger
    def logger
      @logger ||= begin
        log = Logger.new($stdout)
        log.level = Logger::INFO
        log
      end
    end

    def default_client
      @client ||= SocketPusher::Client.new
    end
  end
end
require 'socket_pusher/channel'
