require 'pry'
require 'csv'
require_relative 'invoice'
require_relative 'sales_engine'
require_relative 'repository'

class InvoiceRepository
  def inspect
    true
  end

  attr_accessor :all

  def initialize
    @all_invoices = []
  end

  def from_csv(path)
  CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
    invoice = Invoice.new(data_row)
    @all_invoices << invoice
  end
end

  def count
    @all_invoices.count
  end

  def all
    @all_invoices
  end

  def find_by_id(id_query)
    @all_invoices.find do |element|
      id_query == element.id
    end
  end

  def find_all_by_merchant_id(query_merch_id)
    @all_invoices.find_all do |invoice|
      invoice.merchant_id == query_merch_id
    end
  end

  def find_all_by_customer_id(query_customer_id)
    @all_invoices.find_all do |invoice|
      invoice.customer_id == query_customer_id
    end
  end

  def find_all_by_status(status)
    @all_invoices.select do |element|
       element.status.to_s.downcase == status.to_s.downcase ? element : nil
    end
  end



end
