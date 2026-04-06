require_relative "product"
require_relative "rack"
require_relative "inventory_manager"
require_relative "payment_processor"
require_relative "transaction"
require_relative "state_machine"

class VendingMachine
  attr_reader :payment, :inventory, :current_transaction

  def initialize(inventory: InventoryManager.new, payment: PaymentProcessor.new)
    @inventory = inventory
    @payment = payment
    @transaction_history = []
    @current_transaction = Transaction.new
    @state = IdleState.new(self)
  end

  def state
    @state
  end

  def transition_to(state_class)
    @state = state_class.new(self)
  end

  # User
  def insert_money(amount_cents)
    @state.insert_money(amount_cents)
  end

  def select_product(rack_id)
    @state.select_product(rack_id)
  end

  def dispense_product
    @state.dispense_product
  end

  def cleanup
    @transaction_history << @current_transaction.dup
    @current_transaction = Transaction.new
  end

  # Admin
  def restock(racks)
    @inventory.restock(racks)
  end

  def transactions
    @transaction_history.dup
  end
end
