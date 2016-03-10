require_relative 'sales_engine'
require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository

  def inspect
    "#<#{self.class}>"
  end

  attr_accessor :all, :name

  def initialize
    @all_invoice_items = []
  end

  def all
    @all_invoice_items
  end

  def count
    @all_invoice_items.count
  end

  def find_by_id(id_num)
    @all_invoice_items.find do |item|
      id_num == item.id
    end
  end

  def find_all_by_item_id(id_num)
    @all_invoice_items.select do |item|
      item.item_id == id_num
    end
  end

  def find_all_by_invoice_id(invoice_num)
    @all_invoice_items.select do |item|
      item.invoice_id == invoice_num
    end
  end

  def from_csv(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol}) do |data_row|
      invoice_item = InvoiceItem.new(data_row)
      @all_invoice_items << invoice_item
    end
  end

  def from_array(array)
    array.each do |attributes|
      invoice_item = InvoiceItem.new(attributes)
      @all_invoice_items << invoice_item
    end
  end

end
