require_relative "../lib/file"
require_relative "../lib/file_search"
require_relative "../lib/file_search_criteria"
require_relative "../lib/operators/equal_operator"
require_relative "../lib/predicates/simple_predicate"
require_relative "../lib/predicates/and_predicate"
require "minitest/autorun"

class FileIndexTest < Minitest::Test
  def test_file_search
    root = File.new(is_directory: true, size: 123, owner: "root", filename: "lib")
    file1 = File.new(is_directory: false, size: 456, owner: "file1", filename: "a")
    file2 = File.new(is_directory: false, size: 789, owner: "file2", filename: "c")

    root.add_entry(file1)
    root.add_entry(file2)
    criteria = FileSearchCriteria.new(
      AndPredicate.new(
        [
          SimplePredicate.new(:size, EqualOperator.new, 456),
          SimplePredicate.new(:owner, EqualOperator.new, 'file1'),
        ]
      )
    )

    file_search = FileSearch.new
    result = file_search.search(root, criteria)

    assert_equal 1, result.size
    assert_equal "a", result[0].filename
  end
end
