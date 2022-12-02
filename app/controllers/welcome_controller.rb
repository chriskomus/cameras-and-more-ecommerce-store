class WelcomeController < ApplicationController

  add_breadcrumb "Home", :root_path


  def index
    @products = Product.page(params[:page])
  end
end
