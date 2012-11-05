class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer  :user_id,    limit: 8,  null:false
      t.point :coordinate, :geographic => true
      t.timestamps
    end

    add_index :locations , :user_id,   unique: true
    add_index :locations, :coordinate, :spatial => true
  end
end
