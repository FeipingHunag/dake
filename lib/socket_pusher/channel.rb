# encoding: utf-8
require "oj"
require "multi_json"
module SocketPusher
  class Channel
    attr_reader :name

    def initialize (name, client = Pusher)
      @name = name
      @client = client
    end

    def trigger event_name, data = {}
      res = {
        'data_type' => 'trigger_channel',
        'cname'     => name,
        'ename'     => event_name,
        'user_info' => (data.is_a?(Hash) ? data : MultiJson.load(data) )
      }
      pd = PushData.new :content => res.to_json
      @client.post pd.to_binary_s
    end
  end
end
