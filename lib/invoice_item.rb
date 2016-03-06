class InvoiceItem
  attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes[:id]
    @item_id = attributes[:item_id]
    @invoice_id = attributes[:invoice_id]
    @quantity = attributes[:quantity]
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @invoiceitems = []
    @invoiceitems_count = 0
    unit_price_to_dollars
  end

  def unit_price_to_dollars
    @unit_price = BigDecimal((self.unit_price/100.0), 5) if @unit_price != nil
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

end
