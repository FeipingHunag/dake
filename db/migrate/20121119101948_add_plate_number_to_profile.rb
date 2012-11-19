class AddPlateNumberToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :plate_number, :string
  end
end
