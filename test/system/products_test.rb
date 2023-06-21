require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    @products = @user.products
    sign_in @user
  end

  test "viewing the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_path

    click_on "New Product"

    fill_in "Product name", with: "Creating a Product"
    fill_in "Description", with: "Created this article successfully!"
    fill_in "Price", with: "50"

    click_on "Create Product"

    assert_text "Creating a Product"
  end
end
