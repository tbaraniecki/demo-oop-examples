require_relative "composite_predicate"

class NotPredicate < CompositePredicate
  def initialize(operands)
    @operands = operands
  end

  def matches?(file)
    @operands.none? do |operand|
      operand.matches?(file)
    end
  end
end
