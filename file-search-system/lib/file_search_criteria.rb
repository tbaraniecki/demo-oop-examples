class FileSearchCriteria
  def initialize(predicate)
    @predicate = predicate
  end

  def matches?(file)
    @predicate.matches?(file)
  end
end
