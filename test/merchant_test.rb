require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def test_merchant_instantiates
    m = Merchant.new({:id => 5, :name => 'Payless'})
    m.instance_of? Merchant
  end

  def test_merchant_access_name_from_data
    hash = {:items => "./data/items.csv", :merchants => "./data/subsets/merchants_small.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    assert_equal mr.all[1].name, "Candisart"
    assert mr.all[0].instance_of? Merchant
  end

  def test_merchant_access_id_from_data
    hash = {:items => "./data/items.csv", :merchants => "./data/subsets/merchants_small.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    assert_equal 12334105, mr.all[0].id
  end


end
