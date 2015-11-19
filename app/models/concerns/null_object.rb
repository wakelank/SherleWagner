class NullObject

  def method_missing(*args, &block)
    self
  end

  def nil?
    true
  end


end

