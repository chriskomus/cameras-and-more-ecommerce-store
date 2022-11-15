require "application_system_test_case"

class SalesOrdersTest < ApplicationSystemTestCase
  setup do
    @sales_order = sales_orders(:one)
  end

  test "visiting the index" do
    visit sales_orders_url
    assert_selector "h1", text: "Sales orders"
  end

  test "should create sales order" do
    visit sales_orders_url
    click_on "New sales order"

    fill_in "Due date", with: @sales_order.due_date
    fill_in "Fed tax", with: @sales_order.fed_tax
    fill_in "Order date", with: @sales_order.order_date
    fill_in "Order number", with: @sales_order.order_number
    fill_in "Prov tax", with: @sales_order.prov_tax
    fill_in "Shipping", with: @sales_order.shipping
    fill_in "Tracking number", with: @sales_order.tracking_number
    click_on "Create Sales order"

    assert_text "Sales order was successfully created"
    click_on "Back"
  end

  test "should update Sales order" do
    visit sales_order_url(@sales_order)
    click_on "Edit this sales order", match: :first

    fill_in "Due date", with: @sales_order.due_date
    fill_in "Fed tax", with: @sales_order.fed_tax
    fill_in "Order date", with: @sales_order.order_date
    fill_in "Order number", with: @sales_order.order_number
    fill_in "Prov tax", with: @sales_order.prov_tax
    fill_in "Shipping", with: @sales_order.shipping
    fill_in "Tracking number", with: @sales_order.tracking_number
    click_on "Update Sales order"

    assert_text "Sales order was successfully updated"
    click_on "Back"
  end

  test "should destroy Sales order" do
    visit sales_order_url(@sales_order)
    click_on "Destroy this sales order", match: :first

    assert_text "Sales order was successfully destroyed"
  end
end
