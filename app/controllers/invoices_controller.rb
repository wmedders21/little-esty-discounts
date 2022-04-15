class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @items = Item.items_by_merchant(params[:merchant_id])
    # @invoiceitems = InvoiceItem.all.select {|invoice_item|invoice_item.item.merchant_id == params[:merchant_id]}
  end
end
