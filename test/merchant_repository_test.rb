require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_it_instantiates_a_merchant_repo
    merchants = MerchantRepository.new
    assert_equal MerchantRepository, merchants.class
  end


end
