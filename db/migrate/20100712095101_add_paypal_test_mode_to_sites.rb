class AddPaypalTestModeToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :paypal_test_mode, :boolean, :default => true
  end

  def self.down
    remove_column :sites, :paypal_test_mode
  end
end
