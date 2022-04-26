class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @holidays = HolidayFacade.new
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def create
    merchant = Merchant.find(params[:id])
    merchant.bulk_discounts.create!(discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def destroy
    BulkDiscount.find(params[:discount_id]).destroy
    redirect_to "/merchants/#{params[:id]}/bulk_discounts"
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    discount.update(discount_params)
    redirect_to "/merchants/#{discount.merchant_id}/bulk_discounts/#{discount.id}"

  end


  private
  def discount_params
    params.permit(:name, :discount_percentage, :quantity_threshold)
  end

end
