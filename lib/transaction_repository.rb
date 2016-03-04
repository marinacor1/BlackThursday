class TransactionRepository

  def all
    #returns an array of all transaction instances
  end

  def find_by_id(id)
    #returns nil or transaction with a matching id
  end

  def find_all_by_invoice_id(id)
    #returns [] or matches which have a matching credit card number
  end

  def find_all_by_result(status)
    #returns [] or matches with matching cc number
  end

  


end
