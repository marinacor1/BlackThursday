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
  binding.pry
end

  def count
    count(@all_invoices)
  end

  def all
    @all_invoices
    #returns an array of all known invoice instances
  end

  def find_by_id(query_id)
      #returs nil if no match
      #or returns instances of invoice with matching id
    finder = @all_invoices.find do |invoice|
      invoice.id == query_id
    end
  end

  def find_all_by_customer_id(query_customer_id)
    @all_invoices.select do |invoice|
      invoice.merchant_id == query_customer_id
    end
       #returns empty array if no match
       #returns one or more matches with matching id
  end

  def find_all_by_status(id_num)
   #returns empty array if no match
   #returns one or more matches with matching id
  end


end
