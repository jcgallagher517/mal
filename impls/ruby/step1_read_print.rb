require "readline"

def READ(str)
  return str
end

def EVAL(expre)
  return expre
end

def PRINT(result)
  puts "=> " + result
end

while buf = Readline.readline("user> ", true)
  PRINT(EVAL(READ(buf)))
end

