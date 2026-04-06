require_relative "lib/vending_machine"

class Fixtures
  def self.racks
    {
      'A1' => Rack.new(code: 'A1', quantity: 2, product: Product.new(name: "Cola", price: 150)),
      'A2' => Rack.new(code: 'A2', quantity: 1, product: Product.new(name: "Pepsi", price: 100))
    }
  end

  def self.vm
    vm = VendingMachine.new
    vm.restock(racks)
    vm
  end
end
