class CreateBillingAddresses < ActiveRecord::Migration
  def self.up
    create_table :billing_addresses do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :phone

      t.timestamps
    end
    
    add_column :orders, :billing_address_id, :integer
  end

  def self.down
    remove_column :orders, :billing_address_id
    drop_table :billing_addresses
  end
end