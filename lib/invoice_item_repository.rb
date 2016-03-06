require_relative 'sales_engine'
require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository
  def inspect
    true
  end
  
  attr_accessor :all, :name

  def initialize(path)
    @all_invoice_items = []
    populate_ii_repo(path)
  end

  def populate_ii_repo(path)
    if path.include? '.csv'
      CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
        item = InvoiceItem.new(data_row)
        @all_invoice_items << item
      end
      else
        populate_ii_repo_with_hash(path)
      end
    end

  def populate_ii_repo_with_hash(path)
      path.each do
      item = InvoiceItem.new(path)
      @all_invoice_items << item
    end
  end

  def all
    @all_invoice_items
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
      item.invoice_id == id_num
    end
  end

end
