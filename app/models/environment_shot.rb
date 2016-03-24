class EnvironmentShot < ActiveRecord::Base
  has_many :environment_shot_styles
  has_many :styles, through: :environment_shot_styles

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_product.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }
end
