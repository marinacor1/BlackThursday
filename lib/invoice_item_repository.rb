require_relative 'sales_engine'
require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository

  def inspect
    "#<#{self.class}>"
  end

  attr_accessor :all, :name

  def initialize(path)
    @all_invoice_items = []
    load_data(path)
  end

  def load_data(path)
    if path.include? '.csv'
      CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
        item = InvoiceItem.new(data_row)
        @all_invoice_items << item
      end
      else
        populate_ii_repo_with_hash(path)
      end
  end

  def from_csv(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      invoice_item = InvoiceItem.new(data_row)
      @all_invoice_items << invoice_item
    end
  end

  def populate_ii_repo_with_hash(path)
    @all_invoice_items = path
  end

  def from_array(array)
    array.each do |attributes|
      invoice_item = InvoiceItem.new(attributes)
      @all_invoice_items << invoice_item
    end
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

end
