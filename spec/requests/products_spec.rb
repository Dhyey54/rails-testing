require 'rails_helper'

RSpec.shared_context :login_user do
  let(:user) { create(:user) }
  before { sign_in user }
end

RSpec.describe "Products", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:test_user) { create(:user) }
  let(:products) { create_list(:product, 3, user:) }

  describe "Positives Cases"do
    include_context :login_user
    describe "GET /products" do
      it "should get all the products" do
        get products_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /show" do
      it "should get the product" do
        get product_url(products.first)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "should get the new page" do
        get new_product_url
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "should edit the product" do
        get edit_product_url(products.first)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      it "creates a new Product" do
        expect {
          post products_url, params: { product: { product_name: "Testing the product", price: 25, description: "RSpec Testing" } }
        }.to change(Product, :count).by(1)
      end

      it "redirects to the created article" do
        post products_url, params: { product: { product_name: "Testing the product", price: 25, description: "RSpec Testing" } }
        expect(response).to redirect_to(product_url(Product.last))
      end
    end

    describe "PATCH /update" do
      let(:new_attributes) {
        {
          product_name: "updating product"
        }
      }

      it "updates the requested product" do
        product = products.last
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(product.product_name).equal?("updating product")
      end

      it "redirects to the product" do
        product = products.last
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(response).to redirect_to(product_url(product))
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested article" do
        product = products.last
        expect {
          delete product_url(product)
        }.to change(Product, :count).by(-1)
      end

      it "redirects to the products list" do
        product = products.last
        delete product_url(product)
        expect(response).to redirect_to(products_url)
      end
    end
  end

  describe "Negative Cases" do
    describe "without user sign_in" do
      it "should redirect for index" do
        get products_path
        expect(response).to redirect_to(new_user_session_url)
      end

      it "should redirect for new" do
        get new_product_url
        expect(response).to redirect_to(new_user_session_url)
      end

      let(:test_product) { create_list(:product, 3, user: test_user) }
      it "should redirect for show" do
        get product_url(test_product)
        expect(response).to redirect_to(new_user_session_url)
      end

      it "should redirect for edit" do
        get edit_product_url(test_product)
        expect(response).to redirect_to(new_user_session_url)
      end

      it "should redirect for delete" do
        product = Product.last
        delete product_url(product)
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "using wrong attributes" do
      include_context :login_user
      let(:wrong_attributes) {
        {
          title: "test"
        }
      }
      it "should not creates a new Product" do
        expect {
          post products_url, params: { product: { product_name: "test", price: "hiii", description: "" } }
        }.to change(Product, :count).by(0)
      end
      it "should not updates the requested product" do
        product = products.last
        patch product_url(product), params: { product: wrong_attributes }
        product.reload
        expect(product.product_name).equal?("Testing Product")
      end
    end
  end
end
