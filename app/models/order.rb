class Order < ActiveRecord::Base
  is_site_scoped if defined? ActiveRecord::SiteNotFound
  belongs_to :reader
  belongs_to :billing_address
  
  validates_presence_of :billing_address_id, :on => :update
  
  accepts_nested_attributes_for :billing_address
  
  serialize :setup_response
  serialize :purchase_response
  
  def get_billing_details_from_reader!
    self.billing_address = BillingAddress.create({
      :name     => reader.name,
      :address1 => reader.address,
      :city     => reader.city,
      :country  => reader.country,
      :zip      => reader.postcode
    })
  end
end
