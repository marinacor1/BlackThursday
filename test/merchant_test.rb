require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_instantiates
    m = Merchant.new({:id => 5, :name => "Buffalo Exchange"})
    m.instance_of? Merchant
  end

  def test_merchant_access_id_and_name_from_data
    m = Merchant.new({:id => 5, :name => "Buffalo Exchange"})
    assert_equal 5, m.id
    assert_equal "Buffalo Exchange", m.name
  end

end
