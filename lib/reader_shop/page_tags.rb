module ReaderShop
  module PageTags
    include Radiant::Taggable
    class TagError < StandardError; end
    
    desc %{
      Creates a form with one visible button. Submitting this creates an order.
    }
    tag 'order_form' do |tag|
      dynamic_options = YAML.load(tag.expand || "") rescue nil
      opts = { "submit" => "Buy", "class" => "order_form" }.merge(tag.attr)
      opts = opts.merge(dynamic_options) if dynamic_options.is_a? Hash
      
      %{<form class="#{opts['class']}" action="/orders" method="post">
        <input id="order_title" name="order[title]" type="hidden" value="#{opts['title']}" />
        <input id="order_description" name="order[description]" type="hidden" value="#{opts['description']}" />
        <input id="order_price" name="order[price]" type="hidden" value="#{opts['price']}" />
        <input id="order_price" name="order[code]" type="hidden" value="#{opts['code']}" />
        <input id="order_submit" name="commit" type="submit" value="#{opts['submit']}" />
      </form>}
    end
  end
end