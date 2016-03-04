require 'pry'
require 'csv'
require_relative 'invoice'
require_relative 'sales_engine'
require_relative 'repository'

class InvoiceRepository
  include Repository
  attr_accessor :all

  def initialize(path)
    @all_invoices = []
    populate_invoice_repo_with_data_from_csv(path)
  end

  def populate_invoice_repo_with_data_from_csv(path)
  CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
    invoice = Invoice.new(data_row)
    @all_invoices << invoice 
  end
end

  def count
    count(@all_invoices)
  end

  def all
    @all_invoices
  end

  def find_by_id(id_query)
    find_by_id(@all_invoices, id_query)
  end

  def find_all_by_customer_id(query_customer_id)
    find_all_by_num(@all_invoices, query_customer_id, customer_id)
  end

  def find_all_by_status(id_num)
    find_all_by_string(@all_invoices, id_num, status)
  end


end
