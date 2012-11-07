class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages ,id: false do |t|
      t.integer :id, limit: 8,  null: false
      t.integer :user_id, limit: 8,  null: false
      t.integer :mtype, default: 0
      t.references :received_messageable, polymorphic: true, limit: 8
      t.boolean :opened, :default => false
      t.text :content

      t.timestamps
    end
    
    execute  <<-SQL
      ALTER TABLE messages ADD PRIMARY KEY (id);
      ALTER TABLE messages ALTER id SET DEFAULT next_id();
    SQL

    add_index :messages, :received_messageable_id
    add_index :messages, :user_id
  end
end
