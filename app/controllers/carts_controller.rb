class CartsController < InheritedResources::Base

  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Cart", carts_path, :title => "Cart"

    ensure_cart_exists
    @cart_items = session[:cart]

    user = current_user
    if user.present?
      user_id = current_user.id
      cart_ids = Cart.where(user_id: user_id)

      @cart_items = []
      cart_ids.each do |item|

        cart_item = { 'product_id' => item.product_id,
                      'quantity' => item.quantity }
        @cart_items.push(cart_item)
      end
    end

    @count = 0
    @products = []

    if @cart_items.present?
      @count = @cart_items.length
      @cart_items.each do |item|
        product = Product.find_by_id(item['product_id'])
        @products.push(product)
      end
    end
  end

  def ensure_cart_exists
    session[:cart] ||= []
  end

  def remove_from_cart
    @product = nil
    if params[:product_id].present?
      @product = Product.find_by_id(params[:product_id])

      if @product.present?
        # begin
        ensure_cart_exists

        # session[:cart] = []

        session[:cart].delete_if { |cart_item| cart_item['product_id'].to_i == @product.id }

        user = current_user
        if user.present?
          user_id = current_user.id
          cart_item = Cart.where(product_id: @product.id).first_or_create
          cart_item.destroy
        end
        respond_to do |format|
          # format.html { redirect_to product_url(@product), notice: @product.title + " was successfully added to cart." }
          format.html { redirect_to carts_path, notice: @product.title + " was successfully removed from the cart." }
          format.json { render :show, status: :ok, location: @product }
        end
        # rescue
        #   respond_to do |format|
        #     format.html { redirect_to product_url(@product), error: @product.title + " cannot be added." }
        #     format.json { render json: @product.errors, status: :unprocessable_entity }
        #   end
        # end
      else
        respond_to do |format|
          format.html { redirect_to product_url(@product), error: @product.title + " cannot be removed." }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def add_to_cart
    @product = nil
    if params[:product_id].present?
      @product = Product.find_by_id(params[:product_id])

      if @product.present?
        begin
        ensure_cart_exists

        # Test
        # session[:cart] = []

        is_found = false
        if session[:cart].length > 0
          session[:cart].each do |item|
            if item['product_id'].to_i == @product.id
              item['quantity'] = item['quantity'].to_i + 1
              is_found = true
            end
          end
        end

        unless is_found
          cart_item = { 'product_id' => @product.id,
                        'quantity' => 1 }
          session[:cart].push(cart_item)
        end

        user = current_user
        if user.present?
          user_id = current_user.id
          cart_item = Cart.where(product_id: @product.id).first_or_create
          if cart_item.quantity.present?
            cart_item.quantity = cart_item.quantity.to_i + 1
          else
            cart_item.product_id = @product.id
            cart_item.quantity = 1
          end
          cart_item.user_id = user_id
          cart_item.save
        end
        respond_to do |format|
          # format.html { redirect_to product_url(@product), notice: @product.title + " was successfully added to cart." }
          format.html { redirect_to carts_path, notice: @product.title + " was successfully added to cart." }
          format.json { render :show, status: :ok, location: @product }
        end
        rescue
          respond_to do |format|
            format.html { redirect_to product_url(@product), error: @product.title + " cannot be added." }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to product_url(@product), error: @product.title + " cannot be added." }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def update_cart
    @product = nil
    if params[:product_id].present? && params[:quantity].present?
      @product = Product.find_by_id(params[:product_id])
      quantity = params[:quantity].to_i

      if @product.present?
        begin
          ensure_cart_exists

          # Test
          # session[:cart] = []

          is_found = false
          if session[:cart].length > 0
            session[:cart].each do |item|
              if item['product_id'].to_i == @product.id
                item['quantity'] = quantity
                is_found = true
              end
            end
          end

          unless is_found
            cart_item = { 'product_id' => @product.id,
                          'quantity' => quantity }
            session[:cart].push(cart_item)
          end

          user = current_user
          if user.present?
            user_id = current_user.id
            cart_item = Cart.where(product_id: @product.id).first_or_create
            if cart_item.quantity.present?
              cart_item.quantity = quantity
            else
              cart_item.user_id = user_id
              cart_item.product_id = @product.id
              cart_item.quantity = quantity
            end
            cart_item.save
          end
          respond_to do |format|
            # format.html { redirect_to product_url(@product), notice: @product.title + " was successfully added to cart." }
            format.html { redirect_to carts_path, notice: @product.title + " was successfully added to cart." }
            format.json { render :show, status: :ok, location: @product }
          end
        rescue
          respond_to do |format|
            format.html { redirect_to product_url(@product), error: @product.title + " cannot be added." }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to product_url(@product), error: @product.title + " cannot be added." }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity)
  end

end
