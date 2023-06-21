require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:one)
  end

  test "product should not save if empty" do
    product = Product.new
    assert_not product.save, "Saved the product without a title"
  end

  test "name should not be less than 5 letters" do
    @product.product_name = "abcd"

    assert_not @product.save, "Saved the product with name less than 5 characters"
  end

  test "name should not be greater than 25 characters" do
    @product.product_name = "a"*26

    assert_not @product.save, "Saved the product with name greater than 25 characters"
  end

  test "price is must not be empty" do
    @product.price = nil

    assert_not @product.save, "Saved the product with price set as nil"
  end

  test "price should not be less than 0.0" do
    @product.price = -25

    assert_not @product.save, "Saved the product with price less than 0.0"
  end

  test "price should not be a string" do
    @product.price = "abc"

    assert_not @product.save, "Saved the product with price set as a string"
  end
end
