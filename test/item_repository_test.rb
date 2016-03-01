require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'


class ItemRepositoryTest < Minitest::Test

  def test_it_instantiates_an_item_repo
    items = ItemRepository.new
    assert_equal ItemRepository, items.class
  end

  def test_it_instantiates_with_item_subclass
  end



end
