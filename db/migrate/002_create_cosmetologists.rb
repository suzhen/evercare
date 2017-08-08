class CreateCosmetologists < ActiveRecord::Migration
  def self.up
    create_table :cosmetologists do |t|
      t.string :name
      t.string :section
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :cosmetologists
  end
end
