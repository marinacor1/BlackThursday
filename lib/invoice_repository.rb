require 'pry'
require 'csv'
require_relative 'invoice'
require_relative 'sales_engine'

class InvoiceRepository
  attr_accessor :all

  def initialize(path)
    @all_invoices = []
    populate_invoice_repo_with_data_from_csv(path)
  end

  def populate_invoice_repo_with_data_from_csv(path)
  CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
    i = Invoice.new(data_row)
    @all_invoices << i
  end
end

  def count
    @all_invoices.count
  end

  def all
    @all_invoices
  end

  def find_by_id(query_id)
    finder = @all_invoices.find do |invoice|
      invoice.id == query_id
    end
  end

  def find_all_by_customer_id(query_customer_id)
    @all_invoices.select do |invoice|
      invoice.customer_id == query_customer_id
    end
  end

  def find_all_by_merchant_id(query_merchant_id)
    @all_invoices.select do |invoice|
      invoice.merchant_id == query_merchant_id
    end
  end

  def find_all_by_status(query_status)
    @all_invoices.select do |invoice|
      invoice.status == query_status
    end
  end


end
