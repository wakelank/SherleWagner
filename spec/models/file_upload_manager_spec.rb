require 'rails_helper'
require 'support/paperclip_stub.rb'
include ActionDispatch::TestProcess

RSpec.describe FileUploadManager, :type => :model do

  describe "Product upload" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      @file_upload_manager = FileUploadManager.new @file
      @file_upload_manager.upload
    end

    it 'adds 9 products to table' do
      Product.all.each { |p| puts p.number }
      expect(Product.count).to eq 9 
    end


  end
end
