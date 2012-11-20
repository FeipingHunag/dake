class CreateViewUniqLocations < ActiveRecord::Migration
  def change
    execute  <<-SQL
      CREATE OR REPLACE VIEW public.uniq_locations AS 
       SELECT locations.user_id, locations.coordinate, max(locations.created_at) AS created_at
         FROM locations
        GROUP BY locations.user_id, locations.coordinate;
    SQL
  end
end
