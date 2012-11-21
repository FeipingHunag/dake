class PushData < BinData::Record
  uint32be :len
  string :content, :read_length => :len
end
# 
# Pusher["channel_name"].trigger('event_name', json_string)
# 
# def pusher channel_name, event_name, user_info
#   hash = {}
#   hash[:data_type] = "trigger_channel"
#   hash[:cname] = channel_name
#   hash[:ename] = event_name
#   hash[:user_info] = user_info
#   return hash.to_json
# end
# 
# json = aModel.to_json
# 
# data = PushData.new
# data.content = json
# data.len = json.bytesize
# 
# s = TCPSocket.new 'localhost', 8080
# s.write d.to_binary_s
# s.close