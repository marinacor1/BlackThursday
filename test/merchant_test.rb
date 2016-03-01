require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_instantiates
    m = Merchant.new({:id => 5, :name => "Buffalo Exchange"})
    m.instance_of? Merchant 
  end

end
