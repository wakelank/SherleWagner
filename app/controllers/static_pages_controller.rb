class StaticPagesController < ApplicationController
before_action :authenticate_user!, only: [:edit_homepage, :update_homepage, :upload_page]

  def index
  end

  def home

    aws = AwsHelper.new('sw_homepage')
    @image = "https://s3.amazonaws.com/sw_homepage/homepage_image"
    # @copy = aws.homepage_copy
    @copy = temp_homepage_copy
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

  def mail_tester
    @favorites = Favorites.new(favorites_args).all || [NullObject.new]

  end

  
  def upload_page
  end

  def catalog
  end

  def contact
    if params["file"]
      @file = params["file"].gsub('_',' ').titleize
      
      flash[:success] = "We're sorry your requested #{@file} file is not available for download. Please contact our main office: 1 - (212) 758-3300"
      
    end
  end

  def showrooms
  end

  def history
  end

  private

  def favorites_args
    if cookies[:favorites] && cookies[:favorites].length > 2
      args = {}
      args[:favorites] = JSON.parse(cookies[:favorites])
      args
    else
      NullObject.new
    end
  end


  def temp_homepage_copy

  "<span class='em'><h2>WE ARE</h2></span>
THE EMBODIMENT OF LUXURY— <br>
UNAPOLOGETIC, UNABASHED, UNCOMPROMISING LUXURY. <br>
WE ARE THE ROMANCERS OF THE LAVISH. <br>
THE LOVERS OF THE EXQUISITE. <br>
THE COURTERS OF THE CONTEMPORARY. <br>
METICULOUS WITH DETAILS, RELENTLESS WITH QUALITY, <br>
WE ARE THE NEMESIS OF THE ORDINARY. <br>
ENABLERS OF THE ELEGANT. <br>
MOLDERS OF THE MODERN. <br>
DISCIPLES OF THE PRECISE. <br>
WE ARE THE GUARDIANS OF OLD-WORLD MASTERY. <br>
KEEPERS OF VALUES THAT ARE SET IN STONE— <br>
IN ONYX, IN JASPER, IN AMETHYST. <br>
A TIGHT-KNIT FAMILY OF PATHOLOGICAL PERFECTIONISTS <br>
ALL SHARING THE SAME OBSESSION FOR EXCELLENCE, <br>
PASSING IT DOWN FROM GENERATION TO GENERATION— <br>
CRAFTSMAN TO CRAFTSMAN, <br>
ARTISAN TO ARTISAN, DREAMER TO DREAMER. <br>
ANCHORED BY OUR HISTORY, <br>
PROPELLED INTO THE FUTURE BY OUR HERITAGE, <br>
WE ARE HERE TO SHOWER BRILLIANCE UPON THE WORLD, <br>
TURN ON THE FAUCETS OF IMAGINATION, <br>
WASH AWAY CONFORMISM. <br>
WE ARE HERE TO HELP VISIONS TAKE SHAPE, TAKE FLIGHT, <br>
SAIL THE SEAS OF THE SUBLIME. <br>
WE ARE PURE AMERICAN SPLENDOR. WE ARE <br>
<span class='em'><h2>SHERLE WAGNER</h2></span>".html_safe
  end
end
