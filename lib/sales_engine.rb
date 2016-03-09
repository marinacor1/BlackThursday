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

  def self.from_csv(data)
    self.new(data)
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
    merchants_linked_to_child_items if merchants
    merchants_invoices_and_customers_interrelated if merchants && invoices && items && customers
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
      merchant.items.map do |item|
        item.merchant = merchant
      end
      merchant
    end
  end

  def link_merchant_to_invoices(merchant)
    if @invoices != nil
      merchant.invoices = @invoices.find_all_by_merchant_id(merchant.id)
      merchant.invoice_count = merchant.invoices.count
      merchant.invoices.map do |invoice|
        invoice.merchant = merchant
      end
    end
    merchant
  end

  def merchants_invoices_and_customers_interrelated
    if @invoices != nil
      @invoices.all.map do |invoice|
        link_items_and_invoice(invoice)
        link_transaction_and_invoice(invoice)
        customer = link_customer_and_invoice(invoice)
        link_merchant_to_customers_via_invoice(invoice, customer)
        remove_duplicate_customers_and_merchants
      end
    end
  end

  def link_items_and_invoice(invoice)
    all_invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
    total = 0
    all_invoice_items.map do |invoice_item|
      invoice_total = total_invoice_prices(invoice, invoice_item)
      total += invoice_total
      populate_invoice_items_array(invoice, invoice_item)
    end
    invoice.total = BigDecimal(total)
  end

  def total_invoice_prices(invoice, invoice_item)
    invoice_total = (invoice_item.unit_price*invoice_item.quantity)
  end

  def populate_invoice_items_array(invoice, invoice_item)
    item = @items.find_by_id(invoice_item.item_id)
    invoice.items << item
    item
  end

  def link_transaction_and_invoice(invoice)
    all_invoice_transactions = @transactions.find_all_by_invoice_id(invoice.id)
    all_invoice_transactions.map do |transaction|
      transaction.invoice = invoice
      invoice.transactions << transaction
    end
  end


  def link_customer_and_invoice(invoice)
    customer = @customers.find_by_id(invoice.customer_id)
    invoice.customer = customer
    customer.invoices << invoice
  end

  def link_merchant_to_customers_via_invoice(invoice, customer)
    merchant = @merchants.find_by_id(invoice.merchant_id)
    invoice.customer.merchants << merchant
    merchant.customers << invoice.customer
  end

  def remove_duplicate_customers_and_merchants
    @merchants.all.map do |merchant|
      merchant.customers = merchant.customers.uniq
    end
    @customers.all.map do |customer|
      customer.merchants = customer.merchants.uniq
    end
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
