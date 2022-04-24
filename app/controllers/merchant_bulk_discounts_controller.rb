class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
  end

  def create
    merchant = Merchant.find(params[:id])
    merchant.bulk_discounts.create!(discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def destroy
    BulkDiscount.find(params[:discount_id]).destroy
    redirect_to "/merchants/#{params[:id]}/bulk_discounts"    
  end


  private
  def discount_params
    params.permit(:name, :discount_percentage, :quantity_threshold)
  end

end
