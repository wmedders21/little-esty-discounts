class InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{invoice_item.invoice_id}"
  end
end
