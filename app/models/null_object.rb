class NullObject

  def method_missing(*args, &block)
    self
  end

  def downcase
    ""
  end

  def nil?
    true
  end
  
  def to_s
    ""
  end

  def split(*args)
    []
  end


end

