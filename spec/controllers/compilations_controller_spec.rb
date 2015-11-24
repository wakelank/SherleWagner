require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  describe "Product upload" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      request.env["HTTP_REFERER"] = products_upload_page_path
    end

    it 'add compilation to database' do
      expect{ post :upload_product_file, :controller => :products, :filename => @file }.to change(Compilation, :count).by(1)
    end

    it 'assigns compilation name' do
      post :upload_product_file, :controller => :products, :filename => @file 
      expect(Compilation.first.name).to eq 'Concentric Shower Suite One'
    end


  end
end
