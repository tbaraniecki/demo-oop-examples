class FileSearch
  def search(root, criteria)
    result = []
    recursion_stack = []

    recursion_stack += [root]

    while !recursion_stack.empty?
      file = recursion_stack.pop
      recursion_stack += file.entries

      if criteria.matches?(file)
        result << file
      end
    end

    result
  end
end
