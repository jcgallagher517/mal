
test_str = "(* 76/4 0.9 (+ 5 6))"

def tokenize(input)
  pattern = /[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)/
  input.scan(pattern).flatten.select { |e| e != "" }
end

class Reader

  def initialize(input)
    @tokens = tokenize(input)
    @position = 0
  end
  
  def next
    @position += 1
    return @tokens[@position - 1]
  end

  def peek
    return @tokens[@position]
  end

end


# something is wrong with my regex here
# does the plus sign increment a number?!
# that appears to be what it's doing

def read_atom(reader)
  atom = reader.next
  case atom
  when /^[+-]?\d+$/
    atom.to_i
  when /^[+-]?(?:\d+\.\d*|.\d+)$/
    atom.to_f
  when /^[+-]?\d+\/[1-9]+$/
    atom.to_r
  when /^true$/
    true
  when /^(?:nil|false)$/
    false
  else
    atom # default is symbol type for now
  end
end

# the mutual recursion between read_list and read_form has issues

def read_list(reader)
  until reader.next == ")"
    read_form(reader)
  end
end

def read_form(reader)
  if reader.peek == "("
    read_list(reader)
  else
    read_atom(reader)
  end
end

def read_str(str)
  read_form(Reader.new(str))
end

