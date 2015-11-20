class Genre < ActiveRecord::Base
  has_many :styles
  has_and_belongs_to_many :product_groups
  has_and_belongs_to_many :products

  def self.get_arg(row)
    result = self.extract_from row
    case_insensitive_find(result)
  end

  def self.extract_from(row)
    (row["GENRES"] || NullObject.new).split(',')
  end

  def self.case_insensitive_find(find_mes)
    arr = []
    find_mes.each do |find_me|
      if !find_me.nil?
        genre = self.where('lower(name) = ?', find_me.downcase.strip).first || NullObject.new
        arr << genre if !genre.nil?
      end
    end
    arr
  end


end
