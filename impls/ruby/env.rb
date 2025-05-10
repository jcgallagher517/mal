
class Env

  attr_reader :data

  # outer is itself an Env instance
  def initialize(outer = nil)
    @data = Hash.new
    @outer = outer
  end

  # alias of merge
  def set(sym, val)
    data.merge!({sym => val})
  end

  def get(sym)
    if data.keys.include?(sym)
      return data[sym]
    elsif @outer
      @outer.get(sym)
    else
      raise "Unidentified symbol #{sym}"
    end
  end

end
