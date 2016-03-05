require 'pry'
require 'csv'
require_relative 'invoice'
require_relative 'sales_engine'
require_relative 'repository'

class InvoiceRepository
  include Repository
  attr_accessor :all

  def inspect
    true
  end

  def initialize(path)
    @all_invoices = []
    if path.include?('.csv')
      populate_invoice_repo_with_data_from_csv(path)
    else
      @all_invoices << path.flatten
    end
  end

  def populate_invoice_repo_with_data_from_csv(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      i = Invoice.new(data_row)
      @all_invoices << i
    end
    @all_invoices
  end

  def count
    count(@all_invoices)
  end

  def all
    @all_invoices
  end

  def find_by_id(id_query)
    binding.pry
    find_with_id(@all_invoices, id_query)
  end

  def find_all_by_customer_id(query_customer_id)
    find_all_by_num(@all_invoices, query_customer_id, customer_id)
  end

  def find_all_by_merchant_id(query_merch_id)
    find_all_by_num(@all_invoices, query_merch_id, :merchant_id)
  end

  def find_all_by_status(id_num)
    find_all_by_string(@all_invoices, id_num, status)
  end



end
