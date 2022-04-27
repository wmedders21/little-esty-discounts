class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @holidays = HolidayFacade.new
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    discount = @merchant.bulk_discounts.new(discount_params)
    if params[:quantity_threshold].empty? || params[:discount_percentage].empty? || params[:name].empty?
      flash[:notice] = "Please fill out all fields"
      render :new
    elsif params[:discount_percentage].to_i > 100 || params[:discount_percentage].to_i < 1
      flash[:notice] = "Please enter a discount value between 1 and 100"
      render :new
    else
      discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    end
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
    @discount = BulkDiscount.find(params[:id])
    if params[:quantity_threshold].empty? || params[:discount_percentage].empty? || params[:name].empty?
      flash[:notice] = "Please fill out all fields"
      render :edit
    elsif params[:discount_percentage].to_i > 100 || params[:discount_percentage].to_i < 1
      flash[:notice] = "Please enter a discount value between 1 and 100"
      render :edit
    else
      @discount.update(discount_params)
      redirect_to "/merchants/#{@discount.merchant_id}/bulk_discounts/#{@discount.id}"
    end
  end


  private
  def discount_params
    params.permit(:name, :discount_percentage, :quantity_threshold)
  end

end
