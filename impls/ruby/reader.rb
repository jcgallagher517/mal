
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
  when /^(?:nil|false)$/
    false
  else
    atom # default is symbol type for now
  end
end

# this doesn't quite work because it halts at the end of the first list
def read_list(reader)
  sexp = Array.new
  until reader.peek == ")"
    sexp.push(read_form(reader))
  end
  return sexp 
end

def read_form(reader)
  if reader.peek == "("
    reader.next
    read_list(reader)
  else
    read_atom(reader)
  end
end

def read_str(str)
  read_form(Reader.new(str))
end

