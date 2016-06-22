class StaticPagesController < ApplicationController
before_action :authenticate_user!, only: [:edit_homepage, :update_homepage, :upload_page]

  def index
  end

  def home

    aws = AwsHelper.new('sw_homepage')
    @image = "https://s3.amazonaws.com/sw_homepage/homepage_image"
    @copy = aws.homepage_copy
  end

  def edit_homepage
    aws = AwsHelper.new('sw_homepage')
    @copy = aws.homepage_copy
  end

  def update_homepage
      AwsHelper.new('sw_homepage').set_homepage_image
      AwsHelper.new('sw_homepage').set_homepage_copy

    redirect_to root_path
  end

  def update_homepage_preview
    copy = params[:home_page_copy]
    image = params[:homepage_image]
    aws = AwsHelper.new('sw_homepage')
    temp_copy_file = 'public/homepage_preview_copy_file'
    File.open(temp_copy_file, 'w') do |f|
      f.write copy
    end
    File.open(temp_copy_file, 'r') do |f|
      aws.save_homepage_copy_preview(file: f)
    end
    if image
      aws.save_homepage_image_preview(file: image)
    end

    redirect_to homepage_preview_path
  end

  def home_preview
    aws = AwsHelper.new('sw_homepage')
    @preview_image = "https://s3.amazonaws.com/sw_homepage/homepage_image_preview"
    @preview_copy = aws.homepage_preview_copy
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

end
