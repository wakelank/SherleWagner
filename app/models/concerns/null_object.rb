class NullObject

  def method_missing(*args, &block)
    self
  end

  def hey
    'hey'
  end
  def to_a
    []
  end

end

