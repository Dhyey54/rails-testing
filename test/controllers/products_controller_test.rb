require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @product = products(:one)
    @user = users(:one)
    sign_in(@user)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get products_url

    assert_equal "index", @controller.action_name
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference "Product.count", 1 do
      post products_path, params: { product: { product_name: "Pencil", price: 20, description: "Testing" } }
    end
    assert_redirected_to product_url(Product.last)
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { product_name: "Testing" } }
    assert_redirected_to product_url(@product)

    @product.reload
    assert_equal "Testing", @product.product_name, 'Product name not changed'
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "should redirect if not logged in" do
    sign_out(@user)

    assert_response :redirect, "Products shown successfully" if get products_url
    assert_response :redirect, "Product details shown successfully" if get product_url(@product)
    assert_response :redirect, "Product has been created successfully" if post products_path, params: { product: { product_name: "Pencil", price: 20, description: "Testing" } }
    assert_response :redirect, "Edit Page for product shown" if get edit_product_url(@product)
    assert_response :redirect, "Product updated successfully" if patch product_url(@product), params: { product: { product_name: "Testing" } }
    assert_response :redirect, "Product deleted successfully" if delete product_url(@product)
  end
end
