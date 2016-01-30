class CreateUuidOperatorClass < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE OPERATOR CLASS _uuid_ops DEFAULT
        FOR TYPE _uuid USING gin AS
        OPERATOR 1 &&(anyarray, anyarray),
        OPERATOR 2 @>(anyarray, anyarray),
        OPERATOR 3 <@(anyarray, anyarray),
        OPERATOR 4 =(anyarray, anyarray),
        FUNCTION 1 uuid_cmp(uuid, uuid),
        FUNCTION 2 ginarrayextract(anyarray, internal, internal),
        FUNCTION 3 ginqueryarrayextract(anyarray, internal, smallint, internal, internal, internal, internal),
        FUNCTION 4 ginarrayconsistent(internal, smallint, anyarray, integer, internal, internal, internal, internal),
        STORAGE uuid;
    SQL
  end

  def down
    execute <<-SQL
      DROP OPERATOR CLASS _uuid_ops USING gin;
    SQL
  end
end
