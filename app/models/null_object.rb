class NullObject

  def method_missing(*args, &block)
    self
  end

  def downcase
    ""
  end

end

