class AddPaypalTokenToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :token, :string
  end

  def self.down
    remove_column :orders, :token
  end
end
