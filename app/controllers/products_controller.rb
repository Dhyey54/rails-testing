class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      flash[:success] = 'Product successfully created'
      redirect_to @product
    else
      flash[:error] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product was successfully updated'
      redirect_to @product
    else
      flash[:error] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = 'Product was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :price, :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
