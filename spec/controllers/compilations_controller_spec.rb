require 'rails_helper'
require 'support/paperclip_stub.rb'

RSpec.describe ProductsController, :type => :controller do

  describe "Product upload" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      request.env["HTTP_REFERER"] = products_upload_page_path
    end

    it 'add compilation to database' do
      expect{ post :upload_product_file, :controller => :products, :filename => @file }.to change(Compilation, :count).by(2)
    end

    it 'assigns compilation name' do
      post :upload_product_file, :controller => :products, :filename => @file 
      expect(Compilation.first.name).to eq 'Concentric Shower Suite One'
    end

    it 'assigns products to compilation' do
      post :upload_product_file, :controller => :products, :filename => @file 
      expect((Compilation.first.products).pluck(:number).sort).to eq ['101-SHHD-XX','101TUB-XX','T101-001-TMT-XX']
    end

    it 'assigns associated compilations to new compilation' do
      post :upload_product_file, :controller => :products, :filename => @file 
      expect(Compilation.first.associated_compilations).to include Compilation.second
    end

    it 'associates new compilation with existing compilations' do
      post :upload_product_file, :controller => :products, :filename => @file 
      expect(Compilation.second.associated_compilations).to include Compilation.first
    end


  end
end
