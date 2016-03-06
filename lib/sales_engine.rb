require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_accessor :items, :merchants, :invoices, :invoice_items, :customers, :transactions

  def initialize(data=nil)
    repos = create_repositories
    populate_repositories(data, repos)
    repositories_linked if @merchants != nil
  end

  def create_repositories
    repos = Hash.new
    repos[@items = ItemRepository.new] = :items
    repos[@merchants = MerchantRepository.new] = :merchants
    repos[@invoices = InvoiceRepository.new] = :invoices
    repos[@invoice_items = InvoiceItemRepository.new] = :invoice_items
    repos[@customers = CustomerRepository.new] = :customers
    repos[@transactions = TransactionRepository.new] = :transactions
    repos
  end

  def populate_repositories(data, repos)
    repos.keys.each do |repository|
      repository.from_csv(data[repos[repository]]) if data[repos[repository]]
    end
  end

  def repositories_linked
    merchants_linked_to_child_items
    child_items_linked_to_parent
  end

  def merchants_linked_to_child_items
    @merchants.all.map do |merchant|
      link_merchant_to_items(merchant)
      link_merchant_to_invoices(merchant)
    end
  end

  def link_merchant_to_items(merchant)
    if @items != nil
      merchant.items = @items.find_all_by_merchant_id(merchant.id)
      merchant.item_count = merchant.items.count
    end
  end

  def link_merchant_to_invoices(merchant)
    if @invoices != nil
      merchant.invoices = @invoices.find_all_by_merchant_id(merchant.id)
      merchant.invoice_count = merchant.invoices.count
      merchant
    end
  end

  def child_items_linked_to_parent
    items_linked_to_merchants
    invoices_linked_to_merchants
    invoices_linked_to_customers_and_merchants
  end

  def items_linked_to_merchants
    if @items != nil
      @items.all.map do |item|
        item.merchant = @merchants.find_by_id(item.merchant_id)
      end
    end
  end

  def invoices_linked_to_merchants
    if @invoices != nil
      @invoices.all.map do |invoice|
        invoice.merchant =  @merchants.find_by_id(invoice.merchant_id)
      end
    end
  end

  def invoices_linked_to_customers_and_merchants
    if @invoices != nil
      @invoices.all.each do |invoice|
      customer = link_customer_and_invoice(invoice)
      link_merchant_to_customers_and_invoices(invoice, customer)
      end
    end
  end

  def link_customer_and_invoice(invoice)
    customer = @customers.find_by_id(invoice.customer_id)
    invoice.customer = customer
  end

  def link_merchant_to_customers_and_invoices(invoice, customer)
    merchant = @merchants.find_by_id(invoice.merchant_id)
    invoice.merchant = merchant
    customer.merchants << merchant
    merchant.customers << customer
  end

  def self.from_csv(data)
    all_instances = self.new(data)
  end

end

if __FILE__ == $0

  se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    se.repositories_linked

    binding.pry

  end
