class InvoiceItemRepository

  def all
    #returns array of all invoiceitem instances
  end

  def find_by_id(id_num)
    #returns nil or instance of Invoice Item with matching ID
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
