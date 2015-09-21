require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  before :each do
    @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
    @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
    request.env["HTTP_REFERER"] = products_upload_page_path
  end

  it "uploading product file adds products to database" do
    expect{ post :upload_product_file, :controller => :products, :filename => @file }.to change(Product, :count).by(3)
  end
end
