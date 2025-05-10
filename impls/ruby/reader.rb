
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
  when /^false$/
    false
  when /^nil$/
    nil
  else
    atom.to_sym # default is symbol type for now
  end
end

def read_list(reader)
  sexp = Array.new
  if reader.next != "("
      raise "Expected list"
  end
  until (token = reader.peek) == ")"
    if not token
      raise "Unexpected EOF"
    end
    sexp.push(read_form(reader))
  end
  reader.next # eliminate last paren
  return sexp
end

def read_form(reader)
  case reader.peek
  when "("
    read_list(reader)
  when ")"
    raise "Error: Unbalanced parentheses"
  else
    read_atom(reader)
  end
end

def read_str(str)
  read_form(Reader.new(str))
end
