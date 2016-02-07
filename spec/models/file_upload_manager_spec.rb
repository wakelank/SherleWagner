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
      @product = Product.find_by(number: '008BSN108-XX') || :non_product
    end

    it 'adds 9 products to table' do
      expect(Product.count).to eq 9 
    end

       it 'product name' do
      expect(Product.first.name).to eq 'Arco With Arco Lever'
    end

    it "product_type" do
      expect(@product.product_type.name).to eq "Fittings"
    end

    it "assigns associated collection" do
      associated_collection = Style.find_by(name: "Arco")
      expect(@product.associated_collection).to eq associated_collection
    end

    it "assigns one product to Arco" do
      style = Style.find_by(name: "Arco")
      expect(style.products.count).to eq 1
    end

    it "product_type" do
      expect(@product.product_type.name).to eq "Fittings"
    end

    it "product_sub_type" do
      expect(@product.product_sub_type.name).to eq "Basin Sets"
    end
    it "filter_values" do
      expect(@product.filter_values.first.name).to eq "Levers"
    end
    it "finishes" do
      expect(@product.finishes.count).to be 20
    end
    it "china color" do
      product_with_china_colors = Product.find_by(number: '1029BSN821-04CC-XX') || :non_product
      expect(product_with_china_colors.china_colors.count).to be 4
    end
    it "materials with material code SLSL" do
      product_with_materials = Product.find_by(number: '008BSN108-SLSL-XX') || :non_product
      expect(product_with_materials.materials.count).to be 6
    end
    it "materials with material code CHINAMETAL" do
      product_with_chinametal = Product.find_by(number: 'UE15-CHINAMETAL-CC') || :non_product
      expect(product_with_chinametal.materials.count).to be 3 
    end
    it "style" do
      expect(@product.styles.first.name).to eq "Arco"
    end
    it "genre" do
      expect(@product.genres.first.name).to eq "Contemporary"
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
  
  describe "Product upload" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      file_upload_manager = FileUploadManager.new @file
      file_upload_manager.upload
      @product = Product.find_by(number: '008BSN108-XX') || :non_product
    end
    
    it "image" do
      expect(@product.image_file_name).to eq "008BSN108-CP.jpg"
    end
  end
end
