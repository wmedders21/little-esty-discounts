class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:disable]
      merchant.update(status: 0)
      redirect_to admin_merchant_path
    elsif params[:enable]
      merchant.update(status: 1)
      redirect_to admin_merchant_path
    elsif merchant.update(merchant_params)
      redirect_to admin_merchant_path
      flash[:success] = "Merchant Successfully Updated"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

private
    def merchant_params
      params.permit(:name)
    end
end
