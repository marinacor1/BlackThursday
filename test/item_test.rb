require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test

def it_instantiates_an_item_object
  item = Item.new
  assert_equal Item, item.class
end


end
