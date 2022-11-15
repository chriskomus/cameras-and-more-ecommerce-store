require "application_system_test_case"

class AddressesTest < ApplicationSystemTestCase
  setup do
    @address = addresses(:one)
  end

  test "visiting the index" do
    visit addresses_url
    assert_selector "h1", text: "Addresses"
  end

  test "should create address" do
    visit addresses_url
    click_on "New address"

    fill_in "Address one", with: @address.address_one
    fill_in "Address two", with: @address.address_two
    fill_in "City", with: @address.city
    fill_in "Company", with: @address.company
    fill_in "Country", with: @address.country
    fill_in "Email", with: @address.email
    fill_in "Fax", with: @address.fax
    fill_in "Name", with: @address.name
    fill_in "Notes", with: @address.notes
    fill_in "Phone", with: @address.phone
    fill_in "Postal code", with: @address.postal_code
    fill_in "Province", with: @address.province
    fill_in "Website", with: @address.website
    click_on "Create Address"

    assert_text "Address was successfully created"
    click_on "Back"
  end

  test "should update Address" do
    visit address_url(@address)
    click_on "Edit this address", match: :first

    fill_in "Address one", with: @address.address_one
    fill_in "Address two", with: @address.address_two
    fill_in "City", with: @address.city
    fill_in "Company", with: @address.company
    fill_in "Country", with: @address.country
    fill_in "Email", with: @address.email
    fill_in "Fax", with: @address.fax
    fill_in "Name", with: @address.name
    fill_in "Notes", with: @address.notes
    fill_in "Phone", with: @address.phone
    fill_in "Postal code", with: @address.postal_code
    fill_in "Province", with: @address.province
    fill_in "Website", with: @address.website
    click_on "Update Address"

    assert_text "Address was successfully updated"
    click_on "Back"
  end

  test "should destroy Address" do
    visit address_url(@address)
    click_on "Destroy this address", match: :first

    assert_text "Address was successfully destroyed"
  end
end
