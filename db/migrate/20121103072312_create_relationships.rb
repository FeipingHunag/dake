class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships, id: false do |t|
      t.integer :id, limit: 8,  null: false
      t.integer :follower_id, limit: 8,  null: false
      t.integer :followed_id, limit: 8,  null: false
      t.timestamps
    end

    execute  <<-SQL
      ALTER TABLE relationships ADD PRIMARY KEY (id);
      ALTER TABLE relationships ALTER id SET DEFAULT next_id();
    SQL

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
