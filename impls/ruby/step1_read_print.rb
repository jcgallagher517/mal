require "readline"
require_relative "reader"
require_relative "printer"

def READ(str)
  return read_str(str)
end

def EVAL(expre)
  return expre
end

def PRINT(result)
  print "=> "
  pr_str(result)
end

while buf = Readline.readline("user> ", true)
  PRINT(EVAL(READ(buf)))
end
