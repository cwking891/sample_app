class CreateGeeses < ActiveRecord::Migration
  def self.up
    create_table :geeses do |t|
      t.int :fly
      t.string :sound

      t.timestamps
    end
  end

  def self.down
    drop_table :geeses
  end
end
