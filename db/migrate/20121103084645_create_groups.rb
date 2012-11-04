class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups, id: false do |t|
      t.integer  :id,  limit: 8,  null: false
      t.string :name
      t.string :photo
      t.text :description

      t.timestamps
    end

    execute  <<-SQL
      ALTER TABLE groups ADD PRIMARY KEY (id);
      ALTER TABLE groups ALTER id SET DEFAULT next_id();
    SQL

  end
end
