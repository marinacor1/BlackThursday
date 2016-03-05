require_relative 'sales_engine'
class InvoiceItemRepository
  attr_accessor :all, :name

  def initialize(path)
    @all_invoice_items = []
    populate_ii_repo(path)
  end

  def populate_ii_repo(path)
    if path.include? '.csv'
      CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
        ii = InvoiceItem.new(data_row)
        @all_invoice_items << ii
      end
      else
        populate_ii_repo_with_hash(path)
      end
    end

  def populate_merchant_repo_with_hash(path)
      path.each do
      merchant = InvoiceItem.new(path)
      @all_invoice_items << ii
    end
  end


  def all
    @all_invoice_items
  end

  def find_by_id(id_num)
    @all_invoice_items.find do |ii|
      id_num == ii.id
    end
  end

  def find_all_by_item_id(id_num)
    #returns either [] or matching item
    #with matching item id
  end

  def find_all_by_invoice_id(invoice_num)
    #returns either [] or matching invoice num
    #with matching invoice id
  end

end
