class PaymentProcessor
  attr_reader :balance_cents

  def initialize(balance_cents: 0)
    @balance_cents = balance_cents
  end

  def add_balance(amount_cents)
    @balance_cents += amount_cents
  end

  def return_change
    change = @balance_cents.dup
    @balance_cents = 0

    change
  end
end
