class Order < ActiveRecord::Base
  is_site_scoped if defined? ActiveRecord::SiteNotFound
  belongs_to :reader
end
