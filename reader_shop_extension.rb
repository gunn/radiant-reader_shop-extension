# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
class ReaderShopExtension < Radiant::Extension
  version "0.1"
  description "Adds simple ordering functionality based around readers."
  url "http://gunn.co.nz"
  
  define_routes do |map|
    # map.namespace :admin, :member => { :remove => :get } do |admin|
    #   admin.resources :reader_shop
    # end
    map.resources :orders
  end
  
  extension_config do |config|
    config.gem 'inherited_resources', :version => "1.0.6"
  end
  
  def activate
    # admin.tabs.add "Reader Shop", "/admin/reader_shop", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Reader Shop"
  end
  
end
