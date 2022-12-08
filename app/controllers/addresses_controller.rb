class AddressesController < ApplicationController
  before_action :authenticate_user!, :set_address, only: %i[ show edit update destroy ]

  add_breadcrumb "Home", :root_path

  # GET /addresses or /addresses.json
  def index
    add_breadcrumb "Addresses", addresses_path, :title => "Addresses"

    user = current_user
    @addresses = user.addresses
  end

  # GET /addresses/1 or /addresses/1.json
  def show
    add_breadcrumb "Addresses", addresses_path, :title => "Addresses"
    add_breadcrumb @address.address_one, @address, title: "Edit"
  end

  # GET /addresses/new
  def new
    add_breadcrumb "Addresses", addresses_path, :title => "Addresses"
    add_breadcrumb "New", @address, title: "New"

    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
    add_breadcrumb "Addresses", addresses_path, :title => "Addresses"
    add_breadcrumb @address.address_one, @address, title: "Edit"
  end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params)

    user = current_user
    @address.users = [user]

    respond_to do |format|
      if @address.save
        format.html { redirect_to addresses_url, notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    user = current_user
    @address.users = [user]

    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to addresses_url, notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy

    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:name, :email, :website, :phone, :fax, :company, :address_one, :address_two, :city, :province_id, :postal_code, :country, :notes)
  end
end
