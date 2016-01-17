class CompilationRelationship < ActiveRecord::Base
  belongs_to :component, class_name: "Product"
  belongs_to :compilation, class_name: "Product"
end
