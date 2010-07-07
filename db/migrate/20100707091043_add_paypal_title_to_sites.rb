class AddPaypalTitleToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :paypal_title, :string
  end

  def self.down
    remove_column :sites, :paypal_title
  end
end
