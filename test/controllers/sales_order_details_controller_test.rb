require "test_helper"

class SalesOrderDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sales_order_detail = sales_order_details(:one)
  end

  test "should get index" do
    get sales_order_details_url
    assert_response :success
  end

  test "should get new" do
    get new_sales_order_detail_url
    assert_response :success
  end

  test "should create sales_order_detail" do
    assert_difference("SalesOrderDetail.count") do
      post sales_order_details_url, params: { sales_order_detail: { price: @sales_order_detail.price, quantity: @sales_order_detail.quantity, shipped: @sales_order_detail.shipped } }
    end

    assert_redirected_to sales_order_detail_url(SalesOrderDetail.last)
  end

  test "should show sales_order_detail" do
    get sales_order_detail_url(@sales_order_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_sales_order_detail_url(@sales_order_detail)
    assert_response :success
  end

  test "should update sales_order_detail" do
    patch sales_order_detail_url(@sales_order_detail), params: { sales_order_detail: { price: @sales_order_detail.price, quantity: @sales_order_detail.quantity, shipped: @sales_order_detail.shipped } }
    assert_redirected_to sales_order_detail_url(@sales_order_detail)
  end

  test "should destroy sales_order_detail" do
    assert_difference("SalesOrderDetail.count", -1) do
      delete sales_order_detail_url(@sales_order_detail)
    end

    assert_redirected_to sales_order_details_url
  end
end
