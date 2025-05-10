require "readline"
require_relative "reader"
require_relative "printer"

repl_env = {'+': ->(a, b) { a + b },
            '-': ->(a, b) { a - b },
            '*': ->(a, b) { a * b },
            '/': ->(a, b) { a / b }}

def READ(str)
  return read_str(str)
end

def EVAL(ast, repl_env)
  unless ast.is_a?(Array)
    return ast
  end
  if repl_env.keys.include?(ast.first)
    ast[1..].inject { |a, b| repl_env[ast.first]
                        .call(EVAL(a, repl_env), EVAL(b, repl_env)) }
  else
    raise "Invalid symbol encountered."
  end
end

def PRINT(result)
  print "=> "
  pr_str(result)
end

while buf = Readline.readline("user> ", true)
  PRINT(EVAL(READ(buf), repl_env))
end
