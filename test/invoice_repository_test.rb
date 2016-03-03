require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def test_invoice_repository_instantiates
    ir = InvoiceRepository.new
    ir.instance_of? InvoiceRepository
  end

  def test_invoice_repository_contains_invoice_instances
    skip
    ir = InvoiceRepository.new
    i.instance_of? InvoiceRepository
  end

  def test_all_returns_array_of_all_known_invoice_instances
    skip
    ir = InvoiceRepository.new
    invoice_array = []
    assert_equal invoice_array, ir.all
    assert_equal Array, ir.all.class
    assert_equal Invoice, ir.all[0].class
  end

  def test_find_by_id_returns_correct_invoice
    skip
    ir = InvoiceRepository.new
    correct_invoice
    assert_equal correct_invoice, ir.find_by_id(12335938)
    assert_equal Invoice, correct_invoice.class
  end

  def test_

end
