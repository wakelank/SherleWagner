module CanExtractFromFile
  extend ActiveSupport::Concern


  def extract_from(row)
    str = row[self::HEADER] || "NONE"
    str = str.downcase.split.map(&:capitalize).join(' ')
  end

  def case_insensitive_find(find_me)
    self.where('lower(name) = ?', find_me.downcase.strip).first || self.first
  end

  def get_arg(row)
    result = self.extract_from row
    case_insensitive_find(result)
  end

  def assign_attribute(args)
    product = args[:product] || NullObject.new
    row = args[:row] || NullObject.new
    result = self.extract_from row
    case_insensitive_find(result)
    product.product_type = result
  end
end
