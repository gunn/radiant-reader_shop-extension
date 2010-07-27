class AddCodeAndDataToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :code, :string
    add_column :orders, :data, :text
  end

  def self.down
    remove_column :orders, :data
    remove_column :orders, :code
  end
end