require_relative "composite_predicate"

class AndPredicate < CompositePredicate
  def initialize(operands)
    @operands = operands
  end

  def matches?(file)
    @operands.each do |operand|
      if !operand.matches?(file)
        return false
      end
    end

    return true
  end
end
