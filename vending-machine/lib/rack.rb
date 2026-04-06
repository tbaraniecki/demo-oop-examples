class Rack
  attr_reader :code, :product, :quantity

  def initialize(code:, quantity:, product:)
    @code = code
    @product = product
    @quantity = quantity
  end

  def get_product
    raise ProductUnavailable if @quantity < 1

    product
  end

  def set_quantity(quantity)
    @quantity = quantity
  end
end
