require 'pry'
class Customer
  attr_accessor :id, :first_name, :last_name, :created_at, :updated_at, :merchants

  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @merchants = []
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

end
