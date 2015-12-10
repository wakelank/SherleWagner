module SnakeCase
  extend ActiveSupport::Concern

  def snake_case string
    string.squish.downcase.tr(' ','_')
  end
end
