require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end

  def self.from_csv(data)
    self.new(data)
    contents = CSV.open data, headers: true, header_converters: :symbol
    contents.to_a.map {|row| row.to_h}
  end

end
