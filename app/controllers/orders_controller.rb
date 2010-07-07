class OrdersController < ApplicationController
  include ActiveMerchant::Billing
  no_login_required
  
  inherit_resources
  respond_to :html
  # actions :show, :create, :edit, :update
  actions :index, :show, :new, :create, :edit, :update, :destroy
  
  before_filter :check_reader, :except => [:index, :create]
  before_filter :assign_reader, :only => [:edit, :update]
  
  # radiant_layout { |controller| controller.layout_for :reader }
  
  def create
    create! do |format|
      format.html do
        if current_reader
          redirect_to edit_order_path(@order)
        else
          session[:return_to] = edit_order_path(@order)
          redirect_to new_reader_path
        end
      end
    end
  end
  
  def checkout
    @order = resource
    
    setup_response = gateway.setup_purchase( @order.price/100.0,
      :ip                => request.remote_ip,
      :return_url        => order_url(@order),
      :cancel_return_url => order_url(@order), 
      :currency          => "NZD"
    )
    
    @order.token = setup_response.token
    @order.status = "paypal_setup"
    @order.save
    
    redirect_to gateway.redirect_url_for(setup_response.token)
  end
  
  def complete
    # stop people doing stupid things by guessing the URL
    @order = Order.find_by_token(params[:token])
    
    if @order.status != "complete"
      
      purchase = gateway.purchase(@order.order_value,
        :ip       => request.remote_ip, 
        :payer_id => params[:PayerID],
        :token    => params[:token],
        :currency => "NZD"
      )
    
      @order.status = purchase.success? ? "complete" : "fail on purchase!"
      @order.save
    
      if !purchase.success?
        @message = purchase.message
        render :action => 'error'
        return
      end
      
    end
  end
  
  protected
  
    def gateway
      @gateway ||= PaypalExpressGateway.new (
        :login     => current_site.paypal_username,
        :password  => current_site.paypal_password,
        :signature => current_site.paypal_signature )
    end
    
    def check_reader
      # A user i.e. a site editor can do anything.
      # A reader can access only orders that belong to them,
      # or that have not been claimed by anybody else.
      
      return true if current_user ||
        current_reader &&
        (resource.reader == current_reader ||
        resource.reader.nil?)
      
      flash[:error] = "You must be signed in to do that."
      session[:return_to] = request.path
      redirect_to reader_login_path
    end
    
    def assign_reader      
      @order = resource
      
      @order.set_reader( current_reader ) if !@order.reader
    end
  
end
