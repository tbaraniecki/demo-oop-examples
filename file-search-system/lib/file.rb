class File
  ATTRIBUTES = %i[is_directory size owner filename]

  attr_reader :is_directory, :size, :owner, :filename, :entries

  def initialize(is_directory:, size:, owner:, filename:)
    @is_directory = is_directory
    @size = size
    @owner = owner
    @filename = filename
    @entries = []
  end

  def extract(attribute_name)
    raise ArgumentError, "invalid attribute name" if !ATTRIBUTES.include?(attribute_name)

    public_send(attribute_name)
  end

  def add_entry(file)
    @entries << file
    self
  end
end
