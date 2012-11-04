class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages ,id: false do |t|
      t.integer :id, limit: 8,  null: false
      t.integer :user_id, limit: 8,  null: false
      t.integer :message_type, default: 0
      t.text :content

      t.timestamps
    end
    
    execute  <<-SQL
      ALTER TABLE messages ADD PRIMARY KEY (id);
      ALTER TABLE messages ALTER id SET DEFAULT next_id();
    SQL

    add_index :messages, :message_type
    add_index :messages, :user_id
  end
end
