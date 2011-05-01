class CreateGooses < ActiveRecord::Migration
  def self.up
    create_table :gooses do |t|
      t.float :fly
      t.eat :

      t.timestamps
    end
  end

  def self.down
    drop_table :gooses
  end
end
