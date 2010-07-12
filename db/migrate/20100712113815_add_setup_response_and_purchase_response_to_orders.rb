class AddSetupResponseAndPurchaseResponseToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :setup_response, :text
    add_column :orders, :purchase_response, :text
  end

  def self.down
    remove_column :orders, :purchase_response
    remove_column :orders, :setup_response
  end
end
