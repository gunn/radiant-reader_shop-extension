class BillingAddress < ActiveRecord::Base
  has_many :orders
  
  %w[name address1 city country zip].each do |field|
    validates_presence_of field, :on => :update, :message => "can't be blank"
  end
  
  def address_hash
    # the keys in the attributes hash are strings, but the activemerchant uses symbols
    attributes.dup.delete_if { |k,v|
      !%w[name address1 address2 city country zip phone].include?(k)
    }.symbolize_keys!
  end
  
end