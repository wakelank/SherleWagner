RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard do
      only ["Product"]# mandatory
    end
    index do
      only ["Product"]# mandatory
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
      field :product_type
      field :product_sub_type
      field :image
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
      field :other_images
      field :filter_values
      #field :styles do
      #  label 'Collection'
      #end
   end
  end

  config.model 'Style' do
    label "Collection"
  end

  config.model 'ProductConfiguration' do
    object_label_method do
      :custom_label_method
    end
  end

  config.model 'OtherImage' do
    object_label_method do
      :image_name
    end
  end

  def custom_label_method
    "#{self.number}"
  end

  def image_name
    "#{self.image_file_name}"
  end

end
