require "application_system_test_case"

class SalesOrderDetailsTest < ApplicationSystemTestCase
  setup do
    @sales_order_detail = sales_order_details(:one)
  end

  test "visiting the index" do
    visit sales_order_details_url
    assert_selector "h1", text: "Sales order details"
  end

  test "should create sales order detail" do
    visit sales_order_details_url
    click_on "New sales order detail"

    fill_in "Price", with: @sales_order_detail.price
    fill_in "Quantity", with: @sales_order_detail.quantity
    check "Shipped" if @sales_order_detail.shipped
    click_on "Create Sales order detail"

    assert_text "Sales order detail was successfully created"
    click_on "Back"
  end

  test "should update Sales order detail" do
    visit sales_order_detail_url(@sales_order_detail)
    click_on "Edit this sales order detail", match: :first

    fill_in "Price", with: @sales_order_detail.price
    fill_in "Quantity", with: @sales_order_detail.quantity
    check "Shipped" if @sales_order_detail.shipped
    click_on "Update Sales order detail"

    assert_text "Sales order detail was successfully updated"
    click_on "Back"
  end

  test "should destroy Sales order detail" do
    visit sales_order_detail_url(@sales_order_detail)
    click_on "Destroy this sales order detail", match: :first

    assert_text "Sales order detail was successfully destroyed"
  end
end
