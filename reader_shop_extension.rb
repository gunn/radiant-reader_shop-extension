class ReaderShopExtension < Radiant::Extension
  version "0.1"
  description "Adds simple ordering functionality based around readers."
  url "http://gunn.co.nz/"
  
  define_routes do |map|
    map.resources :orders, :member => { :checkout => :put, :complete => :get } 
  end
  
  extension_config do |config|
    config.gem 'inherited_resources', :version => "1.0.6"
    config.gem 'activemerchant', :lib => "active_merchant"
  end
  
  def activate
    ActiveMerchant::Billing::Base.mode = :test
    
    if defined?(admin.sites) && !admin.sites.edit[:form].include?("admin/sites/paypal_credentials")
      admin.sites.edit.add :form, "admin/sites/paypal_credentials", :after => "edit_homepage"
    end
    
    Page.send :include, ReaderShop::PageTags
  end
  
  def deactivate
    # 
  end
  
end
