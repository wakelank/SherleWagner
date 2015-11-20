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

  def to_str
    ""
  end


  def split(*args)
    []
  end

  def number
    ""
  end
  def identifier
    ""
  end


end

