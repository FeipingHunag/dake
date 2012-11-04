class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients, id: false do |t|
      t.integer :id, limit: 8,  null: false
      t.integer :message_id, limit: 8,  null: false
      t.integer :message_recipientable_id, limit: 8,  null: false
      t.string :message_recipientable_type

      t.timestamps
    end

    execute  <<-SQL
      ALTER TABLE message_recipients ADD PRIMARY KEY (id);
      ALTER TABLE message_recipients ALTER id SET DEFAULT next_id();
    SQL

    add_index :message_recipients, :message_id
    add_index :message_recipients, [:message_recipientable_id, :message_recipientable_type],
                                   name: :recipient_id_and_type
    add_index :message_recipients, [:message_id, :message_recipientable_id, :message_recipientable_type],
                                   name: :message_recipient_id_and_type, unique: true
  end
end
