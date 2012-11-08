class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos, :id => false do |t|
      t.integer  :id, :limit => 8, :null => false
      t.integer  :user_id, :limit => 8, :null => false
      t.string   :image
      
      t.datetime :created_at
    end
    
    execute  <<-SQL
      ALTER TABLE photos ADD PRIMARY KEY (id);
      ALTER TABLE photos ALTER id SET DEFAULT next_id();
    SQL
    
    add_index :photos, :user_id
  end
end
