module CanExtractFromFile
  extend ActiveSupport::Concern


  def extract_from(row)
    row[self::HEADER] || "NONE"
  end

  def case_insensitive_find(find_me)
    self.where('lower(name) = ?', find_me.downcase.strip).first || self.first 
  end

  def get_arg(row)
    result = self.extract_from row
    case_insensitive_find(result)
  end
end

