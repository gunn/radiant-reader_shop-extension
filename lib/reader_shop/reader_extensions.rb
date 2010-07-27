module ReaderShop::ReaderExtensions

  def self.included(base)
    base.has_many :orders
  end

end

