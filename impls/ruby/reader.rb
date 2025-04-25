
def tokenize(input)
  str.scan(/[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)/)
end

class Reader

  # equivalent of "read_str" as defined in MAL process
  def initialize(input)
    @tokens = tokenize(input)
    @position = 1
  end
  
  def next
    @position += 1
    return @tokens[@position - 1]
  end

  def peek
    return @tokens[@position]
  end

end
