require_relative 'customer'
class CustomerRepository

  def inspect
    true
  end

  attr_accessor :all, :name

    def initialize(path)
      @all_customers = []
      populate_customer_repo(path)
    end

    def populate_customer_repo(path)
      if path.include? '.csv'
      CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
        customer = Customer.new(data_row)
        @all_customers << customer
      end
      else
        populate_customer_repo_with_hash(path)
      end
    end

  def all
    @all_customers
  end

  def count
    @all_customers.count
  end

  def find_by_id(id)
    @all_customers.find do |customer|
      id == customer.id
    end
  end

  def find_all_by_first_name(first_name)
    @all_customers.select do |element|
       element.first_name.to_s.downcase == first_name.to_s.downcase ? element : nil
    end
  end

  def find_all_by_last_name(last_name)
    @all_customers.select do |element|
       element.last_name.to_s.downcase == last_name.to_s.downcase ? element : nil
    end
  end




end
