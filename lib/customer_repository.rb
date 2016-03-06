class CustomerRepository

  def inspect
    true
  end

  def all
    #returns an array of all customer instances
  end

  def find_by_id(id)
    #returns nil or customer with a matching id
  end

  def find_all_by_first_name(first_name)
    #returns [] or matches which have a matching credit card number
  end

  def find_all_by_last_name(last_name)
    #returns [] or matches with matching cc number
  end




end
