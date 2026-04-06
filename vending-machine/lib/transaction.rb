class Transaction
  attr_accessor :rack, :product, :dispensed_at

  def initialize
    @initialized_at = Time.now
    @rack = nil
    @product = nil
    @dispensed_at = nil
  end
end
