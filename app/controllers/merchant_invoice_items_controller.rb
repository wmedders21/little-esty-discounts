class MerchantInvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{invoice_item.invoice_id}"
  end
end
