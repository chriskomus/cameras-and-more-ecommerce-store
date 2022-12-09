class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  add_breadcrumb "Home", :root_path, options: {class: "breadcrumb-item"}

  # GET /products_filtered or /products_filtered.json
  def index
    add_breadcrumb "Products", products_path, :title => "Products"

    @products = []

    if params[:category_id].present?
      search_category = Category.find_by(id: params[:category_id])
      products_filtered = search_category.products
    else
      products_filtered = Product.all
    end

    if params[:filter].present?
      if params[:filter] == "sale"
        products_filtered = products_filtered.where(list_price: 0...)
      elsif params[:filter] == "new"
        products_filtered = products_filtered.where(created_at: 3.days.ago..)
      elsif params[:filter] == "updated"
        products_filtered = products_filtered.where(updated_at: 3.days.ago.., created_at: ...3.days.ago)
      end
    end

    if params[:search].present?
      search = params[:search]
    elsif params[:main_search].present?
      search = params[:main_search]
    else
      search = ""
    end

    @products = products_filtered.search(search).page(params[:page])
  end

  # GET /products_filtered/1 or /products_filtered/1.json
  def show

    if @product.categories.present?
      @product_categories = @product.categories.sort_by &:title
    else
      @product_categories = []
    end

    add_breadcrumb "Products", products_path, :title => "Products"
    add_breadcrumb @product_categories[0].title, @product_categories[0], :title => @product_categories[0].title
    add_breadcrumb @product.title, @album, title: @product.title
  end

  # GET /products_filtered/new
  def new
    @product = Product.new
  end

  # GET /products_filtered/1/edit
  def edit
  end

  # POST /products_filtered or /products_filtered.json
  def create
    # @product = Product.new(product_params)
    #
    # respond_to do |format|
    #   if @product.save
    #     format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
    #     format.json { render :show, status: :created, location: @product }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /products_filtered/1 or /products_filtered/1.json
  def update
    # respond_to do |format|
    #   if @product.update(product_params)
    #     format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
    #     format.json { render :show, status: :ok, location: @product }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /products_filtered/1 or /products_filtered/1.json
  def destroy
    # @product.destroy
    #
    # respond_to do |format|
    #   format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :sku, :description, :price, :quantity)
  end
end
