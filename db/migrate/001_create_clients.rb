class CreateClients < ActiveRecord::Migration[5.1]
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :code
      t.string :email
      t.string :gender
      t.string :mobile
      t.string :address
      t.string :idcard
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :clients
  end
end
