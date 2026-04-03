class SimplePredicate
  def initialize(attribute, operator, expected_value)
    @attribute = attribute
    @operator = operator
    @expected_value = expected_value
  end

  def matches?(file)
    actual_value = file.extract(@attribute)

    if actual_value && @operator.matches?(actual_value, @expected_value)
      return true
    end

    return false
  end
end
