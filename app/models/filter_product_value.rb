class FilterProductValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :filter
  belongs_to :filter_value

  validates :filter, uniqueness: { scope: :product }
  validates :filter_value, uniqueness: { scope: [:product, :filter] }

  def self.unique_filters
    filters = []
    fpvs = FilterProductValue.select(:filter_id, :filter_value_id).uniq
    fpvs.each do |fpv|
      hash = { :name => fpv.filter.name, :value => fpv.filter_value.name }
      filters.push(hash)
    end
    filters
  end

end
