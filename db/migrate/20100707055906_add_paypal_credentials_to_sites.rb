class AddPaypalCredentialsToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :paypal_username, :string
    add_column :sites, :paypal_password, :string
    add_column :sites, :paypal_signature, :string
  end

  def self.down
    remove_column :sites, :paypal_signature
    remove_column :sites, :paypal_password
    remove_column :sites, :paypal_username
  end
end
