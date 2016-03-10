require 'pry'
require 'csv'
require_relative 'data_parser'
require_relative 'data_relationships'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine
  include DataParser
  include DataRelationships
  attr_accessor :items,
                :merchants,
                :invoices,
                :invoice_items,
                :customers,
                :transactions

  def initialize(data)
    if data
      create_repositories(data)
      populate_repositories(data)
      repositories_linked
    end
  end

  def create_repositories(data)
    @items = ItemRepository.new if data[:items]
    @merchants = MerchantRepository.new if data[:merchants]
    @invoices = InvoiceRepository.new if data[:invoices]
    @invoice_items = InvoiceItemRepository.new if data[:invoice_items]
    @customers = CustomerRepository.new if data[:customers] != nil
    @transactions = TransactionRepository.new if data[:transactions]
  end

  def self.from_csv(data)
    self.new(data)
  end

  def populate_repositories(data)
    load_data(data[:items], @items, Item) if items
    load_data(data[:merchants], @merchants, Merchant) if merchants
    load_data(data[:invoices], @invoices, Invoice) if invoices
    load_data(data[:invoice_items], @invoice_items, InvoiceItem) if invoice_items
    load_data(data[:customers], @customers, Customer) if customers
    load_data(data[:transactions], @transactions, Transaction) if transactions
  end


end
