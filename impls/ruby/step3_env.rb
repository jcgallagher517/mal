require "readline"
require_relative "reader"
require_relative "printer"
require_relative "env"

base_env = {'+': ->(a, b) { a + b },
            '-': ->(a, b) { a - b },
            '*': ->(a, b) { a * b },
            '/': ->(a, b) { a / b }}

# instantiate repl environment
repl_env = Env.new
repl_env.data.merge!(base_env)
repl_env.set(:'DEBUG-EVAL', nil)

def READ(str)
  return read_str(str)
end

def EVAL(ast, env)

  if env.data.keys.include?(:'DEBUG-EVAL') && env.data[:'DEBUG-EVAL']
    print "EVAL: "
    pr_str(ast)
  end

  if ast.is_a?(Array) && ast.empty?
    return nil
  elsif ast.is_a?(Array) && !ast.empty?

    ast[1..].inject do |a, b|
      case ast.first
      when :'def!'
        env.set(a, EVAL(b, env))
        EVAL(a, env)
      when :'let*'
        inner = Env.new(env)
        a.each_slice(2).each { |name, val| inner.set(name, EVAL(val, inner)) }
        EVAL(b, inner)
      else
        # here, make sure env lookup is a non-fatal error
        # i.e. that it doesn't kill the repl
        env.get(ast.first).call(EVAL(a, env), EVAL(b, env))
      end
    end

  else
    ast.is_a?(Symbol) ? env.get(ast) : ast
  end

end

def PRINT(result)
  print "=> "
  pr_str(result)
end

while buf = Readline.readline("user> ", true)
  PRINT(EVAL(READ(buf), repl_env))
end
