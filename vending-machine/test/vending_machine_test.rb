require "minitest/autorun"
require "pry"
require_relative "../lib/vending_machine"

class VendingMachineTest < Minitest::Test
  def setup
    @inventory = InventoryManager.new
    @payment = PaymentProcessor.new

    @racks = {
      'A1' => Rack.new(code: 'A1', quantity: 2, product: Product.new(name: "Cola", price: 150)),
      'A2' => Rack.new(code: 'A2', quantity: 1, product: Product.new(name: "Pepsi", price: 100))
    }

    @vm = VendingMachine.new(
      inventory: @inventory,
      payment: @payment
    )
  end

  def test_admin_restocs_vending_machine
    assert_equal 0, @inventory.racks.size
    @vm.restock(@racks)
    assert_equal 2, @inventory.racks.size
  end

  def test_purchase
    @vm.restock(@racks)
    @vm.insert_money(150)
    @vm.select_product("A1")
    @vm.dispense_product

    transactions = @vm.transactions
    txn = transactions.last
    assert_equal 'Cola', txn.product.name
    assert_equal 1, transactions.size
    assert txn.dispensed_at != nil
  end

  def test_wrong_amount_inserted
    @vm.restock(@racks)
    @vm.insert_money(100)
    @vm.select_product("A1")
    result = @vm.dispense_product

    assert_equal "VendingMachine::GeneralError: Wrong funds inserted", result
  end
end
