class InventoryManager
  attr_reader :racks

  def initialize
    @racks = {}
  end

  def restock(racks)
    @racks = racks
  end

  def product_in_rack(code)
    rack(code).product
  end

  def dispense_product(rack)
    rack.set_quantity(rack.quantity - 1)
    rack.product
  end

  def find_rack(code)
    rack(code)
  end

  private

  def rack(code)
    @racks.fetch(code)
  end
end
