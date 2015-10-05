require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "Product upload" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      request.env["HTTP_REFERER"] = products_upload_page_path
    end

    it "uploading product file adds products to database" do
      expect{ post :upload_product_file, :controller => :products, :filename => @file }.to change(Product, :count).by(3)
    end

    it 'uploads the product name from data file' do
      post :upload_product_file, :controller => :products, :filename => @file 
      expect(Product.first.name).to eq 'Grey Series I Tub Shower Set'
    end
    it "uploads the product type"
    it "uploads the product sub-type"
    it "uploads the product_group"
    it "attaches the filters to the product group"
    it "attaches the materials to the product group"
    it "attaches the filters to the product group"
  end
end
