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

  def _path
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
  def name
    ""
  end
  def id
    0
  end


end

