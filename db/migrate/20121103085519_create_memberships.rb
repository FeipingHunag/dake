class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id, limit: 8,  null: false
      t.integer :group_id, limit: 8,  null: false
      t.string  :role
      t.timestamps
    end

    add_index :memberships, :user_id
    add_index :memberships, :group_id
    add_index :memberships, [:user_id, :group_id], unique: true
  end
end
