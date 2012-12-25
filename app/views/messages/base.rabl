attributes :id, :user_id, :mtype, :content, :timestamp
node(:str_user_id) {|m| m.user_id.to_s}