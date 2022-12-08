class SalesOrdersController < ApplicationController

  add_breadcrumb "Home", :root_path

  # GET /sales_orders or /sales_orders.json
  def index
    @sales_orders = SalesOrder.all
  end

  # GET /sales_orders/1 or /sales_orders/1.json
  def show
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
    # @sales_order = SalesOrder.new(sales_order_params)
    #
    # respond_to do |format|
    #   if @sales_order.save
    #     format.html { redirect_to sales_order_url(@sales_order), notice: "Sales order was successfully created." }
    #     format.json { render :show, status: :created, location: @sales_order }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @sales_order.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /sales_orders/1 or /sales_orders/1.json
  def update
    # respond_to do |format|
    #   if @sales_order.update(sales_order_params)
    #     format.html { redirect_to sales_order_url(@sales_order), notice: "Sales order was successfully updated." }
    #     format.json { render :show, status: :ok, location: @sales_order }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @sales_order.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /sales_orders/1 or /sales_orders/1.json
  def destroy
    # @sales_order.destroy
    #
    # respond_to do |format|
    #   format.html { redirect_to sales_orders_url, notice: "Sales order was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  def submit_order
    if params[:cart_items].present? && params[:ship_to_address].present?
      address = Address.find_by_id(params[:address_id])

      if address.present?
        begin
          ensure_ship_to_session_exists
          session[:ship_to_address] = params[:address_id]

          respond_to do |format|
            format.html { redirect_to carts_path, notice: address.address_one + " was selected as ship to address." }
            format.json { render :show, status: :ok, location: address }
          end
        rescue
          respond_to do |format|
            format.html { redirect_to carts_path, error: address.address_one + " cannot be selected." }
            format.json { render json: address.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to carts_path, error: "Address cannot be selected." }
          format.json { render json: address.errors, status: :unprocessable_entity }
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
