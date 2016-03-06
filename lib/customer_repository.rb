require_relative 'customer'
require 'pry'
class CustomerRepository
include Repository

  def inspect
    true
  end

  attr_accessor :all

    def initialize
      @all_customers = []
    end

    def from_csv(path)
      if path.include? '.csv'
      CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
        customer = Customer.new(data_row)
        @all_customers << customer
      end
      else
        populate_customer_repo_with_hash(path)
      end
    end

  def populate_customer_repo_with_hash(customers)
    @all_customers = customers
  end

  def all
    @all_customers
  end

  def count
    @all_customers.count
  end

  def find_by_id(id)
    @all_customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(fragment)
    @all_customers.select do |element|
       element.first_name.to_s.downcase.include?(fragment.to_s.downcase) ? element : nil
    end
  end

  def find_all_by_last_name(fragment)
    @all_customers.select do |element|
       element.last_name.to_s.downcase.include?(fragment.to_s.downcase) ? element : nil
    end
  end




end
