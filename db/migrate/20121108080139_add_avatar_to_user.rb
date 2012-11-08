class AddAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :string, :string
  end
end
