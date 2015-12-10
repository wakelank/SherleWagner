module SnakeCase
  extend ActiveSupport::Concern

  def snake_case string
    string.squash.downcase.tr(' ','_')
  end
end
