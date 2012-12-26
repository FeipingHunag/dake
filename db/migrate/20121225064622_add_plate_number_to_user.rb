class AddPlateNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :plate_number, :string
  end
end
