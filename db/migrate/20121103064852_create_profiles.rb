class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: false do |t|
      t.integer  :id,        limit: 8,  null: false
      t.integer  :user_id,    limit: 8,  null:false
      t.string   :bio,       limit: 512
      t.string   :education, limit: 32
      
      t.boolean  :gender
      t.date     :dob
      t.integer  :age
      t.integer  :astro_id
      t.integer  :career_id
      t.string   :company
      t.string   :hobby
      t.string   :area

      t.timestamps
    end

    execute  <<-SQL
      ALTER TABLE profiles ADD PRIMARY KEY (id);
      ALTER TABLE profiles ALTER id SET DEFAULT next_id();
    SQL

    add_index :profiles, :user_id,   unique: true
    add_index :profiles, :astro_id,  unique: true
    add_index :profiles, :career_id, unique: true
  end
end
