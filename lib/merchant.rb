class Merchant
  attr_accessor :id, :name, :created_at, :updated_at, :items, :item_count

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    binding.pry
  end


end
