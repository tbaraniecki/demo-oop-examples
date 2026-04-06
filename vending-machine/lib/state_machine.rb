class State
  def initialize(vm)
    @vm = vm
  end

  def insert_money(amount_cents)
    raise StandardError, 'Disallowed action'
  end

  def select_product(rack_id)
    raise StandardError, 'Disallowed action'
  end

  def dispense_product
    raise StandardError, 'Disallowed action'
  end
end

class IdleState < State
  def insert_money(amount_cents)
    @vm.payment.add_balance(amount_cents)
    @vm.transition_to(MoneyInserted)
  end
end

class MoneyInserted < State
  def select_product(rack_id)
    rack = @vm.inventory.find_rack(rack_id)
    product = rack.get_product
    @vm.current_transaction.rack = rack
    @vm.current_transaction.product = product
    @vm.transition_to(ProductSelected)
  end
end

class ProductSelected < State
  def dispense_product
    if @vm.current_transaction.product.price != @vm.payment.balance_cents
      @vm.payment.return_change
      @vm.transition_to(Failure)
      @vm.cleanup
      return "VendingMachine::GeneralError: Wrong funds inserted"
    end

    @vm.inventory.dispense_product(@vm.current_transaction.rack)
    @vm.current_transaction.dispensed_at = Time.now
    @vm.transition_to(Success)
    @vm.cleanup
  end
end

class Success < State; end
class Failure < State; end
