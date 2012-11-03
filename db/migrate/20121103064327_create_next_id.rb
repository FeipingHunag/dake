class CreateNextId < ActiveRecord::Migration
  def change
    execute <<-SQL
      DROP SEQUENCE IF EXISTS table_id_seq;
      
      CREATE SEQUENCE table_id_seq;
      
      CREATE OR REPLACE FUNCTION next_id(OUT result bigint) AS $$
      DECLARE
          our_epoch bigint := 1314220021721;
          seq_id bigint;
          now_millis bigint;
          shard_id int := 0;
      BEGIN
          SELECT nextval('table_id_seq'::regclass) % 1024 INTO seq_id;
          SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
          result := (now_millis - our_epoch) << 23;
          result := result | (shard_id << 10);
          result := result | (seq_id);
      END;
      $$ LANGUAGE PLPGSQL;
    SQL
  end
end