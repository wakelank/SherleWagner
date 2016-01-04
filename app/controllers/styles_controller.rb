class StylesController < ApplicationController
  def show
    @style = Style.find(params[:id])
  end
end
