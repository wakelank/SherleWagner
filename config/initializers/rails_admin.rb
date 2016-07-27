RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard do
      #only ["Product", "ProductSubType", "Style"]# mandatory
      except ["CompilationRelationship", "EnvironmentShotStyle", "AssociatedProductsProduct"]
    end
    index do
      #only ["Product", "ProductSubType", "Style"]# mandatory
      except ["CompilationRelationship", "EnvironmentShotStyle", "AssociatedProductsProduct"]
    end
    new
    export
    bulk_delete
    show
    edit 
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Product' do
    list do
      field :name do
        label "Collections"
      end
    end
  end

  config.model Product do
    edit do
      field :name
      field :number
      field :display_code
      field :product_type
      field :product_sub_type
      field :image
      field :image_type, :enum do
        enum do
          ['square','tall']
        end
      end
      field :page_section, :enum do
        enum do
          ['A', 'B', 'C', 'D', 'Z']
        end
      end
      field :section_position
      field :display_size_for_collection
      field :product_configurations
      field :genres
      field :styles do
        label "Collection"
      end
      field :associated_collection
      field :finishes
      field :china_colors
      field :materials
      field :compilations
      field :associated_products
      field :other_images
      field :filter_values
      field :spec_sheet_pdf
      field :spec_sheet_2d do
        label "spec sheet 2d (igs only)"
      end
      field :spec_sheet_3d do
        label "spec sheet 3d (dxf only)"
      end
      field :installation_instructions
      #field :styles do
      #  label 'Collection'
      #end
      #
   end
  end

  config.model 'Style' do
    label "Collection"
  end

  config.model 'ProductConfiguration' do
    label "Configuration"
    object_label_method do
      :custom_label_method
    end
    exclude_fields :has_components_relationships
  end

  config.model 'OtherImage' do
    object_label_method do
      :image_name
    end
  end

  config.model 'EnvironmentShot' do
    object_label_method do
      :image_name
    end
    exclude_fields :environment_shot_styles
  end

  config.model "ProductType" do
    edit do
      field :name
      field :image
      field :product_sub_types
      field :products
    end
  end

  config.navigation_static_links = {
    "Edit Homepage" => "/edit_homepage",
    "Test Email" => "/mail_tester"
  }

  def custom_label_method
    "#{self.number}"
  end

  def image_name
    "#{self.image_file_name}"
  end

end
