class OrdersController < ApplicationController
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
  
  protected
    
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
      
      if !@order.reader
        @order.reader = current_reader
        @order.save
      end
    end
  
end
