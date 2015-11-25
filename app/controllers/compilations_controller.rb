class CompilationsController < ApplicationController
  def show
    @compilation = Compilation.find_by(id: params[:id]) || NullObject.new
  end
end

