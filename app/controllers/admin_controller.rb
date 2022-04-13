class AdminController < ApplicationController
  def index
    @customers = Customer.all
    @invoices = Invoice.sorted_by_newest
  end
end
