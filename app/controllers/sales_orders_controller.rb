class SalesOrdersController < ApplicationController
  before_action :authenticate_user!, :set_sales_order, only: %i[ show edit update destroy ]

  add_breadcrumb "Home", :root_path

  # GET /sales_orders or /sales_orders.json
  def index
    add_breadcrumb "Orders", sales_orders_path, :title => "Orders"

    user = current_user
    if user.present?
      @sales_orders = user.sales_orders
    else
      @sales_orders = []
    end
  end

  # GET /sales_orders/1 or /sales_orders/1.json
  def show
    add_breadcrumb "Orders", sales_orders_path, :title => "Orders"
    add_breadcrumb @sales_order.order_number, sales_order_path(@sales_order), :title => "Order"

    @products = []

    @sales_order_details = SalesOrderDetail.where(sales_order_id: @sales_order.id)

    @address = Address.find_by(id: @sales_order.address_id)

    @sales_order_details.each do |sales_order_detail|
      product = Product.find_by(id: sales_order_detail.product_id)
      @products.push(product)
    end
  end

  # GET /sales_orders/new
  def new
    @sales_order = SalesOrder.new
  end

  # GET /sales_orders/1/edit
  def edit
  end

  # POST /sales_orders or /sales_orders.json
  def create
    # @sales_order_detail = SalesOrder.new(sales_order_params)
    #
    # respond_to do |format|
    #   if @sales_order_detail.save
    #     format.html { redirect_to sales_order_url(@sales_order_detail), notice: "Sales order was successfully created." }
    #     format.json { render :show, status: :created, location: @sales_order_detail }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @sales_order_detail.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /sales_orders/1 or /sales_orders/1.json
  def update
    # respond_to do |format|
    #   if @sales_order_detail.update(sales_order_params)
    #     format.html { redirect_to sales_order_url(@sales_order_detail), notice: "Sales order was successfully updated." }
    #     format.json { render :show, status: :ok, location: @sales_order_detail }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @sales_order_detail.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /sales_orders/1 or /sales_orders/1.json
  def destroy
    # @sales_order_detail.destroy
    #
    # respond_to do |format|
    #   format.html { redirect_to sales_orders_url, notice: "Sales order was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  def submit_order
    user = current_user
    if user.present?
      if params[:cart_items].present? && params[:ship_to_address].present?
        address = Address.find_by(id: params[:ship_to_address])

        if address.present?
          # Generate order number
          order_num_segment_a = rand(100..199)
          order_num_segment_b = rand(1000..9999)
          order_num_segment_c = rand(10000..99999)
          order_number = "#{order_num_segment_a}-#{order_num_segment_b}-#{order_num_segment_c}"

          # Set Taxe rates and totals
          gst_rate = address.province.gst
          pst_rate = address.province.pst
          hst_rate = address.province.hst
          @sub_total = 0
          @shipping = 0
          @pst = 0
          @gst = 0
          @hst = 0

          # begin
          shipping_price_per_item = Preference.find_by(setting: "shipping_price_per_item").value.to_f

          @sales_order = SalesOrder.create!(
            order_number: order_number,
            tracking_number: "",
            address_id: address.id,
            user_id: user.id)

          params[:cart_items].each do |item|
            product = Product.find_by(id: item['product_id'])
            @sub_total += product.price * item['quantity'].to_i
            @shipping += shipping_price_per_item

            SalesOrderDetail.create!(
              quantity: item['quantity'].to_i,
              price: product.price,
              shipped: false,
              sales_order_id: @sales_order.id,
              product_id: product.id)
          end

          @sales_order.shipping = @shipping
          @sales_order.prov_tax = (@sub_total + @shipping) * pst_rate
          @sales_order.fed_tax = ((@sub_total + @shipping) * gst_rate) + ((@sub_total + @shipping) * hst_rate)

          @sales_order.save

          # Clear cart
          session[:cart] = []
          Cart.where(user_id: user.id).destroy_all

          respond_to do |format|
            format.html { redirect_to sales_order_url(@sales_order), notice: "Your order has successfully been submitted." }
            format.json { render :show, status: :ok, location: address }
          end
          # rescue
          #   respond_to do |format|
          #     format.html { redirect_to carts_path, error: "There was a problem submitting the order." }
          #     format.json { render json: address.errors, status: :unprocessable_entity }
          #   end
          # end
        else
          respond_to do |format|
            format.html { redirect_to carts_path, error: "There was an error with the address." }
            format.json { render json: address.errors, status: :unprocessable_entity }
          end
        end
      end
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sales_order
    @sales_order = SalesOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sales_order_params
    params.require(:sales_order).permit(:order_number, :tracking_number, :shipping, :prov_tax, :fed_tax, :due_date, :order_date)
  end
end
