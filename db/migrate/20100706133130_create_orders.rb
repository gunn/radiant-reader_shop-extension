class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string  :title
      t.text    :description
      t.integer :price
      t.string  :status
      
      t.integer :reader_id
      t.integer :site_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
