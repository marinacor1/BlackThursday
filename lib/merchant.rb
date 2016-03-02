require 'pry'
class Merchant
  attr_accessor :id, :name, :created_at, :updated_at, :items, :item_count

  def initialize(data)
    unless data.length < 3
    data.each do |info|
    @id = info[:id]
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    end
  end
  end

end
