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
    i = Invoice.new(data_row)
    @all_invoices << i
  end
end

  def count
    count(@all_invoices)
  end

  def all
    @all_invoices
  end

  def customer_id
    #no clue if this works
    @all_invoices.customer_id
  end

  def find_by_id(id_query)
      #returs nil if no match
      #or returns instances of invoice with matching id
    find_by_id(@all_invoices, id_query)
  end

  def find_all_by_customer_id(query_customer_id)
    find_all_by_num(@all_invoices, query_customer_id, customer_id)
       #returns empty array if no match
       #returns one or more matches with matching id
  end

    def find_all_by_merchant_id(query_merch_id)
      find_all_by_num(@all_invoices, query_merch_id, :merchant_id)
    end

  def find_all_by_status(id_num)
    find_all_by_string(@all_invoices, id_num, status)
   #returns empty array if no match
   #returns one or more matches with matching id

  end


end
