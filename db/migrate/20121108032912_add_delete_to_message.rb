class AddDeleteToMessage < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.boolean :recipient_delete, :default => false
      t.boolean :sender_delete, :default => false
    end
  end
end
