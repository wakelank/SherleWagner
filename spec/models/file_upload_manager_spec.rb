require 'rails_helper'
require 'support/paperclip_stub.rb'
include ActionDispatch::TestProcess

RSpec.describe FileUploadManager, :type => :model do

  describe "Product upload" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      file_upload_manager = FileUploadManager.new @file
      allow(file_upload_manager).to receive(:get_image_from_aws).and_return(NullObject.new)
      file_upload_manager.upload
    end

    it 'adds 9 products to table' do
      expect(Product.count).to eq 9 
    end

    it "product_configuration" do
      @product_with_configurations = Product.find_by(number: '008BSN108-SLSL-XX')
      expect(@product_with_configurations.product_configurations.pluck(:number).sort).to eq ["008BSN108-BLTI-CP","008BSN108-RHOD-CP"]
    end 

    it 'compilation' do
      @compilation = Product.find_by(number: "T101-CTS-XX")
      expect((@compilation.components).map { |comp| comp.number }.sort).to eq ['101-SHHD-XX','101TUB-XX','T101-001-TMT-XX']
    end

    it 'components' do
      compilation = Product.find_by(number: "T101-CTS-TUB-SHR-CP")
      component = Product.find_by(number: '101-SHHD-XX')
      expect((component.compilations).pluck(:number).sort).to eq ['T101-CTS-008-SHR-HS-CP', 'T101-CTS-TUB-SHR-CP']
    end

    it 'no_name_products' do
      compilation = Product.find_by(number: "T101-CTS-XX")
      components = compilation.all_components.map { |comp| comp[:name] }.sort
      expect(components).to eq ["Arco Lever Diverter Trim", "Modern Concentric Thermostatic Trim", "Modern Concentric Trim With Diverter", "Modern Cylindrical Wall Mount Hand Shower on Supply Hook", "Modern Shower Head With Square Flange", "Modern Wall Mount Tub Spout"]   
    end


  end
end
