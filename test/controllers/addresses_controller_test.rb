require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address = addresses(:one)
  end

  test "should get index" do
    get addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_address_url
    assert_response :success
  end

  test "should create address" do
    assert_difference("Address.count") do
      post addresses_url, params: { address: { address_one: @address.address_one, address_two: @address.address_two, city: @address.city, company: @address.company, country: @address.country, email: @address.email, fax: @address.fax, name: @address.name, notes: @address.notes, phone: @address.phone, postal_code: @address.postal_code, province: @address.province, website: @address.website } }
    end

    assert_redirected_to address_url(Address.last)
  end

  test "should show address" do
    get address_url(@address)
    assert_response :success
  end

  test "should get edit" do
    get edit_address_url(@address)
    assert_response :success
  end

  test "should update address" do
    patch address_url(@address), params: { address: { address_one: @address.address_one, address_two: @address.address_two, city: @address.city, company: @address.company, country: @address.country, email: @address.email, fax: @address.fax, name: @address.name, notes: @address.notes, phone: @address.phone, postal_code: @address.postal_code, province: @address.province, website: @address.website } }
    assert_redirected_to address_url(@address)
  end

  test "should destroy address" do
    assert_difference("Address.count", -1) do
      delete address_url(@address)
    end

    assert_redirected_to addresses_url
  end
end
