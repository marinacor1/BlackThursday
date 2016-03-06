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

  def initialize(data)
    if data != nil
      repos = create_repositories(data)
      populate_repositories_appropriately(data, repos)
      repositories_linked
    end
  end

  def create_repositories(data)
    repos = Hash.new
    repos[@items = ItemRepository.new] = :items if data[:items] != nil
    repos[@merchants = MerchantRepository.new] = :merchants if data[:merchants] != nil
    repos[@invoices = InvoiceRepository.new] = :invoices if data[:invoices] != nil
    repos[@invoice_items = InvoiceItemRepository.new] = :invoice_items if data[:invoice_items] != nil
    repos[@customers = CustomerRepository.new] = :customers if data[:customers] != nil
    repos[@transactions = TransactionRepository.new] = :transactions if data[:transactions] != nil
    return repos
  end

  def populate_repositories_appropriately(data, repos)
    repos.keys.each do |repository|
      redirect_csv_and_hash_data(data, repos, repository)
    end
  end

  def redirect_csv_and_hash_data(data, repos, repository)
    if data[repos[repository]].include?('csv')
      repository.from_csv(data[repos[repository]])
    else
      repository.from_array(data[repos[repository]])
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
    if merchants
      items_linked_to_merchants if items
      invoices_linked_to_merchants if invoices
      invoices_linked_to_customers_and_merchants_and_items if invoices && items && customers
      invoices_linked_to_items if invoices && items && customers
    end
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

  def invoices_linked_to_customers_and_merchants_and_items
    if @invoices != nil
      @invoices.all.each do |invoice|
        link_items_and_invoices(invoice)
        customer = link_customer_and_invoice(invoice)
        link_merchant_to_customers_and_invoices(invoice, customer)
      end
    end
  end

  def link_items_and_invoices(invoice)
    all_invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
    item_array = all_invoice_items.map do |invoice_item|
      @items.find_by_id(invoice_item.item_id)
    end
    binding.pry
  end


  def link_customer_and_invoice(invoice)
    customer = @customers.find_by_id(invoice.customer_id)
    invoice.customer = customer
    customer.invoices << invoice
  end

  def link_merchant_to_customers_and_invoices(invoice, customer)
    merchant = @merchants.find_by_id(invoice.merchant_id)
    binding.pry
    invoice.merchant = merchant
    customer.merchants << merchant
    merchant.customers << customer
    merchant.invoices << invoice
    binding.pry
  end

  def self.from_csv(data)
    all_instances = self.new(data)
  end

end


if __FILE__ == $0

  engine = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    binding.pry
end
