require "readline"
require_relative "reader"

def READ(str)
  return str
end

def EVAL(expre)
  return expre
end

def PRINT(result)
  puts "=> " + result.to_s
end

while buf = Readline.readline("user> ", true)
  PRINT(EVAL(READ(buf)))
end
