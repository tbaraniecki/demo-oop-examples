require_relative "composite_predicate"

class OrPredicate < CompositePredicate
  def initialize(operands)
    @operands = operands
  end

  def matches?(file)
    @operands.any? do |operand|
      operand.matches?(file)
    end
  end
end
