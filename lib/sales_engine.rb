require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_accessor :items, :merchants, :invoices

  def initialize(data)
    @items = ItemRepository.new(data[:items]) if data[:items] != nil
    @merchants = MerchantRepository.new(data[:merchants]) if data[:merchants] != nil
    @invoices = InvoiceRepository.new(data[:invoices]) if data[:invoices] != nil
  end

  def repositories_linked
    merchants_linked_to_child_items
    items_linked_to_parent_merchant
  end

  def merchants_linked_to_child_items
    @merchants.all.map do |merchant|
      merchant.items = @items.find_all_by_merchant_id(merchant.id)
      merchant.item_count = merchant.items.count
      merchant.invoices = @invoices.find_all_by_merchant_id(merchant.id)
      merchant.invoice_count = merchant.invoices.count
      merchant
    end
  end

  def items_linked_to_parent_merchant
    @items.all.map do |item|
      item.merchant = @merchants.find_by_id(item.merchant_id)
    end
    @invoices.all.map do |invoice|
      invoice.merchant =  @merchants.find_by_id(invoice.merchant_id)
    end

  end

  def self.from_csv(data)
    all_instances = self.new(data)
  end

end

if __FILE__ == $0

  se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"
    })
    se.repositories_linked
    binding.pry
end
