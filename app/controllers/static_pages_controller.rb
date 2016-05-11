class StaticPagesController < ApplicationController
before_action :authenticate_user!, only: [:edit_homepage, :update_homepage, :upload_page]

  def index
  end

  def edit_homepage
    @copy = File.read(homepage_copy_file)
  end

  def update_homepage
    FileUtils.cp homepage_preview_copy_file, homepage_copy_file
    FileUtils.cp homepage_preview_image_file, homepage_image_file

    redirect_to root_path
  end

  def update_homepage_preview
    copy = params[:home_page_copy]
    image = params[:homepage_image]
    File.open(homepage_preview_copy_file, 'w') { |f| f.write copy }
    if image
      File.open(homepage_preview_image_file, 'wb') { |f| f.write image.read }
    end

    redirect_to homepage_preview_path

  end

  def home_preview

  end

  
  def upload_page
  end

  def catalog
  end

  def contact
  end

  def showrooms
  end

  def history
  end


  private
  
  def homepage_preview_copy_file
    'public/home_page_preview_copy.html'
  end

  def homepage_copy_file
    'public/home_page_copy.html'
  end

  def homepage_preview_image_file
    "public/images/sw_home1_preview.jpg"
  end

  def homepage_image_file
    "public/images/sw_home1.jpg"
  end
end
