class StaticPagesController < ApplicationController
  def index
  end

  def edit_homepage
    @copy = File.read(homepage_copy_file)
  end

  def update_homepage
    copy = params[:home_page_copy]
    File.open(homepage_copy_file, 'w') { |f| f.write copy }
    redirect_to root_path
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
  
  def homepage_copy_file
    'public/home_page_copy.html'
  end
end
