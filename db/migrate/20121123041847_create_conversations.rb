class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations, :id => false do |t|
      t.integer  :id,              :limit => 8, :null => false
      t.integer  :user_id,         :limit => 8, :null => false
      t.integer  :friend_id,       :limit => 8, :null => false
      t.integer  :messages_count,  :default => 0
      t.integer  :unread_count,    :default => 0
      t.integer  :last_message_id, :limit => 8

      t.datetime :updated_at
    end

    execute  <<-SQL
      ALTER TABLE conversations ADD PRIMARY KEY (id);
      ALTER TABLE conversations ALTER id SET DEFAULT next_id();
    SQL

    add_index :conversations, :user_id
    add_index :conversations, :friend_id
  end
end
