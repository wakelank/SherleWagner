class ProductConfiguration < ActiveRecord::Base

  belongs_to :product

  def self.get_arg(row)
    row["IMAGE FILE"] || NullObject.new() 
  end

end

