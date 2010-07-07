class BillingAddress < ActiveRecord::Base
  has_many :orders
  
  [:name, :address1, :city, :country, :zip].each do |field|
    validates_presence_of field, :on => :update, :message => "can't be blank"
  end
  
end