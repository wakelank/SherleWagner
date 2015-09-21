class FilterProductValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :filter
  belongs_to :filter_value

  validates :filter, uniqueness: { scope: :product }
  validates :filter_value, uniqueness: { scope: [:product, :filter] }

  def self.unique_filters
    filters = []
    filter_names = []
    fpvs = FilterProductValue.select(:filter_id, :filter_value_id).uniq
    fpvs.each do |fpv|
      filter_name = fpv.filter.name
      filter_value = fpv.filter_value.name
      if filter_names.include? filter_name
        this_filter = filters.select { |filter| filter[:name] == filter_name }.first
        this_filter[:values].push(filter_value)
      else
        hash = { :name => filter_name, :values => [filter_value] }
        filter_names.push filter_name
        filters.push(hash)
      end
    end
    filters
  end

end
